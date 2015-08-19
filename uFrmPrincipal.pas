unit uFrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Header, FMX.Layouts,uAcao;

type
  TfrmPrincipal = class(TForm)
    VertScrollBoxFundo: TVertScrollBox;
    Header: THeader;
    lblTitulo: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    lblAutor: TLabel;
    lblDataHora: TLabel;
    Label5: TLabel;
    lblDescricao: TLabel;
    lblCodigo: TLabel;
  private
    { Private declarations }

   procedure AbrirNoticia(Sender : TObject; PertenceAoUsuario:boolean);  // m�todo que ser� atribu�do para os novos paineis

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

 uses uFrmFormulario;

{ TfrmPrincipal }

procedure TfrmPrincipal.AbrirNoticia(Sender: TObject;PertenceAoUsuario:boolean);
var
 DadosNoticia : TAcao;
begin
 DadosNoticia  := TAcao.Create;
 frmFormulario := TfrmFormulario.Create(Self);
 try
  {Passar para o DadosNoticia os valores de suas variaveis publicas,
   atrav�s da busca pelo c�digo
  }

  if PertenceAoUsuario then
  begin
   frmFormulario.HabilitaEdicao;
  end
  else
  begin
   frmFormulario.DesabilitaEdicao;
  end;
 frmFormulario.RecebeNoticia(DadosNoticia);
 frmFormulario.ShowModal;
 finally
  DadosNoticia.Free;
  frmFormulario.Free;
 end;

end;



end.
