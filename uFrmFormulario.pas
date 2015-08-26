unit uFrmFormulario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.DateTimeCtrls, FMX.StdCtrls, FMX.Layouts, System.Rtti, FMX.Grid,
  FMX.ListBox, FMX.Memo, FMX.Edit,FMX.Ani, FMX.ListView.Types, FMX.ListView, uAcao,uFrmservicos,
  FMX.Objects, uDmPrincipal, FMX.Effects;

type
  TfrmFormulario = class(TForm)
    Header: TToolBar;
    HeaderLabel: TLabel;
    scrollPrincipal: TVertScrollBox;
    pnlDataHoraChegada: TPanel;
    Label1: TLabel;
    HorasChegada: TTimeEdit;
    pnlDataHoraSaida: TPanel;
    Label2: TLabel;
    HorasSaida: TTimeEdit;
    Label3: TLabel;
    dtChegada: TCalendarEdit;
    dtSaida: TCalendarEdit;
    memoObs: TMemo;
    pnlDescricaoRapida: TPanel;
    btnAddServico: TButton;
    Label4: TLabel;
    cbCliente: TComboBox;
    pnlLateral: TPanel;
    lblAutor: TLabel;
    pnlOrdemDeServico: TPanel;
    edtDescricaoRapida: TEdit;
    edtNumOrdemServico: TEdit;
    lblDescricao: TLabel;
    lblNumOrdemServico: TLabel;
    btnMensagens: TButton;
    imgSalvar: TImage;
    imgVoltar: TImage;
    imgAddServico: TImage;
    imgMensagem: TImage;
    lblEquipamento: TLabel;
    pnlEquipamento: TPanel;
    edtEquip: TEdit;
    procedure btnAddServicoClick(Sender: TObject);
    procedure edtDescricaoRapidaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CriarListaInicialClientes;
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormShow(Sender: TObject);
    procedure edtDescricaoRapidaExit(Sender: TObject);
    procedure edtNumOrdemServicoClick(Sender: TObject);
    procedure edtNumOrdemServicoExit(Sender: TObject);
    procedure imgSalvarClick(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
  private
   var
    CaminhoListaInicialClientes : String;
    FTecladoShow : Boolean;
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
   procedure RecebeNoticia(Acao : TAcao);
   procedure NovaNoticia;
   procedure HabilitaEdicao;
   procedure DesabilitaEdicao;
    { Public declarations }
  end;

var
  frmFormulario: TfrmFormulario;

implementation

  uses ufrmPrincipal,Math;

{$R *.fmx}

procedure TfrmFormulario.btnAddServicoClick(Sender: TObject);
begin
 if frmServicos = nil then
 begin
   frmServicos := TfrmServicos.Create(Self);
 end;
 frmServicos.Show;
end;

procedure TfrmFormulario.CalcContentBoundsProc(Sender: TObject;
  var ContentBounds: TRectF);
begin
  if FNeedOffset and (FKBBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom,
                                2 * ClientHeight - FKBBounds.Top);
  end;
end;

procedure TfrmFormulario.CriarListaInicialClientes;
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

procedure TfrmFormulario.DesabilitaEdicao;
begin
 dtChegada.ReadOnly          := True;
 HorasChegada.ReadOnly       := True;
 dtSaida.ReadOnly            := True;
 HorasSaida.ReadOnly         := True;
 edtDescricaoRapida.ReadOnly := True;
 btnAddServico.Enabled       := False;
 memoObs.ReadOnly            := True;
 cbCliente.Enabled           := False;
 btnMensagens.Enabled        := False;
 edtNumOrdemServico.ReadOnly := True;
end;

procedure TfrmFormulario.edtDescricaoRapidaClick(Sender: TObject);
begin
 if edtDescricaoRapida.Tag = 0 then
 begin
   edtDescricaoRapida.Text := EmptyStr;
 end;
end;

procedure TfrmFormulario.edtDescricaoRapidaExit(Sender: TObject);
begin
 ValidaEditVazioDescricao;
end;

procedure TfrmFormulario.edtNumOrdemServicoClick(Sender: TObject);
begin
 if edtDescricaoRapida.Tag = 0 then
 begin
   edtDescricaoRapida.Text := EmptyStr;
 end;

end;

procedure TfrmFormulario.edtNumOrdemServicoExit(Sender: TObject);
begin
 ValidaEditVazuiNumOrdServico;
end;

procedure TfrmFormulario.FormCreate(Sender: TObject);
begin
 CaminhoListaInicialClientes := dmPrincipal.CAMINHO_ARQUIVOS_MYDEED + '/Clientes.txt';

 if not FileExists(CaminhoListaInicialClientes) then
 begin
   CriarListaInicialClientes;
 end;
 cbCliente.Items.LoadFromFile(CaminhoListaInicialClientes);
 edtDescricaoRapida.Tag := 1; //Edit sem a descrição auxiliar em cor menos visível

 if frmServicos = nil then
 begin
	frmServicos := TfrmServicos.Create(Self);
 end;

 scrollPrincipal.OnCalcContentBounds := CalcContentBoundsProc;

end;

procedure TfrmFormulario.FormShow(Sender: TObject);
begin
 ValidaEditVazioDescricao;
 ValidaEditVazuiNumOrdServico;
end;

procedure TfrmFormulario.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := False;
  RestorePosition;
end;

procedure TfrmFormulario.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds := TRectF.Create(Bounds);
  FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
  UpdateKBBounds;
end;

procedure TfrmFormulario.HabilitaEdicao;
begin
 dtChegada.ReadOnly          := False;
 HorasChegada.ReadOnly       := False;
 dtSaida.ReadOnly            := False;
 HorasSaida.ReadOnly         := False;
 edtDescricaoRapida.ReadOnly := False;
 btnAddServico.Enabled       := True;
 memoObs.ReadOnly            := False;
 cbCliente.Enabled           := True;
 btnMensagens.Enabled        := True;
 edtNumOrdemServico.ReadOnly := False;
end;

procedure TfrmFormulario.imgSalvarClick(Sender: TObject);
begin
 if frmServicos.ListBoxServicos.Items.Count = 0 then
 begin
   if MessageDlg('Não há informação sobre quais serviços foram realizados, deseja salvar assim mesmo?'
      , TMsgDlgType.mtWarning, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0) = mrYes then
   begin
    ShowMessage('Salvo com sucesso!');
    frmPrincipal.Show;
   end
   else
   begin

   end;




 end;
end;

procedure TfrmFormulario.imgVoltarClick(Sender: TObject);
begin
 frmPrincipal.Show;
end;

procedure TfrmFormulario.NovaNoticia;
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

procedure TfrmFormulario.RecebeNoticia(Acao: TAcao);
begin
 dtChegada.Date                         := Acao.dtChegada;
 HorasChegada.Time                      := Acao.hsChegada;
 dtSaida.Date                           := Acao.dtSaida;
 HorasSaida.Time                        := Acao.hsSaida;
 edtDescricaoRapida.Text                := Acao.DescricaoRapida;
 frmServicos.ListBoxServicos.Items.Text := Acao.listaServicosRealizados.Text;
 lblAutor.Text                          := 'Autor : ' + Acao.Autor;
 memoObs.Lines.Text                     := Acao.Observacoes;
 cbCliente.ItemIndex                    := cbCliente.Items.IndexOf(Acao.Cliente);
end;

procedure TfrmFormulario.RestorePosition;
begin
  scrollPrincipal.ViewportPosition := PointF(scrollPrincipal.ViewportPosition.X, 0);
//  MainLayout1.Align := TAlignLayout.alClient;
  scrollPrincipal.RealignContent;
end;

procedure TfrmFormulario.UpdateKBBounds;
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

procedure TfrmFormulario.ValidaEditVazioDescricao;
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

procedure TfrmFormulario.ValidaEditVazuiNumOrdServico;
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
