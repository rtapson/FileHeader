unit tapKeyboardNotifier;

interface

uses
    System.Classes,
    Vcl.Menus,
    ToolsAPI;

type
    TFileHeaderKeyboardNotifier = class(TNotifierObject, IOTAKeyboardBinding)
    private
      FEditPosition: IOTAEditPosition;
      FHeaderMenu: TPopupMenu;
      FHeaderItem: TMenuItem;

      procedure HandleHeaderClick(Sender: TObject);
    public
      constructor Create;
      destructor Destroy; override;

      procedure AddFileHeader(const Context: IOTAKeyContext; KeyCode: TShortCut; var BindingResult: TKeyBindingResult);

      procedure BindKeyboard(const BindingServices: IOTAKeyBindingServices);
      function GetBindingType: TBindingType;
      function GetDisplayName: string;
      function GetName: string;

      procedure AfterSave;
      procedure BeforeSave;
      procedure Destroyed;
      procedure Modified;

    end;

implementation

uses
    System.Types,
    Vcl.Forms,
    Winapi.Windows,
    tapFileHeaderOptionsU;

var
  NotifierIndex: Integer;
  FOpFrame: TIDEHelpHelperIDEOptionsInterface;

{ TFileHeaderKeyboardNotifier }

procedure TFileHeaderKeyboardNotifier.BindKeyboard(const BindingServices: IOTAKeyBindingServices);
var
  PeriodChar: Word;
begin
  PeriodChar := Ord('H');
  BindingServices.AddKeyBinding([ShortCut(PeriodChar, [ssCtrl, ssShift])], AddFileHeader, nil);
end;

constructor TFileHeaderKeyboardNotifier.Create;
begin
  FHeaderMenu := TPopupMenu.Create(nil);
  FHeaderItem := TMenuItem.Create(FHeaderMenu);
  FHeaderItem.Caption := 'File Header';
  FHeaderItem.OnClick := HandleHeaderClick;
  FHeaderMenu.Items.Add(FHeaderItem);
end;

function TFileHeaderKeyboardNotifier.GetBindingType: TBindingType;
begin
  Result := btPartial;
end;

function TFileHeaderKeyboardNotifier.GetDisplayName: string;
begin
  Result := 'Add File Header';
end;

function TFileHeaderKeyboardNotifier.GetName: string;
begin
  Result := 'tapper.TSharper';
end;

procedure TFileHeaderKeyboardNotifier.HandleHeaderClick(Sender: TObject);
begin
  FEditPosition.Move(1, 1);
  FEditPosition.InsertText('/***** Copyright 2020 ***************/');
  FEditPosition.InsertCharacter(#13);
  FEditPosition.InsertCharacter(#10);
  FEditPosition.Move(FEditPosition.Row - 1, 1);
  FEditPosition.Move(FEditPosition.Row + 1, 1);
end;

procedure TFileHeaderKeyboardNotifier.AddFileHeader(const Context: IOTAKeyContext; KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  pnt: TPoint;
begin
  FEditPosition := Context.EditBuffer.EditPosition;
  if FEditPosition.Row = 1 then
  begin
    GetCursorPos(pnt);
    FHeaderMenu.Popup(pnt.X, pnt.Y);
  end;
  BindingResult := krNextProc;
end;

procedure TFileHeaderKeyboardNotifier.AfterSave;
begin

end;

procedure TFileHeaderKeyboardNotifier.BeforeSave;
begin

end;

destructor TFileHeaderKeyboardNotifier.Destroy;
begin
  FHeaderMenu.Free;
  inherited;
end;

procedure TFileHeaderKeyboardNotifier.Destroyed;
begin

end;

procedure TFileHeaderKeyboardNotifier.Modified;
begin

end;

procedure Register;
begin
  NotifierIndex := (BorlandIDEServices as IOTAKeyboardServices).AddKeyboardBinding(TFileHeaderKeyboardNotifier.Create);
  FOpFrame := TIDEHelpHelperIDEOptionsInterface.Create;
  (BorlandIDEServices as INTAEnvironmentOptionsServices).RegisterAddInOptions(FOpFrame);
end;

initialization
  Register;

finalization
  (BorlandIDEServices as IOTAKeyboardServices).RemoveKeyboardBinding(NotifierIndex);
  (BorlandIDEServices As INTAEnvironmentOptionsServices).UnregisterAddInOptions(FOpFrame);
  FOpFrame := Nil;
end.
