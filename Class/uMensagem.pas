unit uMensagem;



interface

uses
  Generics.Collections;

type TMensagem = class(TObject)


private


public

 var
  Autor : String;
  Texto : String;
  DtPostagem : TDateTime;
  Anexos : TDictionary<Integer,TObject>;

 constructor Create;

 destructor Destroy;override;

end;

implementation

{ TMensagem }

constructor TMensagem.Create;
begin
 Anexos := TDictionary<Integer,TObject>.Create;
end;

destructor TMensagem.Destroy;
begin
 Anexos.Free;
  inherited;
end;

end.
