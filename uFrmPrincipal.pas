unit uFrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Header, FMX.Layouts,uAcao,uDmPrincipal, FMX.Objects, FMX.Ani, FMX.ExtCtrls,
  FMX.Effects, FMX.Edit, FMX.Controls.Presentation;

type
  TfrmPrincipal = class(TForm)
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
   procedure CriaNovaNoticia(Acao :TAcao);
   procedure CriaComponentesNoticia(Acao: TAcao);
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
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

 uses uFrmFormulario ;

{ TfrmPrincipal }

procedure TfrmPrincipal.AbrirNoticia(Sender: TObject;PertenceAoUsuario:boolean);
var
 DadosNoticia : TAcao;
 ListaServicos : TStringList;
begin


 DadosNoticia  := TAcao.Create;
 ListaServicos := TStringList.Create;

 if not Assigned(frmAcoes) then
 begin
  frmAcoes := frmAcoes.Create(Self);
 end;

 try
  {Passar para o DadosNoticia os valores de suas variaveis publicas,
   através da busca pelo código
  }

  {Passagem de teste}
  DadosNoticia.CodAcao                      := 140;
  DadosNoticia.dtChegada                    := EncodeDate(2015,08,21);
  DadosNoticia.hsChegada                    := EncodeTime(17,30,42,0);
  DadosNoticia.dtSaida                      := EncodeDate(2015,08,21);
  DadosNoticia.hsSaida                      := EncodeTime(18,0,0,0);
  DadosNoticia.DescricaoRapida              := 'Troca de cabos';
  ListaServicos.Add('Troca de Cabos');
  DadosNoticia.listaServicosRealizados.Text := ListaServicos.Text;
  DadosNoticia.Observacoes                  := 'Eis aqui uma observação';
  DadosNoticia.Autor                        := 'Raimundo Nonato Guedes';
  DadosNoticia.Cliente                      := 'Ed. Excalibur';
  //CallPnlNoticiaPrincipal.Tag := 1;   // Notícia pertence ao usuário logado
  DadosNoticia.NumOrdemServico := 100;
  {Fim passagem de teste}



  if PertenceAoUsuario then
  begin
   frmFormulario.HabilitaEdicao;
  end
  else
  begin
   frmFormulario.DesabilitaEdicao;
  end;


 frmFormulario.RecebeNoticia(DadosNoticia);
 frmFormulario.Show;
 finally
  DadosNoticia.Free;
  ListaServicos.Free;
 end;

end;

