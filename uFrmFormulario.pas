unit uFrmFormulario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.DateTimeCtrls, FMX.StdCtrls, FMX.Layouts, System.Rtti, FMX.Grid,
  FMX.ListBox, FMX.Memo, FMX.Edit, FMX.ListView.Types, FMX.ListView, uAcao,uFrmservicos,
  FMX.Objects;

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
    btnSalvar: TButton;
    btnVoltar: TButton;
    dtChegada: TCalendarEdit;
    dtSaida: TCalendarEdit;
    memoObs: TMemo;
    edtDescricaoRapida: TEdit;
    ReTanguloFundo: TRectangle;
    pnlDescricaoRapida: TPanel;
    btnAddServico: TButton;
    procedure btnAddServicoClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
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


{$R *.fmx}

procedure TfrmFormulario.btnAddServicoClick(Sender: TObject);

begin
 if frmServicos = nil then
 begin
	frmServicos := TfrmServicos.Create(Self);
 end;
	try
	 frmServicos.Show;
  finally
	 frmServicos.Free;
	end;



end;

procedure TfrmFormulario.btnVoltarClick(Sender: TObject);
begin
 Close;
end;

procedure TfrmFormulario.DesabilitaEdicao;
begin
 dtChegada.ReadOnly          := True;
 HorasChegada.ReadOnly       := True;
 dtSaida.ReadOnly            := True;
 HorasSaida.ReadOnly         := True;
 edtDescricaoRapida.ReadOnly := True;
 btnAddServico.Enabled       := False;
 memoObs.ReadOnly            := True
end;

procedure TfrmFormulario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 FreeAndNil(frmFormulario);
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
end;

procedure TfrmFormulario.NovaAcao;
begin
 dtChegada.Date    := now;
 HorasChegada.Time := now;
 dtSaida.Date      := now;
 HorasSaida.Time   := now;
end;

procedure TfrmFormulario.RecebeNoticia(Acao: TAcao);
var
 i : integer;
begin
 dtChegada.Date          := Acao.dtChegada;
 HorasChegada.Time       := Acao.hsChegada;
 dtSaida.Date            := Acao.dtSaida;
 HorasSaida.Time         := Acao.hsSaida;
 edtDescricaoRapida.Text := Acao.DescricaoRapida;
 for i := 0to acao.listaServicosRealizados.Count - 1 do
 begin
   //Adicionar os itens na grid
 end;
 memoObs.Lines.Text := Acao.Observacoes;
end;

end.
