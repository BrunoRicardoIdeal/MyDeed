unit uFrmAcoes;

interface

uses
  System.SysUtils, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Rtti, FMX.Grid, FMX.Layouts, FMX.StdCtrls, FMX.ListBox,uDmPrincipal,
  FMX.Objects, FMX.Controls.Presentation, uFrmFeed;

type
  tFrmAcoes = class(TForm)
    Header: TToolBar;
    imgSalvar: TImage;
    imgExcluir: TImage;
    imgAdicionar: TImage;
    ListBoxAcoes: TListBox;
    cbAcoes: TComboBox;
    procedure btnVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure spdAddClick(Sender: TObject);
    procedure CriarListaInicial;
    procedure FormCreate(Sender: TObject);
    procedure imgSalvarClick(Sender: TObject);
    procedure imgExcluirClick(Sender: TObject);
    procedure imgAdicionarClick(Sender: TObject);
  private
    function ExisteItem :Boolean;
    var
     CaminhoListaInicial : String;
    { Private declarations }
  public
     { Public declarations }
  end;

var
  frmAcoes: tFrmAcoes;

implementation

 uses uFrmNoticia, System.Types;

{$R *.fmx}

procedure tFrmAcoes.btnVoltarClick(Sender: TObject);
begin
 frmNoticia.Show;
 FreeAndNil(frmAcoes);
end;



procedure tFrmAcoes.CriarListaInicial;
 var
  ListaInicial : TStringList;
begin
 ListaInicial := TStringList.Create;
 try
  ListaInicial.Add('Troca de Cabos ');
  ListaInicial.Add('Troca de Botões');
  ListaInicial.Add('Troca de Espelho');
  ListaInicial.SaveToFile(CaminhoListaInicial);
 finally
   ListaInicial.Free;
 end;


end;

function tFrmAcoes.ExisteItem: Boolean;
var
 itemCombo :String;
begin
 itemCombo :=   UpperCase(cbAcoes.Items[cbAcoes.ItemIndex]);
 result :=  UpperCase(ListBoxAcoes.Items.Text).Contains(itemCombo);
end;

procedure tFrmAcoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 FreeAndNil(frmAcoes);
end;

procedure tFrmAcoes.FormCreate(Sender: TObject);
begin

 CaminhoListaInicial := dmPrincipal.CAMINHO_ARQUIVOS_MYDEED + '/Acoes.txt';
 if not FileExists(CaminhoListaInicial) then
 begin
   CriarListaInicial;
 end;
 cbAcoes.Items.LoadFromFile(CaminhoListaInicial);

end;

procedure tFrmAcoes.imgAdicionarClick(Sender: TObject);
begin
 if not ExisteItem then
 begin
  ListBoxAcoes.Items.Add(cbAcoes.Items[cbAcoes.ItemIndex]);
 end
 else if cbAcoes.Items[cbAcoes.ItemIndex].IsEmpty then
 begin
  ShowMessage('Selecione um serviço!');
  Exit;
 end
 else
 begin
   ShowMessage('Serviço já inserido!');
   Exit;
 end;
end;

procedure tFrmAcoes.imgExcluirClick(Sender: TObject);
begin
if ListBoxAcoes.ItemIndex <> -1 then
begin
  ListBoxAcoes.Items.Delete(ListBoxAcoes.ItemIndex);
  ShowMessage('Serviço excluído!');
end
else
begin
  ShowMessage('Selecione um serviço antes de excluir!');
  Exit;
end;
end;

procedure tFrmAcoes.imgSalvarClick(Sender: TObject);
begin
  frmNoticia.Show;
  FreeAndNil(frmAcoes);
end;

procedure tFrmAcoes.spdAddClick(Sender: TObject);
begin
 if not ExisteItem then
 begin
  ListBoxAcoes.Items.Add(cbAcoes.Items[cbAcoes.ItemIndex]);
 end
 else if cbAcoes.Items[cbAcoes.ItemIndex].IsEmpty then
 begin
  ShowMessage('Selecione um serviço!');
  Exit;
  end
 else
 begin
   ShowMessage('Serviço já inserido!');
   Exit;
 end;
end;

end.
