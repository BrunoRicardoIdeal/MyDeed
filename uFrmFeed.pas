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
    imgFinalizar: TImage;
    spdNovo: TSpeedButton;
    spdFinalizar: TSpeedButton;
    spdCarregarMais: TSpeedButton;
    imgLoading: TImage;
    FloatAnimationRotacaoImg: TFloatAnimation;
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
    procedure FormCreate(Sender: TObject);
    procedure spdCarregarMaisClick(Sender: TObject);
  private
    { Private declarations }
   procedure AbrirNoticia(Sender : TObject; PertenceAoUsuario:boolean);
   procedure CriaNovaNoticia(var Servico :TServico);
   procedure CriaComponentesNoticia(Servico: TServico; ParentPrincipal : TFmxObject);
   procedure EventoClickPanelNoticia(Sender : TObject);
   procedure FinalizarApp;
   procedure AddNovaNoticia;
   procedure AtualizarFeed;
    procedure AtivarLoading;
    procedure DesativarLoading;
   var
   {Componentes criados em tempo de execução}
    nCallPnlNoticiaPrincipal : TCalloutPanel;
    nPnlNoticiaTop,nPnlNoticiaMid ,nPnlNoticiaBot : TPanel;
    nLineSeparador : TLine;
    nlblCodigo,nlblDataHora,nlblAutorTit,nlblAutor,nlblDescricaoTit,nlblDescricao :TLabel;

    ultIdFeed : Integer;
    efeitoBlur : TBlurEffect;
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
 lQryServicos : TFdQuery;
 CodNoticia : Integer;
 i : Integer;
 NomeComponente : String;
begin
   {Pesquisar as informações da Notiícia}
 NomeComponente := TFmxObject(Sender).Name;
 CodNoticia := StrToInt(Copy(NomeComponente, pos('_',NomeComponente)+1,Length(NomeComponente)) );

 DadosNoticia            := TServico.Create;
 ListaServicos           := TStringList.Create;
 lQryAcao                := TFDQuery.Create(Self);
 lQryAcao.Connection     := dmPrincipal.SQLiteConn;
 lQryServicos            := TFDQuery.Create(Self);
 lQryServicos.Connection := dmPrincipal.SQLiteConn;

 if not Assigned(frmNoticia) then
 begin
  frmNoticia := TfrmNoticia.Create(Self);
 end;

 try
  {Passar para o DadosNoticia os valores de suas variaveis publicas,
   através da busca pelo código}

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

  DadosNoticia.CodServico                      := lQryAcao.FieldByName('COD_NOTICIA').AsInteger;
  DadosNoticia.dtChegada                       := lQryAcao.FieldByName('DT_CHEGADA').AsDateTime;
  DadosNoticia.dtSaida                         := lQryAcao.FieldByName('DT_SAIDA').AsDateTime;
  DadosNoticia.DescricaoRapida                 := lQryAcao.FieldByName('DESCRICAO').AsString;
  DadosNoticia.Observacoes                     := lQryAcao.FieldByName('OBSERVACAO').AsString;
  DadosNoticia.Autor                           := lQryAcao.FieldByName('AUTOR').AsString;
  DadosNoticia.Cliente                         := lQryAcao.FieldByName('CLIENTE').AsString;

  lQryServicos.SQL.Add('SELECT DESCRICAO');
  lQryServicos.SQL.Add('FROM ACOESREALIZADAS');
  lQryServicos.SQL.Add('WHERE COD_NOTICIA = :COD_NOTICIA');
  lQryServicos.ParamByName('COD_NOTICIA').AsInteger := CodNoticia;
  lQryServicos.Open();
  lQryServicos.First;

  while not lQryServicos.Eof do
  begin
    ListaServicos.Add(lQryServicos.FieldByName('DESCRICAO').AsString);
    lQryServicos.Next;
  end;
  DadosNoticia.listaAcoesRealizadas.Text := ListaServicos.Text;


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
  lQryAcao.Free;
  lQryServicos.Free;
 end;

end;

procedure TfrmFeed.CriaComponentesNoticia(Servico: TServico; ParentPrincipal : TFmxObject);
var
 i : Integer;
 PosYAnterior : Single;
 PosYMaior : Single;
begin
{Painel principal da noticia}
  spdCarregarMais.Visible          := False; {Sumir o botão de atualizar}
  nCallPnlNoticiaPrincipal         := TCalloutPanel.Create(ParentPrincipal);
  nCallPnlNoticiaPrincipal.Opacity := 0;
  nCallPnlNoticiaPrincipal.Parent  := ParentPrincipal;
  nCallPnlNoticiaPrincipal.Name    := 'nCallPnlNoticiaPrincipal_' + IntToStr(Servico.CodServico);
  PosYMaior := 0;
  for i := 0 to ParentPrincipal.ComponentCount -1 do
  begin
    if (ParentPrincipal.Components[i] is TCalloutPanel) then
    begin
     if TCalloutPanel(ParentPrincipal.Components[i]).Position.Y > PosYMaior then
     begin
       PosYMaior := TCalloutPanel(ParentPrincipal.Components[i]).Position.Y;
     end;

