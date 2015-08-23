unit uFrmServicos;

interface

uses
  System.SysUtils, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Rtti, FMX.Grid, FMX.Layouts, FMX.StdCtrls, FMX.ListBox,uDmPrincipal;

type
  TfrmServicos = class(TForm)
    Header: TToolBar;
    cbServicos: TComboBox;
    spdAdd: TSpeedButton;
    spdOk: TSpeedButton;
    ListBoxServicos: TListBox;
    spdExcluir: TSpeedButton;
    procedure btnVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure spdOkClick(Sender: TObject);
    procedure spdAddClick(Sender: TObject);
    procedure CriarListaInicial;
    procedure FormCreate(Sender: TObject);
    procedure spdExcluirClick(Sender: TObject);
  private
    function ExisteItem :Boolean;
    var
     CaminhoListaInicial : String;
    { Private declarations }
  public
     { Public declarations }
  end;

var
  frmServicos: TfrmServicos;

implementation

 uses uFrmFormulario, System.Types;

{$R *.fmx}

procedure TfrmServicos.btnVoltarClick(Sender: TObject);
begin

 frmFormulario.Show;
end;



procedure TfrmServicos.CriarListaInicial;
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

function TfrmServicos.ExisteItem: Boolean;
var
 itemCombo :String;
begin
 itemCombo :=   UpperCase(cbServicos.Items[cbServicos.ItemIndex]);
 result :=  UpperCase(ListBoxServicos.Items.Text).Contains(itemCombo);
end;

procedure TfrmServicos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 FreeAndNil(frmServicos);
end;

procedure TfrmServicos.FormCreate(Sender: TObject);
begin

 CaminhoListaInicial := dmPrincipal.CAMINHO_ARQUIVOS_MYDEED + '/Servicos.txt';
 if not FileExists(CaminhoListaInicial) then
 begin
   CriarListaInicial;
 end;
 cbServicos.Items.LoadFromFile(CaminhoListaInicial);

end;

procedure TfrmServicos.spdAddClick(Sender: TObject);
begin
 if not ExisteItem then
 begin
  ListBoxServicos.Items.Add(cbServicos.Items[cbServicos.ItemIndex]);
 end
 else if cbServicos.Items[cbServicos.ItemIndex].IsEmpty then
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

procedure TfrmServicos.spdExcluirClick(Sender: TObject);
begin
if ListBoxServicos.ItemIndex <> -1 then
begin
  ListBoxServicos.Items.Delete(ListBoxServicos.ItemIndex);
  ShowMessage('Serviço excluído!');
end
else
begin
  ShowMessage('Selecione um serviço antes de excluir!');
  Exit;
end;

end;

procedure TfrmServicos.spdOkClick(Sender: TObject);
begin

 frmFormulario.Show;
end;

end.
