unit uFrmMensagens;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Objects, FMX.Memo,uDmPrincipal;

type
  TfrmMensagens = class(TForm)
    VertScrollBoxFundo: TVertScrollBox;
    Header: TToolBar;
    lblDescricaoNoticia: TLabel;
    lblCodNoticia: TLabel;
    pnlAutorMensagem: TPanel;
    lblAutorMensagem: TLabel;
    lblDataMensagem: TLabel;
    pnlMensagemPrincipal: TPanel;
    RetanguloMensagem: TRectangle;
    MemoMensagem: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMensagens: TfrmMensagens;

implementation

{$R *.fmx}

end.
