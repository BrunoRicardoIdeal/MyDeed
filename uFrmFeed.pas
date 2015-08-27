unit ufrmFeed;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Header, FMX.Layouts,uDmPrincipal, FMX.Objects, FMX.Ani, FMX.ExtCtrls,
  FMX.Effects, FMX.Edit, FMX.Controls.Presentation,uServico;

type
  TfrmFeed = class(TForm)
    VertScrollBoxFundo: TVertScrollBox;
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    tmrAtualizaFeed: TTimer;
    SpeedButton1: TSpeedButton;
    RetanguloMenu: TRectangle;
    lblNovo: TLabel;
    AniFloatMenu: TFloatAnimation;
    retanguloNovo: TRectangle;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    imgNovo: TImage;
    imgMenu: TImage;
    pnlPesquisa: TPanel;
    imgPesquisar: TImage;
    edtPesquisar: TEdit;
    ShadowEffect3: TShadowEffect;
    procedure tmrAtualizaFeedTimer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure spdNovoClick(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
   procedure AbrirNoticia(Sender : TObject; PertenceAoUsuario:boolean);
   procedure CriaNovaNoticia(var Servico :TServico);
   procedure CriaComponentesNoticia(Acao: TServico);
   procedure EventoClickPanelNoticia(Sender : TObject);
   var
    nCallPnlNoticiaPrincipal : TCalloutPanel;
    nPnlNoticiaTop,nPnlNoticiaMid ,nPnlNoticiaBot : TPanel;
    nLineSeparador : TLine;
    nlblCodigo,nlblDataHora,nlblAutorTit,nlblAutor,nlblDescricaoTit,nlblDescricao :TLabel;

    teste : Integer ;

  public
    { Public declarations }
  end;

var
  frmFeed: TfrmFeed;

implementation

{$R *.fmx}

 uses uFrmNoticia ;

{ TfrmFeed }

procedure TfrmFeed.AbrirNoticia(Sender: TObject;PertenceAoUsuario:boolean);
var
 DadosNoticia : TServico;
 ListaServicos : TStringList;
begin


 DadosNoticia  := TServico.Create;
 ListaServicos := TStringList.Create;

 if not Assigned(frmNoticia) then
 begin
  frmNoticia := TfrmNoticia.Create(Self);
 end;

 try
  {Passar para o DadosNoticia os valores de suas variaveis publicas,
   através da busca pelo código
  }

  {Passagem de teste}
  DadosNoticia.CodServico                      := 140;
  DadosNoticia.dtChegada                    := EncodeDate(2015,08,21);
  DadosNoticia.hsChegada                    := EncodeTime(17,30,42,0);
  DadosNoticia.dtSaida                      := EncodeDate(2015,08,21);
  DadosNoticia.hsSaida                      := EncodeTime(18,0,0,0);
  DadosNoticia.DescricaoRapida              := 'Troca de cabos';
  ListaServicos.Add('Troca de Cabos');
  DadosNoticia.listaAcoesRealizadas.Text := ListaServicos.Text;
  DadosNoticia.Observacoes                  := 'Eis aqui uma observação';
  DadosNoticia.Autor                        := 'Raimundo Nonato Guedes';
  DadosNoticia.Cliente                      := 'Ed. Excalibur';
  //CallPnlNoticiaPrincipal.Tag := 1;   // Notícia pertence ao usuário logado
  DadosNoticia.NumOrdemServico := 100;
  {Fim passagem de teste}



  if PertenceAoUsuario then
  begin
   frmNoticia.HabilitaEdicao;
  end
  else
  begin
   frmNoticia.DesabilitaEdicao;
  end;


 frmNoticia.RecebeNoticia(DadosNoticia);
 frmNoticia.Show;
 finally
  DadosNoticia.Free;
  ListaServicos.Free;
 end;

end;

procedure TfrmFeed.CriaComponentesNoticia(Acao: TServico);
begin
{Painel principal da noticia}
  nCallPnlNoticiaPrincipal         := TCalloutPanel.Create(VertScrollBoxFundo);
  nCallPnlNoticiaPrincipal.Align   := TAlignLayout.Top;
  nCallPnlNoticiaPrincipal.Height  := 120;
  // Tag = 1 : O autor da notícia é o usuário logado
  // se éOAutor então
  nCallPnlNoticiaPrincipal.Tag     := 1;
  //Senao  nCallPnlNoticiaPrincipal.Tag     := 1;
  nCallPnlNoticiaPrincipal.Parent  := VertScrollBoxFundo;
  nCallPnlNoticiaPrincipal.Name    := 'nCallPnlNoticiaPrincipal' + IntToStr(Acao.CodServico);

  nCallPnlNoticiaPrincipal.Opacity := 0;

  {Painel do meio da noticia}
  nPnlNoticiaMid                   := TPanel.Create(nCallPnlNoticiaPrincipal);
  nPnlNoticiaMid.Align             := TAlignLayout.Top;
  nPnlNoticiaMid.Height            := 35;
  nPnlNoticiaMid.Parent            := nCallPnlNoticiaPrincipal;
  nPnlNoticiaMid.Name              := 'nPnlNoticiaMid' + IntToStr(Acao.CodServico);
  nPnlNoticiaMid.Position.x        :=  0;
  nPnlNoticiaMid.Position.y        :=  46;

  {conteúdo do painel do meio da noticia}
  nlblAutorTit                     := TLabel.Create(nPnlNoticiaMid);
  nlblAutorTit.Text                := 'Autor:';
  nlblAutorTit.Align               := TAlignLayout.Left;
  nlblAutorTit.Width               := 49;
  nlblAutorTit.Parent              := nPnlNoticiaMid;
  nlblAutorTit.Name                := 'nlblAutorTit' + intToStr(Acao.CodServico);
  nlblAutorTit.Position.X          := 0;
  nlblAutorTit.Position.Y          := 0;
  nlblAutorTit.Font.Size           := 14;
  nlblAutorTit.StyledSettings      := [TStyledSetting.Family,TStyledSetting.Style,TStyledSetting.FontColor];

  {conteúdo do painel do meio da noticia}
  nlblAutor                        := TLabel.Create(nPnlNoticiaMid);
  nlblAutor.Text                   := Acao.Autor;
  nlblAutor.Align                  := TAlignLayout.Left;
  nlblAutor.Width                  := 209;
  nlblAutor.Parent                 := nPnlNoticiaMid;
  nlblAutor.Name                   := 'nlblAutor' + intToStr(Acao.CodServico);
  nlblAutor.Position.X             := 49;
  nlblAutor.Position.Y             := 0;
  nlblAutor.Font.Size              := 14;
  nlblAutor.Font.Style             := [TFontStyle.fsBold];
  nlblAutor.StyledSettings         := [TStyledSetting.Family,TStyledSetting.FontColor];

 {Painel inferuior da notícia}
  nPnlNoticiaBot                   := TPanel.Create(nCallPnlNoticiaPrincipal);
  nPnlNoticiaBot.Align             := TAlignLayout.Top;
  nPnlNoticiaBot.Height            := 35;
  nPnlNoticiaBot.Parent            := nCallPnlNoticiaPrincipal;
  nPnlNoticiaBot.Name              := 'nPnlNoticiaBot' + IntToStr(Acao.CodServico);
  nPnlNoticiaBot.Position.x        :=  0;
  nPnlNoticiaBot.Position.y        :=  81;

  {conteúdo do painel inferuior da noticia}

  nlblDescricaoTit                 := TLabel.Create(nPnlNoticiaBot);
  nlblDescricaoTit.Text            := 'Descrição:';
  nlblDescricaoTit.Align           := TAlignLayout.Left;
  nlblDescricaoTit.Width           := 73;
  nlblDescricaoTit.Parent          := nPnlNoticiaBot;
  nlblDescricaoTit.Name            := 'nlblDescricaoTit' + intToStr(Acao.CodServico);
  nlblDescricaoTit.Position.X      := 0;
  nlblDescricaoTit.Position.y      := 0;
  nlblDescricaoTit.Font.Size       := 14;
  nlblDescricaoTit.StyledSettings  := [TStyledSetting.Family,TStyledSetting.Style,TStyledSetting.FontColor];

  {conteúdo do painel inferuior da noticia}
  nlblDescricao                    := TLabel.Create(nPnlNoticiaBot);
  nlblDescricao.Text               := Acao.DescricaoRapida;
  nlblDescricao.Align              := TAlignLayout.Left;
  nlblDescricao.Width              := 201;
  nlblDescricao.Parent             := nPnlNoticiaBot;
  nlblDescricao.Name               := 'nlblDescricao' + intToStr(Acao.CodServico);
  nlblDescricao.Position.X         := 73;
  nlblDescricao.Position.y         := 0;
  nlblDescricao.Font.Size          := 14;
  nlblDescricao.Font.Style         := [TFontStyle.fsBold];
  nlblDescricao.StyledSettings     := [TStyledSetting.Family,TStyledSetting.FontColor] ;



  {Painel superior da noticia}
  nPnlNoticiaTop                   := TPanel.Create(nCallPnlNoticiaPrincipal);
  nPnlNoticiaTop.Align             := TAlignLayout.Top;
  nPnlNoticiaTop.Height            := 35;
  nPnlNoticiaTop.Parent            := nCallPnlNoticiaPrincipal;
  nPnlNoticiaTop.Name              := 'nPnlNoticiaTop' + IntToStr(Acao.CodServico);
  nPnlNoticiaTop.Position.x        :=  0;
  nPnlNoticiaTop.Position.y        :=  11;

  {conteúdo do painel superior da noticia}
  nlblCodigo                       := TLabel.Create(nPnlNoticiaTop);
  nlblCodigo.Text                  := intToStr(Acao.CodServico);
  nlblCodigo.Align                 := TAlignLayout.Left;
  nlblCodigo.Width                 := 65;
  nlblCodigo.Parent                := nPnlNoticiaTop;
  nlblCodigo.Name                  := 'nlblCodigo' + intToStr(Acao.CodServico);
  nlblCodigo.Position.X            := 0;
  nlblCodigo.Position.Y            := 0;
  nlblCodigo.Font.Size             := 14;
  nlblCodigo.StyledSettings        := [TStyledSetting.Family,TStyledSetting.Style];
  nlblCodigo.TextAlign             := TTextAlign.Center;

  {Data da postagem}
  nlblDataHora                     := TLabel.Create(nPnlNoticiaTop);
  nlblDataHora.Text                := '10/08/2015 - 12:32:40';
  nlblDataHora.Align               := TAlignLayout.Left;
  nlblDataHora.Width               := 192;
  nlblDataHora.Parent              := nPnlNoticiaTop;
  nlblDataHora.Name                := 'nlblDataHora' + intToStr(Acao.CodServico);
  nlblDataHora.Position.X          := 73;
  nlblDataHora.Font.Size           := 14;
  nlblDataHora.StyledSettings      := [TStyledSetting.Family];
  nlblDataHora.Font.Style          := [TFontStyle.fsBold];

  {Linha separadora entre codigo e data}
  nLineSeparador                   := TLine.Create(nPnlNoticiaTop);
  nLineSeparador.Align             := TAlignLayout.Left;
  nLineSeparador.Height            := 35;
  nLineSeparador.LineType          := TLineType.Left;
  nLineSeparador.Stroke.Color      := TAlphaColorRec.White;
  nLineSeparador.Width             :=  8;
  nLineSeparador.Parent            := nPnlNoticiaTop;
  nLineSeparador.Position.X        := 65;




  nPnlNoticiaTop.OnClick           := EventoClickPanelNoticia;
  nPnlNoticiaMid.OnClick           := EventoClickPanelNoticia;
  nPnlNoticiaBot.onclick           := EventoClickPanelNoticia;
  TAnimator.AnimateFloat(nCallPnlNoticiaPrincipal,'Opacity', 1.0, 1, TAnimationType.InOut, TInterpolationType.Linear);

end;

procedure TfrmFeed.CriaNovaNoticia(var Servico :TServico);
begin
{Faz pesquisa no webService e preenche um objAcao}
{teste}
 Servico.Autor := 'Raimundo Nonato Guedes';
 Servico.DescricaoRapida := 'Som do motor';
 {fim Teste}

 try
  CriaComponentesNoticia(Servico);
 except
  on E:Exception do
  begin
    ShowMessage('Falha ao carregar notícia. Mensagem :' + E.Message);
  end;

 end;






end;





procedure TfrmFeed.EventoClickPanelNoticia(Sender: TObject);
var
 PertenceAoUsuario : Boolean;
begin
 {Teste}
 TPanel(Sender).Parent.Tag:= 1;
 {fim Teste}
 PertenceAoUsuario := TPanel(Sender).Parent.Tag = 1;
 AbrirNoticia(Sender,PertenceAoUsuario);
end;

procedure TfrmFeed.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if MessageDlg('Deseja realmente fechar a aplicação?',
        TMsgDlgType.mtConfirmation,[TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0, TMsgDlgBtn.mbNo) = mrYes  then
   begin
      CanClose := True;
      Application.Terminate;
   end
 else
  begin
    CanClose := False;
    ShowMessage('Você respondeu não');
  end;
end;

procedure TfrmFeed.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
  begin
// if (key = vkHardwareBack) and not (edtPesquisar.IsFocused) then
// begin
//   ShowMessage('Entrou no método');
//   FreeAndNil(dmPrincipal);
//   FreeAndNil(frmFeed);
//   Application.Terminate;
// end;
end;

procedure TfrmFeed.FormResize(Sender: TObject);
begin
 RetanguloMenu.Position.X := imgMenu.Position.X + imgMenu.Width - RetanguloMenu.Width;
end;

procedure TfrmFeed.FormShow(Sender: TObject);
begin
 teste := 0;
 RetanguloMenu.Height := 0;
end;



procedure TfrmFeed.imgMenuClick(Sender: TObject);
begin
 RetanguloMenu.Position.X := imgMenu.Position.X + imgMenu.Width - RetanguloMenu.Width;
 RetanguloMenu.BringToFront;
 AniFloatMenu.Inverse := (RetanguloMenu.Height > 0);
 AniFloatMenu.Enabled := True;
 AniFloatMenu.Enabled := False;

end;

procedure TfrmFeed.spdNovoClick(Sender: TObject);
begin
 if not Assigned(frmNoticia) then
 begin
  frmNoticia := frmNoticia.Create(Self);
 end;
 frmNoticia.NovaNoticia;
 frmNoticia.Show;

end;

procedure TfrmFeed.SpeedButton1Click(Sender: TObject);
var
 Acao : TServico;
begin
 inc(teste);
 Try

  Acao := TServico.Create;
  Acao.CodServico := Teste;
  CriaNovaNoticia(Acao);
 Finally
   Acao.Free;
 End;
end;

procedure TfrmFeed.tmrAtualizaFeedTimer(Sender: TObject);
begin
  //CriaNovaNoticia;

end;

end.
