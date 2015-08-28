unit uServico;

interface

uses
  System.Classes,uMensagem,Generics.Collections;

type TServico = class(TObject)

private



public

 constructor Create;
 destructor  Destroy;override;

 var
 CodServico : Integer;
 dtChegada :TDateTime;
 dtSaida   :TDateTime;
 dtPostagem : TDateTime;
 DescricaoRapida : String;
 codAcoesRealizadas : array of Integer;
 listaAcoesRealizadas : TStringList;
 Observacoes : String;
 Autor : String;
 Cliente : String;
 NumOrdemServico: Integer;
 Mensagens : TDictionary<Integer,TMensagem>;

end;


implementation

{ TAcao }

constructor TServico.Create;
begin
 inherited;
 listaAcoesRealizadas := TStringList.Create;
 Mensagens := TDictionary<Integer,TMensagem>.Create;
end;

destructor TServico.Destroy;
begin
 inherited;
 listaAcoesRealizadas.Free;
 Mensagens.Free;
end;

end.