//      if ParentPrincipal.Components[i].Name = nCallPnlNoticiaPrincipal.Name then
//      begin
//        PosYAnterior := TCalloutPanel(ParentPrincipal.Components[ParentPrincipal.ComponentCount - 1 ]).Position.Y;
//        Break;
//      end;

    end;

  end;

  nCallPnlNoticiaPrincipal.Position.y := PosYMaior + 1;
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

  {Reposicionar o botão de atualizar}
  spdCarregarMais.Position.y := nCallPnlNoticiaPrincipal.Position.y + 10;
  spdCarregarMais.Visible := True;

  {Painel do meio da noticia}
  nPnlNoticiaMid                   := TPanel.Create(nCallPnlNoticiaPrincipal);
  nPnlNoticiaMid.Align             := TAlignLayout.Top;
  nPnlNoticiaMid.Height            := 35;
  nPnlNoticiaMid.Parent            := nCallPnlNoticiaPrincipal;
  nPnlNoticiaMid.Name              := 'nPnlNoticiaMid_' + IntToStr(Servico.CodServico);
  nPnlNoticiaMid.Position.x        :=  0;
  nPnlNoticiaMid.Position.y        :=  46;

  {conteúdo do painel do meio da noticia}
  nlblAutorTit                     := TLabel.Create(nPnlNoticiaMid);
  nlblAutorTit.Text                := 'Autor:';
  nlblAutorTit.Align               := TAlignLayout.Left;
  nlblAutorTit.Width               := 49;
  nlblAutorTit.Parent              := nPnlNoticiaMid;
  nlblAutorTit.Name                := 'nlblAutorTit_' + intToStr(Servico.CodServico);
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
  nlblAutor.Name                   := 'nlblAutor_' + intToStr(Servico.CodServico);
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
  nPnlNoticiaBot.Name              := 'nPnlNoticiaBot_' + IntToStr(Servico.CodServico);
  nPnlNoticiaBot.Position.x        :=  0;
  nPnlNoticiaBot.Position.y        :=  81;

  {conteúdo do painel inferuior da noticia}

  nlblDescricaoTit                 := TLabel.Create(nPnlNoticiaBot);
  nlblDescricaoTit.Text            := 'Descrição:';
  nlblDescricaoTit.Align           := TAlignLayout.Left;
  nlblDescricaoTit.Width           := 73;
  nlblDescricaoTit.Parent          := nPnlNoticiaBot;
  nlblDescricaoTit.Name            := 'nlblDescricaoTit_' + intToStr(Servico.CodServico);
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
  nlblDescricao.Name               := 'nlblDescricao_' + intToStr(Servico.CodServico);
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
  nPnlNoticiaTop.Name              := 'nPnlNoticiaTop_' + IntToStr(Servico.CodServico);
  nPnlNoticiaTop.Position.x        :=  0;
  nPnlNoticiaTop.Position.y        :=  11;

  {conteúdo do painel superior da noticia}
  nlblCodigo                       := TLabel.Create(nPnlNoticiaTop);
  nlblCodigo.Text                  := intToStr(Servico.CodServico);
  nlblCodigo.Align                 := TAlignLayout.Left;
  nlblCodigo.Width                 := 65;
  nlblCodigo.Parent                := nPnlNoticiaTop;
  nlblCodigo.Name                  := 'nlblCodigo_' + intToStr(Servico.CodServico);
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
  nlblDataHora.Name                := 'nlblDataHora_' + intToStr(Servico.CodServico);
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



  dmPrincipal.qryNoticiasFeed.ParamByName('ID').AsInteger := ultIdFeed -1;
  dmPrincipal.qryNoticiasFeed.Open();
  dmPrincipal.qryNoticiasFeed.First;
  if dmPrincipal.qryNoticiasFeed.FieldByName('ID').AsInteger = ultIdFeed then
  begin
    Exit;  //Não há mais Atualizações
  end;


  while not dmPrincipal.qryNoticiasFeed.eof do
  begin
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
    dmPrincipal.qryNoticiasFeed.Next;
  end;
  dmPrincipal.qryNoticiasFeed.Last;
  ultIdFeed := dmPrincipal.qryNoticiasFeedID.AsInteger;
  dmPrincipal.qryNoticiasFeed.Close;





end;





procedure TfrmFeed.EventoClickPanelNoticia(Sender: TObject);
var
 PertenceAoUsuario : Boolean;
begin
 RetanguloMenu.Height := 0;
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

procedure TfrmFeed.AtualizarFeed;
var
 Servico : TServico;
begin
 Try
  Servico := TServico.Create;
  CriaNovaNoticia(Servico);
 Finally
   Servico.Free;
 End;
end;

procedure TfrmFeed.AtivarLoading;
begin
  imgLoading.Visible               := True;
  FloatAnimationRotacaoImg.Enabled := True;
  efeitoBlur := TBlurEffect.Create(VertScrollBoxFundo);
  efeitoBlur.Softness              := 0.3;
  efeitoBlur.Parent                := VertScrollBoxFundo;
  efeitoBlur.Enabled               := True;
//  pnlTitulo.Visible                := False;
end;

procedure TfrmFeed.DesativarLoading;
begin
  imgLoading.Visible := False;
  FloatAnimationRotacaoImg.Enabled := False;
  efeitoBlur.Free;
//  pnlTitulo.Visible                := True;
end;

procedure TfrmFeed.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action     := TCloseAction.caFree;
 frmFeed := nil;
 Application.Terminate;
end;

procedure TfrmFeed.FormCreate(Sender: TObject);
begin
 {Perguntar pro web service qual é o max id}
 ultIdFeed := 100;
 imgLoading.Visible := False;
end;

procedure TfrmFeed.FormResize(Sender: TObject);
begin
 RetanguloMenu.Position.X := imgMenu.Position.X + imgMenu.Width - RetanguloMenu.Width;
end;

procedure TfrmFeed.FormShow(Sender: TObject);

begin
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



procedure TfrmFeed.spdCarregarMaisClick(Sender: TObject);

begin
 AtivarLoading;
 AtualizarFeed;
 //DesativarLoading;
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
 Servico : TServico;
begin
 dmPrincipal.SQLiteConn.ExecSQL('INSERT INTO NOTICIASFEED(COD_NOTICIA) VALUES(10)');
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
