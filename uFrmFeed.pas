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
    AniFloatMenu: TFloatAnimation;
    ShadowEffect1: TShadowEffect;
    imgMenu: TImage;
    pnlPesquisa: TPanel;
    imgPesquisar: TImage;
    edtPesquisar: TEdit;
    retanguloNovo: TRectangle;
    ShadowEffect2: TShadowEffect;
    imgNovo: TImage;
    RetanguloFinalizar: TRectangle;
    ShadowEffect4: TShadowEffect;
    imgFinalizar: TImage;
    ShadowEffect3: TShadowEffect;
    spdNovo: TSpeedButton;
    spdFinalizar: TSpeedButton;
    procedure tmrAtualizaFeedTimer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure spdNovoClick(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure lblFinalizarClick(Sender: TObject);
    procedure imgFinalizarClick(Sender: TObject);
    procedure VertScrollBoxFundoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgNovoClick(Sender: TObject);
    procedure spdFinalizarClick(Sender: TObject);
    procedure imgPesquisarClick(Sender: TObject);
  private
    { Private declarations }
   procedure AbrirNoticia(Sender : TObject; PertenceAoUsuario:boolean);
   procedure CriaNovaNoticia(var Servico :TServico);
   procedure CriaComponentesNoticia(Servico: TServico; ParentPrincipal : TFmxObject);
   procedure EventoClickPanelNoticia(Sender : TObject);
   procedure FinalizarApp;
   procedure AddNovaNoticia;
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

 uses uFrmNoticia, FireDAC.Comp.Client ;

{ TfrmFeed }

procedure TfrmFeed.AbrirNoticia(Sender: TObject;PertenceAoUsuario:boolean);
var
 DadosNoticia : TServico;
 ListaServicos : TStringList;
 lQryAcao : TFdQuery;
 CodNoticia : Integer;
 i : Integer;
 NomeComponente : String;
 t : Integer;
begin
   {Pesquisar as informações da Notiícia}
  NomeComponente := TFmxObject(Sender).Name;
  for i := 1 to Length(NomeComponente) do
  begin
    if TryStrToInt(NomeComponente[i],t) then
    begin
      CodNoticia := StrToInt(Copy(NomeComponente,i,Length(NomeComponente)));
      Break;
    end;
  end;


 DadosNoticia  := TServico.Create;
 ListaServicos := TStringList.Create;
 lQryAcao      := TFDQuery.Create(Self);

 if not Assigned(frmNoticia) then
 begin
  frmNoticia := TfrmNoticia.Create(Self);
 end;

 try
  {Passar para o DadosNoticia os valores de suas variaveis publicas,
   através da busca pelo código



  }


  {Passagem de teste}
//  DadosNoticia.CodServico                      := 140;
//  DadosNoticia.dtChegada                    := EncodeDate(2015,08,21);
//  DadosNoticia.dtSaida                      := EncodeDate(2015,08,21);
//  DadosNoticia.DescricaoRapida              := 'Troca de cabos';
//  ListaServicos.Add('Troca de Cabos');
//  DadosNoticia.listaAcoesRealizadas.Text := ListaServicos.Text;
//  DadosNoticia.Observacoes                  := 'Eis aqui uma observação';
//  DadosNoticia.Autor                        := 'Raimundo Nonato Guedes';
//  DadosNoticia.Cliente                      := 'Ed. Excalibur';
//  //CallPnlNoticiaPrincipal.Tag := 1;   // Notícia pertence ao usuário logado
//  DadosNoticia.NumOrdemServico := 100;
  {Fim passagem de teste}
  lQryAcao.Connection := dmPrincipal.SQLiteConn;
  lQryAcao.SQL.Add(' SELECT ID ');
  lQryAcao.SQL.Add('        ,COD_NOTICIA');
  lQryAcao.SQL.Add('        ,AUTOR');
  lQryAcao.SQL.Add('        ,DESCRICAO       ');
  lQryAcao.SQL.Add('        ,DT_POSTAGEM     ');
  lQryAcao.SQL.Add('        ,DT_CHEGADA      ');
  lQryAcao.SQL.Add('        ,DT_SAIDA        ');
  lQryAcao.SQL.Add('        ,EQUIPAMENTO     ');
  lQryAcao.SQL.Add('        ,OBSERVACAO      ');
  lQryAcao.SQL.Add('        ,CLIENTE         ');
  lQryAcao.SQL.Add('FROM NOTICIASFEED');
  lQryAcao.SQL.Add('WHERE COD_NOTICIA = :COD_NOTICIA');
  lQryAcao.ParamByName('COD_NOTICIA').AsInteger := CodNoticia;
  lQryAcao.Open();

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

procedure TfrmFeed.CriaComponentesNoticia(Servico: TServico; ParentPrincipal : TFmxObject);
begin
{Painel principal da noticia}
  nCallPnlNoticiaPrincipal         := TCalloutPanel.Create(ParentPrincipal);
  nCallPnlNoticiaPrincipal.Align   := TAlignLayout.Top;
  nCallPnlNoticiaPrincipal.Height  := 120;
  // Tag = 1 : O autor da notícia é o usuário logado
  // se éOAutor então
  if UpperCase(Servico.Autor) = UpperCase(dmPrincipal.NomeUsuarioLogado) then
  begin
   nCallPnlNoticiaPrincipal.Tag     := 1;
  end
  else
  begin
   nCallPnlNoticiaPrincipal.Tag     := 0;
  end;

  //Senao  nCallPnlNoticiaPrincipal.Tag     := 1;
  nCallPnlNoticiaPrincipal.Parent  := ParentPrincipal;
  nCallPnlNoticiaPrincipal.Name    := 'nCallPnlNoticiaPrincipal' + IntToStr(Servico.CodServico);

  nCallPnlNoticiaPrincipal.Opacity := 0;

  {Painel do meio da noticia}
  nPnlNoticiaMid                   := TPanel.Create(nCallPnlNoticiaPrincipal);
  nPnlNoticiaMid.Align             := TAlignLayout.Top;
  nPnlNoticiaMid.Height            := 35;
  nPnlNoticiaMid.Parent            := nCallPnlNoticiaPrincipal;
  nPnlNoticiaMid.Name              := 'nPnlNoticiaMid' + IntToStr(Servico.CodServico);
  nPnlNoticiaMid.Position.x        :=  0;
  nPnlNoticiaMid.Position.y        :=  46;

  {conteúdo do painel do meio da noticia}
  nlblAutorTit                     := TLabel.Create(nPnlNoticiaMid);
  nlblAutorTit.Text                := 'Autor:';
  nlblAutorTit.Align               := TAlignLayout.Left;
  nlblAutorTit.Width               := 49;
  nlblAutorTit.Parent              := nPnlNoticiaMid;
  nlblAutorTit.Name                := 'nlblAutorTit' + intToStr(Servico.CodServico);
  nlblAutorTit.Position.X          := 0;
  nlblAutorTit.Position.Y          := 0;
  nlblAutorTit.Font.Size           := 14;
  nlblAutorTit.StyledSettings      := [TStyledSetting.Family,TStyledSetting.Style,TStyledSetting.FontColor];

  {conteúdo do painel do meio da noticia}
  nlblAutor                        := TLabel.Create(nPnlNoticiaMid);
  nlblAutor.Text                   := Servico.Autor;
  nlblAutor.Align                  := TAlignLayout.Left;
  nlblAutor.Width                  := 209;
  nlblAutor.Parent                 := nPnlNoticiaMid;
  nlblAutor.Name                   := 'nlblAutor' + intToStr(Servico.CodServico);
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
  nPnlNoticiaBot.Name              := 'nPnlNoticiaBot' + IntToStr(Servico.CodServico);
  nPnlNoticiaBot.Position.x        :=  0;
  nPnlNoticiaBot.Position.y        :=  81;

  {conteúdo do painel inferuior da noticia}

  nlblDescricaoTit                 := TLabel.Create(nPnlNoticiaBot);
  nlblDescricaoTit.Text            := 'Descrição:';
  nlblDescricaoTit.Align           := TAlignLayout.Left;
  nlblDescricaoTit.Width           := 73;
  nlblDescricaoTit.Parent          := nPnlNoticiaBot;
  nlblDescricaoTit.Name            := 'nlblDescricaoTit' + intToStr(Servico.CodServico);
  nlblDescricaoTit.Position.X      := 0;
  nlblDescricaoTit.Position.y      := 0;
  nlblDescricaoTit.Font.Size       := 14;
  nlblDescricaoTit.StyledSettings  := [TStyledSetting.Family,TStyledSetting.Style,TStyledSetting.FontColor];

  {conteúdo do painel inferuior da noticia}
  nlblDescricao                    := TLabel.Create(nPnlNoticiaBot);
  nlblDescricao.Text               := Servico.DescricaoRapida;
  nlblDescricao.Align              := TAlignLayout.Left;
  nlblDescricao.Width              := 201;
  nlblDescricao.Parent             := nPnlNoticiaBot;
  nlblDescricao.Name               := 'nlblDescricao' + intToStr(Servico.CodServico);
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
  nPnlNoticiaTop.Name              := 'nPnlNoticiaTop' + IntToStr(Servico.CodServico);
  nPnlNoticiaTop.Position.x        :=  0;
  nPnlNoticiaTop.Position.y        :=  11;

  {conteúdo do painel superior da noticia}
  nlblCodigo                       := TLabel.Create(nPnlNoticiaTop);
  nlblCodigo.Text                  := intToStr(Servico.CodServico);
  nlblCodigo.Align                 := TAlignLayout.Left;
  nlblCodigo.Width                 := 65;
  nlblCodigo.Parent                := nPnlNoticiaTop;
  nlblCodigo.Name                  := 'nlblCodigo' + intToStr(Servico.CodServico);
  nlblCodigo.Position.X            := 0;
  nlblCodigo.Position.Y            := 0;
  nlblCodigo.Font.Size             := 14;
  nlblCodigo.StyledSettings        := [TStyledSetting.Family,TStyledSetting.Style];
  nlblCodigo.TextAlign             := TTextAlign.Center;

  {Data da postagem}
  nlblDataHora                     := TLabel.Create(nPnlNoticiaTop);
  nlblDataHora.Text                := DateToStr(Servico.dtPostagem);
  nlblDataHora.Align               := TAlignLayout.Left;
  nlblDataHora.Width               := 192;
  nlblDataHora.Parent              := nPnlNoticiaTop;
  nlblDataHora.Name                := 'nlblDataHora' + intToStr(Servico.CodServico);
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
{Faz pesquisa no Banco e preenche o objeto}
 dmPrincipal.qryNoticiasFeed.Open();
 Servico.CodServico      := dmPrincipal.qryNoticiasFeed.FieldByName('COD_NOTICIA').AsInteger;
 Servico.DescricaoRapida := dmPrincipal.qryNoticiasFeed.FieldByName('DESCRICAO').AsString;
 Servico.dtPostagem      := dmPrincipal.qryNoticiasFeed.FieldByName('DT_POSTAGEM').AsDateTime;
 Servico.Autor           := dmPrincipal.qryNoticiasFeed.FieldByName('AUTOR').AsString;
 try
  CriaComponentesNoticia(Servico, VertScrollBoxFundo);
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

procedure TfrmFeed.FinalizarApp;
begin
{$IFDEF WIN32}
if MessageDlg('Deseja realmente fechar a aplicação?',
        TMsgDlgType.mtConfirmation,[TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0, TMsgDlgBtn.mbNo) = mrYes  then
{$ENDIF}
 begin
  Close;
 end;
end;

procedure TfrmFeed.AddNovaNoticia;
begin
  if not Assigned(frmNoticia) then
  begin
    frmNoticia := TfrmNoticia.Create(Self);
  end;
  frmNoticia.NovaNoticia;
  frmNoticia.Show;
end;

procedure TfrmFeed.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action     := TCloseAction.caFree;
 frmFeed := nil;
 Application.Terminate;
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


procedure TfrmFeed.imgFinalizarClick(Sender: TObject);
begin
 FinalizarApp;
end;

procedure TfrmFeed.imgMenuClick(Sender: TObject);
begin
 RetanguloMenu.Position.X := imgMenu.Position.X + imgMenu.Width - RetanguloMenu.Width;
 RetanguloMenu.BringToFront;
 AniFloatMenu.Inverse := (RetanguloMenu.Height > 0);
 AniFloatMenu.Enabled := True;
 AniFloatMenu.Enabled := False;

end;

procedure TfrmFeed.imgNovoClick(Sender: TObject);
begin
 AddNovaNoticia;
end;

procedure TfrmFeed.imgPesquisarClick(Sender: TObject);
var
 i :Integer;
 TextoDigitado : String;
 TextoDoComponente : String;
begin

 if not Trim(edtPesquisar.Text).IsEmpty then
 begin
  TextoDigitado := UpperCase(edtPesquisar.Text);
  for i := 0 to VertScrollBoxFundo.ComponentCount - 1  do
  begin
    if VertScrollBoxFundo.Components[i] is TLabel then
    begin
     TextoDoComponente := UpperCase(TLabel(VertScrollBoxFundo.Components[i]).Text);
     if TextoDigitado.Contains(TextoDigitado) then
     begin

     end;
    end;

  end;
 end;
end;

procedure TfrmFeed.lblFinalizarClick(Sender: TObject);
begin
 FinalizarApp;
end;



procedure TfrmFeed.spdFinalizarClick(Sender: TObject);
begin
 FinalizarApp;
end;

procedure TfrmFeed.spdNovoClick(Sender: TObject);
begin
 AddNovaNoticia;

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

procedure TfrmFeed.VertScrollBoxFundoClick(Sender: TObject);
begin
  RetanguloMenu.Height := 0;
end;

end.
