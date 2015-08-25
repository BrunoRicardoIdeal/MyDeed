unit uAcao;

interface

uses
  System.Classes,uMensagem,Generics.Collections;

type TAcao = class(TObject)

private



public

 constructor Create;
 destructor  Destroy;override;

 var
 CodAcao : Integer;
 dtChegada :TDate;
 hsChegada :TTime;
 dtSaida   :TDate;
 hsSaida   :TTime;
 DescricaoRapida : String;
 codServicosRealizados : array of Integer;
 listaServicosRealizados : TStringList;
 Observacoes : String;
 Autor : String;
 Cliente : String;
 NumOrdemServico: Integer;
 Mensagens : TDictionary<Integer,TMensagem>;

end;


implementation

{ TAcao }

constructor TAcao.Create;
begin
 inherited;
 listaServicosRealizados := TStringList.Create;
 Mensagens := TDictionary<Integer,TMensagem>.Create;
end;

destructor TAcao.Destroy;
begin
 inherited;
 listaServicosRealizados.Free;
 Mensagens.Free;
end;

end.
