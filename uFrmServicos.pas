unit uFrmServicos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Rtti, FMX.Grid, FMX.Layouts, FMX.StdCtrls, FMX.ListBox;

type
  TfrmServicos = class(TForm)
    pnlLateral: TPanel;
    grdServicos: TGrid;
    ColunaServicos: TColumn;
    ColunaExcluirItem: TImageColumn;
    Header: TToolBar;
    cbServicos: TComboBox;
    spdAdd: TSpeedButton;
    spdOk: TSpeedButton;
    procedure btnVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmServicos: TfrmServicos;

implementation

 uses uFrmFormulario;

{$R *.fmx}

procedure TfrmServicos.btnVoltarClick(Sender: TObject);
begin
 Close;
end;

procedure TfrmServicos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 FreeAndNil(frmServicos);
end;

end.