procedure TfrmPrincipal.CriaComponentesNoticia(Acao: TAcao);
begin
{Painel principal da noticia}
  nCallPnlNoticiaPrincipal         := TCalloutPanel.Create(VertScrollBoxFundo);
  nCallPnlNoticiaPrincipal.Align   := TAlignLayout.alTop;
  nCallPnlNoticiaPrincipal.Height  := 120;
  // Tag = 1 : O autor da notícia é o usuário logado
  // se éOAutor então
  nCallPnlNoticiaPrincipal.Tag     := 1;
  //Senao  nCallPnlNoticiaPrincipal.Tag     := 1;
  nCallPnlNoticiaPrincipal.Parent  := VertScrollBoxFundo;
  nCallPnlNoticiaPrincipal.Name    := 'nCallPnlNoticiaPrincipal' + IntToStr(Acao.CodAcao);

  nCallPnlNoticiaPrincipal.Opacity := 0;

  {Painel do meio da noticia}
  nPnlNoticiaMid                   := TPanel.Create(nCallPnlNoticiaPrincipal);
  nPnlNoticiaMid.Align             := TAlignLayout.alTop;
  nPnlNoticiaMid.Height            := 35;
  nPnlNoticiaMid.Parent            := nCallPnlNoticiaPrincipal;
  nPnlNoticiaMid.Name              := 'nPnlNoticiaMid' + IntToStr(Acao.CodAcao);
  nPnlNoticiaMid.Position.x        :=  0;
  nPnlNoticiaMid.Position.y        :=  46;

  {conteúdo do painel do meio da noticia}
  nlblAutorTit                     := TLabel.Create(nPnlNoticiaMid);
  nlblAutorTit.Text                := 'Autor:';
  nlblAutorTit.Align               := TAlignLayout.alLeft;
  nlblAutorTit.Width               := 49;
  nlblAutorTit.Parent              := nPnlNoticiaMid;
  nlblAutorTit.Name                := 'nlblAutorTit' + intToStr(Acao.CodAcao);
  nlblAutorTit.Position.X          := 0;
  nlblAutorTit.Position.Y          := 0;
  nlblAutorTit.Font.Size           := 14;
  nlblAutorTit.StyledSettings      := [TStyledSetting.ssFamily,TStyledSetting.ssStyle,TStyledSetting.ssFontColor];
  
  {conteúdo do painel do meio da noticia}
  nlblAutor                        := TLabel.Create(nPnlNoticiaMid);
  nlblAutor.Text                   := Acao.Autor; 
  nlblAutor.Align                  := TAlignLayout.alLeft;
  nlblAutor.Width                  := 209;
  nlblAutor.Parent                 := nPnlNoticiaMid;
  nlblAutor.Name                   := 'nlblAutor' + intToStr(Acao.CodAcao);
  nlblAutor.Position.X             := 49;
  nlblAutor.Position.Y             := 0;
  nlblAutor.Font.Size              := 14;
  nlblAutor.Font.Style             := [TFontStyle.fsBold];
  nlblAutor.StyledSettings         := [TStyledSetting.ssFamily,TStyledSetting.ssFontColor];  

 {Painel inferuior da notícia}
  nPnlNoticiaBot                   := TPanel.Create(nCallPnlNoticiaPrincipal);
  nPnlNoticiaBot.Align             := TAlignLayout.alTop;
  nPnlNoticiaBot.Height            := 35;
  nPnlNoticiaBot.Parent            := nCallPnlNoticiaPrincipal;
  nPnlNoticiaBot.Name              := 'nPnlNoticiaBot' + IntToStr(Acao.CodAcao);
  nPnlNoticiaBot.Position.x        :=  0;
  nPnlNoticiaBot.Position.y        :=  81;

  {conteúdo do painel inferuior da noticia}

  nlblDescricaoTit                 := TLabel.Create(nPnlNoticiaBot);
  nlblDescricaoTit.Text            := 'Descrição:';
  nlblDescricaoTit.Align           := TAlignLayout.alLeft;
  nlblDescricaoTit.Width           := 73;
  nlblDescricaoTit.Parent          := nPnlNoticiaBot;
  nlblDescricaoTit.Name            := 'nlblDescricaoTit' + intToStr(Acao.CodAcao);
  nlblDescricaoTit.Position.X      := 0;
  nlblDescricaoTit.Position.y      := 0;
  nlblDescricaoTit.Font.Size       := 14;
  nlblDescricaoTit.StyledSettings  := [TStyledSetting.ssFamily,TStyledSetting.ssStyle,TStyledSetting.ssFontColor];

  {conteúdo do painel inferuior da noticia}
  nlblDescricao                    := TLabel.Create(nPnlNoticiaBot);
  nlblDescricao.Text               := Acao.DescricaoRapida;
  nlblDescricao.Align              := TAlignLayout.alLeft;
  nlblDescricao.Width              := 201;
  nlblDescricao.Parent             := nPnlNoticiaBot;
  nlblDescricao.Name               := 'nlblDescricao' + intToStr(Acao.CodAcao);
  nlblDescricao.Position.X         := 73;
  nlblDescricao.Position.y         := 0;
  nlblDescricao.Font.Size          := 14;
  nlblDescricao.Font.Style         := [TFontStyle.fsBold];
  nlblDescricao.StyledSettings     := [TStyledSetting.ssFamily,TStyledSetting.ssFontColor] ;

  

  {Painel superior da noticia}
  nPnlNoticiaTop                   := TPanel.Create(nCallPnlNoticiaPrincipal);
  nPnlNoticiaTop.Align             := TAlignLayout.alTop;
  nPnlNoticiaTop.Height            := 35;
  nPnlNoticiaTop.Parent            := nCallPnlNoticiaPrincipal;
  nPnlNoticiaTop.Name              := 'nPnlNoticiaTop' + IntToStr(Acao.CodAcao);
  nPnlNoticiaTop.Position.x        :=  0;
  nPnlNoticiaTop.Position.y        :=  11;

  {conteúdo do painel superior da noticia}
  nlblCodigo                       := TLabel.Create(nPnlNoticiaTop);
  nlblCodigo.Text                  := intToStr(Acao.CodAcao);
  nlblCodigo.Align                 := TAlignLayout.alLeft;
  nlblCodigo.Width                 := 65;
  nlblCodigo.Parent                := nPnlNoticiaTop;
  nlblCodigo.Name                  := 'nlblCodigo' + intToStr(Acao.CodAcao);
  nlblCodigo.Position.X            := 0;
  nlblCodigo.Position.Y            := 0;
  nlblCodigo.Font.Size             := 14;
  nlblCodigo.FontColor             := TAlphaColorRec.Lightcyan;
  nlblCodigo.StyledSettings        := [TStyledSetting.ssFamily,TStyledSetting.ssStyle];
  nlblCodigo.TextAlign             := TTextAlign.taCenter;

  {Data da postagem}
  nlblDataHora                     := TLabel.Create(nPnlNoticiaTop);
  nlblDataHora.Text                := '10/08/2015 - 12:32:40';
  nlblDataHora.Align               := TAlignLayout.alLeft;
  nlblDataHora.Width               := 192;
  nlblDataHora.Parent              := nPnlNoticiaTop;
  nlblDataHora.Name                := 'nlblDataHora' + intToStr(Acao.CodAcao);
  nlblDataHora.Position.X          := 73;
  nlblDataHora.Font.Size           := 14;
  nlblDataHora.FontColor           := TAlphaColorRec.Lightcyan;
  nlblDataHora.StyledSettings      := [TStyledSetting.ssFamily];
  nlblDataHora.Font.Style          := [TFontStyle.fsBold];
    
  {Linha separadora entre codigo e data}
  nLineSeparador                   := TLine.Create(nPnlNoticiaTop);
  nLineSeparador.Align             := TAlignLayout.alLeft;
  nLineSeparador.Height            := 35;
  nLineSeparador.LineType          := TLineType.ltLeft;
  nLineSeparador.Stroke.Color      := TAlphaColorRec.White;
  nLineSeparador.Width             :=  8;
  nLineSeparador.Parent            := nPnlNoticiaTop;
  nLineSeparador.Position.X        := 65;


  
  
  nPnlNoticiaTop.OnClick           := EventoClickPanelNoticia;
  nPnlNoticiaMid.OnClick           := EventoClickPanelNoticia;
  nPnlNoticiaBot.onclick           := EventoClickPanelNoticia;
  nCallPnlNoticiaPrincipal.AnimateFloat('Opacity', 1.0, 1, TAnimationType.InOut, TInterpolationType.Linear);
  
