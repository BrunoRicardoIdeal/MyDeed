unit uFrmFormulario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.DateTimeCtrls, FMX.StdCtrls, FMX.Layouts, System.Rtti, FMX.Grid,
  FMX.ListBox, FMX.Memo;

type
  TfrmFormulario = class(TForm)
    Header: TToolBar;
    HeaderLabel: TLabel;
    scrollPrincipal: TVertScrollBox;
    pnlDataHoraChegada: TPanel;
    dtChegada: TDateEdit;
    Label1: TLabel;
    HorasChegada: TTimeEdit;
    pnlDataHoraSaida: TPanel;
    dtSaida: TDateEdit;
    Label2: TLabel;
    HorasSaida: TTimeEdit;
    pnlServicosRealizados: TPanel;
    grdServicosRealizados: TGrid;
    btnAddServico: TButton;
    grdServicoscollServico: TColumn;
    Label3: TLabel;
    memoObs: TMemo;
    btnSalvar: TButton;
    btnCancelar: TButton;
    procedure btnAddServicoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFormulario: TfrmFormulario;

implementation

 uses uFrmServicos;

{$R *.fmx}

procedure TfrmFormulario.btnAddServicoClick(Sender: TObject);

begin
 if frmServicos = nil then
 begin
	frmServicos := TfrmServicos.Create(Self);
 end;
	try
	 frmServicos.ShowModal;
  finally
	 frmServicos.Free;
	end;


end;

end.
