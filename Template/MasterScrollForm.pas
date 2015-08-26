//---------------------------------------------------------------------------

// This software is Copyright (c) 2013 Embarcadero Technologies, Inc.
// You may only use this software if you are an authorized licensee
// of Delphi, C++Builder or RAD Studio (Embarcadero Products).
// This software is considered a Redistributable as defined under
// the software license agreement that comes with the Embarcadero Products
// and is subject to that software license agreement.

//---------------------------------------------------------------------------
unit MasterScrollForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Memo, FMX.Edit, FMX.Layouts, FMX.ListBox,
  FMX.Objects;

type
  TFormMain = class(TForm)
    ScrollPrincipal: TVertScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
                                        KeyboardVisible: Boolean;
                                        const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
                                       KeyboardVisible: Boolean;
                                       const Bounds: TRect);
    procedure FormFocusChanged(Sender: TObject);
  private
    { Private declarations }

    FKBBounds: TRectF;
    FNeedOffset: Boolean;
    procedure CalcContentBoundsProc(Sender: TObject;
                                    var ContentBounds: TRectF);
    procedure RestorePosition;
    procedure UpdateKBBounds;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses System.Math;

{$R *.fmx}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  ScrollPrincipal.OnCalcContentBounds := CalcContentBoundsProc;
end;

procedure TFormMain.CalcContentBoundsProc(Sender: TObject;
                                       var ContentBounds: TRectF);
begin
  if FNeedOffset and (FKBBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom,
                                2 * ClientHeight - FKBBounds.Top);
  end;
end;

procedure TFormMain.RestorePosition;
begin
  ScrollPrincipal.ViewportPosition := PointF(ScrollPrincipal.ViewportPosition.X, 0);
  ScrollPrincipal.RealignContent;
end;

procedure TFormMain.UpdateKBBounds;
var
  LFocused : TControl;
  LFocusRect: TRectF;
begin
  FNeedOffset := False;
  if Assigned(Focused) then
  begin
    LFocused := TControl(Focused.GetObject);
    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(ScrollPrincipal.ViewportPosition);
    if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and
       (LFocusRect.Bottom > FKBBounds.Top) then
    begin
      FNeedOffset := True;
      ScrollPrincipal.RealignContent;
      Application.ProcessMessages;
      ScrollPrincipal.ViewportPosition :=
        PointF(ScrollPrincipal.ViewportPosition.X,
               LFocusRect.Bottom - FKBBounds.Top);
    end;
  end;
  if not FNeedOffset then
    RestorePosition;
end;

procedure TFormMain.FormFocusChanged(Sender: TObject);
begin
  UpdateKBBounds;
end;

procedure TFormMain.FormVirtualKeyboardHidden(Sender: TObject;
                                           KeyboardVisible: Boolean;
                                           const Bounds: TRect);
begin
  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := False;
  RestorePosition;
end;

procedure TFormMain.FormVirtualKeyboardShown(Sender: TObject;
                                          KeyboardVisible: Boolean;
                                          const Bounds: TRect);
begin
  FKBBounds := TRectF.Create(Bounds);
  FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
  UpdateKBBounds;
end;

end.
