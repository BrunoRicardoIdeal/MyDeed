unit uFrmRegister;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, FMX.Edit, FMX.Header;

type
  TfrmRegister = class(TForm)
    Label1: TLabel;
    edtLogin: TEdit;
    Label2: TLabel;
    edtSenha: TEdit;
    Label3: TLabel;
    edtConfirmarSenha: TEdit;
    Header: TToolBar;
    HeaderLabel: TLabel;
    btnSalvar: TButton;
    btnCancelar: TButton;
    Label4: TLabel;
    edtCPF: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRegister: TfrmRegister;

implementation

{$R *.fmx}

end.
