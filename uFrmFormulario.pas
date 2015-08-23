unit uFrmFormulario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.DateTimeCtrls, FMX.StdCtrls, FMX.Layouts, System.Rtti, FMX.Grid,
  FMX.ListBox, FMX.Memo, FMX.Edit,FMX.Ani, FMX.ListView.Types, FMX.ListView, uAcao,uFrmservicos,
  FMX.Objects, uDmPrincipal;

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
    spdSalvar: TButton;
    dtChegada: TCalendarEdit;
    dtSaida: TCalendarEdit;
    memoObs: TMemo;
    pnlDescricaoRapida: TPanel;
    btnAddServico: TButton;
    spdVoltar: TSpeedButton;
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
    procedure spdVoltarClick(Sender: TObject);
    procedure spdSalvarClick(Sender: TObject);
    procedure edtNumOrdemServicoClick(Sender: TObject);
    procedure edtNumOrdemServicoExit(Sender: TObject);
  private
   var
    CaminhoListaInicialClientes : String;
    FTecladoShow : Boolean;
    procedure ValidaEditVazioDescricao;
    procedure ValidaEditVazuiNumOrdServico;
    { Private declarations }
  public
   procedure RecebeNoticia(Acao : TAcao);
   procedure NovaAcao;
   procedure HabilitaEdicao;
   procedure DesabilitaEdicao;
    { Public declarations }
  end;

var
  frmFormulario: TfrmFormulario;

implementation

  uses ufrmPrincipal;

{$R *.fmx}

procedure TfrmFormulario.btnAddServicoClick(Sender: TObject);
begin
 if frmServicos = nil then
 begin
   frmServicos := TfrmServicos.Create(Self);
 end;
 frmServicos.Show;
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
 edtDescricaoRapida.Tag := 1; //Edit sem a descri��o auxiliar em cor menos vis�vel

 if frmServicos = nil then
 begin
	frmServicos := TfrmServicos.Create(Self);
 end;

end;

procedure TfrmFormulario.FormShow(Sender: TObject);
begin
 ValidaEditVazioDescricao;
 ValidaEditVazuiNumOrdServico;
end;

procedure TfrmFormulario.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
 FTecladoShow := false;
  if not KeyboardVisible then
  begin
   AnimateFloat('Padding.Top', 0, 0.1);
  end;
end;

procedure TfrmFormulario.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
var
     O: TFMXObject;
begin
{ Mover o controle onde se digita algo para cima do teclado, para se poder ver
 o que � digitado }
 FTecladoShow := true;
 if Assigned(Focused) and (Focused.GetObject is TControl) then
 begin
  if TControl(Focused).AbsoluteRect.Bottom - Padding.Top >= (Bounds.Top ) then
  begin
   for O in Children do
   begin
    if (O is TFloatAnimation) and (TFloatAnimation(O).PropertyName = 'Padding.Top') then
    begin
     TFloatAnimation(O).StopAtCurrent;
    end;
    AnimateFloat('Padding.Top',Bounds.Top -  TControl(Focused).AbsoluteRect.Bottom + Padding.Top, 0.1)
   end;
  end;
 end
 else
 begin
  AnimateFloat('Padding.Top', 0, 0.1);
 end;
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
end;

procedure TfrmFormulario.NovaAcao;
begin
 dtChegada.Date    := now;
 HorasChegada.Time := now;
 dtSaida.Date      := now;
 HorasSaida.Time   := now;

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

procedure TfrmFormulario.spdSalvarClick(Sender: TObject);
begin
 if frmServicos.ListBoxServicos.Items.Count = 0 then
 begin
   if MessageDlg('N�o h� informa��o sobre quais servi�os foram realizados, deseja salvar assim mesmo?'
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

procedure TfrmFormulario.spdVoltarClick(Sender: TObject);
begin
 frmPrincipal.Show;
end;

procedure TfrmFormulario.ValidaEditVazioDescricao;
begin
 if edtDescricaoRapida.Text.IsEmpty then
 begin
   edtDescricaoRapida.Text      := 'Insira uma descri��o r�pida';
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
   edtNumOrdemServico.Text      := 'Insira o n�mero da ordem de servi�o';
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
