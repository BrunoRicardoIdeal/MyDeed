unit uFrmNoticia;

Interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.DateTimeCtrls, FMX.StdCtrls, FMX.Layouts, System.Rtti, FMX.Grid,
  FMX.ListBox, FMX.Memo, FMX.Edit,FMX.Ani, FMX.ListView.Types, FMX.ListView, uServico,
  FMX.Objects, uDmPrincipal, FMX.Effects, FMX.ScrollBox, FMX.ComboEdit,
  FMX.CalendarEdit, FMX.Controls.Presentation;

type
  TfrmNoticia = class(TForm)
    scrollPrincipal: TVertScrollBox;
    pnlDataHoraChegada: TPanel;
    Label1: TLabel;
    HorasChegada: TTimeEdit;
    pnlDataHoraSaida: TPanel;
    Label2: TLabel;
    HorasSaida: TTimeEdit;
    dtSaida: TDateEdit;
    Label3: TLabel;
    memoObs: TMemo;
    pnlDescricaoRapida: TPanel;
    edtDescricaoRapida: TEdit;
    lblDescricao: TLabel;
    btnAddAcao: TButton;
    imgAddAcao: TImage;
    Label4: TLabel;
    lblAutor: TLabel;
    pnlOrdemDeServico: TPanel;
    edtNumOrdemServico: TEdit;
    lblNumOrdemServico: TLabel;
    btnMensagens: TButton;
    imgMensagem: TImage;
    pnlEquipamento: TPanel;
    lblEquipamento: TLabel;
    edtEquip: TEdit;
    pnlLateral: TPanel;
    Header: TToolBar;
    HeaderLabel: TLabel;
    imgSalvar: TImage;
    imgVoltar: TImage;
    dtChegada: TDateEdit;
    StyleBook1: TStyleBook;
    cbCliente: TComboBox;
    ShadowEffect1: TShadowEffect;
    procedure FormCreate(Sender: TObject);
    procedure CriarListaInicialClientes;
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormShow(Sender: TObject);
    procedure imgSalvarClick(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
    procedure btnAddAcaoClick(Sender: TObject);
    procedure imgAddAcaoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
   var
    CaminhoListaInicialClientes : String;
    listaAcoesRealizadas :String;
    procedure ValidaEditVazioDescricao;
    procedure ValidaEditVazuiNumOrdServico;
    procedure UpdateKBBounds;
    procedure RestorePosition;
    procedure CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF);
   { Private declarations }
   var
    FKBBounds: TRectF;
    FNeedOffset: Boolean;
  public
   procedure RecebeNoticia(Servico : TServico);
   procedure NovaNoticia;
   procedure HabilitaEdicao;
   procedure DesabilitaEdicao;
    { Public declarations }
  end;

var
  frmNoticia: TfrmNoticia;

implementation

  uses uFrmFeed,Math, uFrmAcoes;

{$R *.fmx}

procedure TfrmNoticia.btnAddAcaoClick(Sender: TObject);
begin
 if not Assigned(frmAcoes)then
 begin
   frmAcoes := TfrmAcoes.Create(Self);
 end;
 frmAcoes.ListBoxAcoes.Items.Text := listaAcoesRealizadas;
 frmAcoes.Show;
end;



procedure TfrmNoticia.CalcContentBoundsProc(Sender: TObject;
  var ContentBounds: TRectF);
begin
  if FNeedOffset and (FKBBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom,
                                2 * ClientHeight - FKBBounds.Top);
  end;
end;

procedure TfrmNoticia.CriarListaInicialClientes;
 var
  ListaInicial : TStringList;
begin
 ListaInicial := TStringList.Create;
 try
  ListaInicial.Add('Ed. Excalibur');
  ListaInicial.Add('Cond. Portal dos Lagos');
  ListaInicial.SaveToFile(CaminhoListaInicialClientes);
 finally
   ListaInicial.Free;
 end;
end;

procedure TfrmNoticia.DesabilitaEdicao;
begin
 dtChegada.ReadOnly          := True;
 HorasChegada.ReadOnly       := True;
 dtSaida.ReadOnly            := True;
 HorasSaida.ReadOnly         := True;
 edtDescricaoRapida.ReadOnly := True;
 btnAddAcao.Enabled       := False;
 memoObs.ReadOnly            := True;
 cbCliente.Enabled           := False;
 btnMensagens.Enabled        := False;
 edtNumOrdemServico.ReadOnly := True;
end;

procedure TfrmNoticia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 frmFeed.Show;
 Action     := TCloseAction.caFree;
 frmAcoes   := nil;
 frmNoticia := nil;
end;

procedure TfrmNoticia.FormCreate(Sender: TObject);
begin
 CaminhoListaInicialClientes := dmPrincipal.CAMINHO_ARQUIVOS_MYDEED + '/Clientes.txt';

 if not FileExists(CaminhoListaInicialClientes) then
 begin
   CriarListaInicialClientes;
 end;
 cbCliente.Items.LoadFromFile(CaminhoListaInicialClientes);
 edtDescricaoRapida.Tag := 1; //Edit sem a descrição auxiliar em cor menos visível

 if not Assigned(FrmAcoes) then
 begin
	FrmAcoes := TFrmAcoes.Create(Self);
 end;

 scrollPrincipal.OnCalcContentBounds := CalcContentBoundsProc;


end;