end;

procedure TfrmPrincipal.CriaNovaNoticia(Acao :TAcao);
var
 InformacoesAcao : TAcao;
begin



{Faz pesquisa no webService e preenche um objAcao}
 InformacoesAcao := Acao;
{teste}
 InformacoesAcao.Autor := 'Raimundo Nonato Guedes';
 InformacoesAcao.DescricaoRapida := 'Som do motor';
 {fim Teste}

 Try  
  CriaComponentesNoticia(InformacoesAcao);
 Finally
  InformacoesAcao.Free;
 End;





end;





procedure TfrmPrincipal.EventoClickPanelNoticia(Sender: TObject);
var
 PertenceAoUsuario : Boolean;
begin
 {Teste}
 TPanel(Sender).Parent.Tag:= 1;
 {fim Teste}
 PertenceAoUsuario := TPanel(Sender).Parent.Tag = 1;
 AbrirNoticia(Sender,PertenceAoUsuario);
end;

procedure TfrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
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

procedure TfrmPrincipal.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
  begin
// if (key = vkHardwareBack) and not (edtPesquisar.IsFocused) then
// begin
//   ShowMessage('Entrou no método');
//   FreeAndNil(dmPrincipal);
//   FreeAndNil(frmPrincipal);
//   Application.Terminate;
// end;
end;

procedure TfrmPrincipal.FormResize(Sender: TObject);
begin
 RetanguloMenu.Position.X := imgMenu.Position.X + imgMenu.Width - RetanguloMenu.Width;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
 teste := 0;
 RetanguloMenu.Height := 0;
end;



procedure TfrmPrincipal.imgMenuClick(Sender: TObject);
begin
 RetanguloMenu.Position.X := imgMenu.Position.X + imgMenu.Width - RetanguloMenu.Width;
 RetanguloMenu.BringToFront;
 AniFloatMenu.Inverse := (RetanguloMenu.Height > 0);
 AniFloatMenu.Enabled := True;
 AniFloatMenu.Enabled := False;

end;

procedure TfrmPrincipal.spdNovoClick(Sender: TObject);
begin
 if not Assigned(frmFormulario) then
 begin
  frmFormulario := TFrmFormulario.Create(Self);
 end;
 Frmformulario.NovaNoticia;
 FrmFormulario.Show;

end;

procedure TfrmPrincipal.SpeedButton1Click(Sender: TObject);
var
 Acao : TAcao;
begin
 inc(teste);
 Try
  Acao := TAcao.Create;
  Acao.CodAcao := Teste;
  CriaNovaNoticia(Acao);
 Finally
   Acao.Free;
 End;
end;

procedure TfrmPrincipal.tmrAtualizaFeedTimer(Sender: TObject);
begin
  //CriaNovaNoticia;

end;

end.
