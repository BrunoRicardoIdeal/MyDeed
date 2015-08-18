unit uFrmServicos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Rtti, FMX.Grid, FMX.Layouts, FMX.StdCtrls;

type
  TfrmServicos = class(TForm)
    grdServicos: TGrid;
    ColunaServicos: TColumn;
    ColunaMarcacao: TCheckColumn;
    btnAdicionar: TButton;
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

end.
