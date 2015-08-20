unit uFrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Header, FMX.Layouts,uAcao,uDmPrincipal, FMX.Objects;

type
  TfrmPrincipal = class(TForm)
    VertScrollBoxFundo: TVertScrollBox;
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    StyleBookFeed: TStyleBook;
    CallPnlNoticiaPrincipal: TCalloutPanel;
    pnlNoticiaBot: TPanel;
    lblDescricao: TLabel;
    lblDescricaoTit: TLabel;
    pnlNoticiaMid: TPanel;
    lblAutor: TLabel;
    lblAutorTit: TLabel;
    pnlNoticiaTop: TPanel;
    lblDataHora: TLabel;
    lblCodigo: TLabel;
    LineSeparador: TLine;
    tmrAtualizaFeed: TTimer;
    procedure tmrAtualizaFeedTimer(Sender: TObject);
  private
    { Private declarations }
   procedure AbrirNoticia(Sender : TObject; PertenceAoUsuario:boolean);  // método que será atribuído para os novos paineis
   var
    nCallPnlNoticiaPrincipal : TCalloutPanel;
    nPnlNoticiaTop,nPnlNoticiaMid ,nPnlNoticiaBot : TPanel;
    nLineSeparador : TLine;
    nlblCodigo,nlblDataHora,nlblAutorTit,nlblAutor,nlblDescricaoTit,nlblDescricao :TLabel;

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
   através da busca pelo código
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
  frmFormulario.DisposeOf;
 end;

end;





procedure TfrmPrincipal.tmrAtualizaFeedTimer(Sender: TObject);
begin

nCallPnlNoticiaPrincipal := TCalloutPanel.Create(VertScrollBoxFundo);
nCallPnlNoticiaPrincipal.Align := TAlignLayout.alTop;
nCallPnlNoticiaPrincipal.Height := 120;

end;

end.
