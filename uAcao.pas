unit uAcao;

interface

uses
  System.Classes;

type TAcao = class(TObject)

private



public

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

end;


implementation

end.
