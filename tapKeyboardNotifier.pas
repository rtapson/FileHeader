unit tapKeyboardNotifier;

interface

uses
    System.Classes,
    ToolsAPI;

type
    TFileHeaderKeyboardNotifier = class(TNotifierObject, IOTAKeyboardBinding)
    private
      FEditPosition: IOTAEditPosition;

      procedure InsertHeader;
      function GetFileType: string;
      function GetFileHeader(const FileType: string): string;
    public
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
  Menus,
  System.Types,
  SysUtils,
  Vcl.Forms,
  Winapi.Windows,
  tapFileHeaderOptionsU,
  tapFileHeaderRepo,
  tapKeywords,
  tapToolsApiUtils;

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

function TFileHeaderKeyboardNotifier.GetBindingType: TBindingType;
begin
  Result := btPartial;
end;

function TFileHeaderKeyboardNotifier.GetDisplayName: string;
begin
  Result := 'Add File Header';
end;

function TFileHeaderKeyboardNotifier.GetFileHeader(const FileType: string): string;
var
  FileHeaderRepo: TFileHeaderRepository;
begin
  FileHeaderRepo := TFileHeaderRepository.Create;
  try
    Result := FileHeaderRepo.GetHeaderText(FileType);
  finally
    FileHeaderRepo.Free;
  end;
end;

function TFileHeaderKeyboardNotifier.GetFileType: string;
var
  FileName: string;
begin
  FileName := TToolsApiUtils.ActiveSourceEditor.FileName;
  Result := ExtractFileExt(FileName);
end;

function TFileHeaderKeyboardNotifier.GetName: string;
begin
  Result := 'tapper.FileHeader';
end;

procedure TFileHeaderKeyboardNotifier.InsertHeader;
var
  HeaderText: string;
begin
  HeaderText := GetFileHeader(GetFileType);

  FEditPosition.Move(1, 1);
  FEditPosition.InsertText(THeaderKeywords.ProcessKeywords(HeaderText));
  FEditPosition.Move(FEditPosition.Row - 1, 1);
  FEditPosition.Move(FEditPosition.Row + 1, 1);
end;

procedure TFileHeaderKeyboardNotifier.AddFileHeader(const Context: IOTAKeyContext; KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  FEditPosition := Context.EditBuffer.EditPosition;
  if FEditPosition.Row = 1 then
    InsertHeader;
  BindingResult := krNextProc;
end;

procedure TFileHeaderKeyboardNotifier.AfterSave;
begin

end;

procedure TFileHeaderKeyboardNotifier.BeforeSave;
begin

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