procedure TfrmNoticia.FormDestroy(Sender: TObject);
begin
  FreeAndNil(frmAcoes);
end;

procedure TfrmNoticia.FormShow(Sender: TObject);
var
 i : Integer;
begin
 for i := 0 to cbCliente.Items.Count -1 do
 begin
  cbCliente.ListBox.ListItems[i].Font.Size := 16;
  cbCliente.ListBox.ListItems[1].StyledSettings := [];
 end;
 cbCliente.Repaint;
end;

procedure TfrmNoticia.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := False;
  RestorePosition;
end;

procedure TfrmNoticia.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds := TRectF.Create(Bounds);
  FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
  UpdateKBBounds;
end;

procedure TfrmNoticia.HabilitaEdicao;
begin
 dtChegada.ReadOnly          := False;
 HorasChegada.ReadOnly       := False;
 dtSaida.ReadOnly            := False;
 HorasSaida.ReadOnly         := False;
 edtDescricaoRapida.ReadOnly := False;
 btnAddAcao.Enabled       := True;
 memoObs.ReadOnly            := False;
 cbCliente.Enabled           := True;
 btnMensagens.Enabled        := True;
 edtNumOrdemServico.ReadOnly := False;
end;

procedure TfrmNoticia.imgAddAcaoClick(Sender: TObject);
begin
 btnAddAcaoClick(sender);
end;

procedure TfrmNoticia.imgSalvarClick(Sender: TObject);
begin
 ShowMessage('Salvo com sucesso!');
 Close;
end;

procedure TfrmNoticia.imgVoltarClick(Sender: TObject);
begin
 Close;
end;

procedure TfrmNoticia.NovaNoticia;
begin
 dtChegada.Date    := now;
 HorasChegada.Time := now;
 dtSaida.Date      := now;
 HorasSaida.Time   := now;
 cbCliente.ItemIndex := -1;
 edtDescricaoRapida.Text := EmptyStr;
 edtNumOrdemServico.Text := EmptyStr;
 memoObs.lines.Text  := EmptyStr;
 lblAutor.Text := 'Autor: ' + dmPrincipal.NomeUsuarioLogado;

end;

procedure TfrmNoticia.RecebeNoticia(Servico: TServico);
begin
 dtChegada.Date                         := StrToDate(FormatDateTime('dd/mm/yyyy',Servico.dtChegada));
 HorasChegada.Time                      := StrToTime(FormatDateTime('HH:MM',Servico.dtChegada));
 dtSaida.Date                           := StrToDate(FormatDateTime('dd/mm/yyyy',Servico.dtSaida));
 HorasSaida.Time                        := StrToTime(FormatDateTime('HH:MM',Servico.dtSaida));
 edtDescricaoRapida.Text                := Servico.DescricaoRapida;
 listaAcoesRealizadas                   := Servico.listaAcoesRealizadas.Text;
 lblAutor.Text                          := 'Autor : ' + Servico.Autor;
 memoObs.Lines.Text                     := Servico.Observacoes;
 cbCliente.ItemIndex                    := cbCliente.Items.IndexOf(Servico.Cliente);
end;

procedure TfrmNoticia.RestorePosition;
begin
  scrollPrincipal.ViewportPosition := PointF(scrollPrincipal.ViewportPosition.X, 0);
//  MainLayout1.Align := TAlignLayout.alClient;
  scrollPrincipal.RealignContent;
end;

procedure TfrmNoticia.UpdateKBBounds;
var
  LFocused : TControl;
  LFocusRect: TRectF;
begin
  FNeedOffset := False;
  if Assigned(Focused) then
  begin
    LFocused := TControl(Focused.GetObject);
    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(scrollPrincipal.ViewportPosition);
    if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and (LFocusRect.Bottom > FKBBounds.Top) then
    begin
      FNeedOffset := True;
     // MainLayout1.Align := TAlignLayout.alHorizontal;
      scrollPrincipal.RealignContent;
      Application.ProcessMessages;
      scrollPrincipal.ViewportPosition := PointF(scrollPrincipal.ViewportPosition.X,  2* (LFocusRect.Bottom - FKBBounds.Top));
    end;
  end;
  if not FNeedOffset then
    RestorePosition;
end;

procedure TfrmNoticia.ValidaEditVazioDescricao;
begin
 if edtDescricaoRapida.Text.IsEmpty then
 begin
   edtDescricaoRapida.Text      := 'Insira uma descrição rápida';
   edtDescricaoRapida.FontColor := TAlphaColorRec.DarkGray;
   edtDescricaoRapida.Tag       := 0;   //Edit com o texto auxiliar
 end
 else
 begin
  edtDescricaoRapida.FontColor := TAlphaColorRec.Black;
  edtDescricaoRapida.Tag       := 1;
 end;
end;

procedure TfrmNoticia.ValidaEditVazuiNumOrdServico;
begin
  if edtNumOrdemServico.Text.IsEmpty then
 begin
   edtNumOrdemServico.Text      := 'Insira o número da ordem de serviço';
   edtNumOrdemServico.FontColor := TAlphaColorRec.DarkGray;
   edtNumOrdemServico.Tag       := 0;   //Edit com o texto auxiliar
 end
 else
 begin
  edtNumOrdemServico.FontColor := TAlphaColorRec.Black;
  edtNumOrdemServico.Tag       := 1;
 end;
end;

end.
