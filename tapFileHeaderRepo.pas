unit tapFileHeaderRepo;

interface

uses
  Generics.Collections;

type
  TFileHeaderRepository = class(TObject)
  private
    FFileHeaders: TDictionary<string, string>;
    FLastFileType: string;
    procedure Load;
    procedure LoadFileHeaders;
  public
    constructor Create;
    destructor Destroy; override;

    function GetHeaderText(const FileType: string): string;
    procedure Save;

    property LastFileType: string read FLastFileType write FLastFileType;
    property FileHeaders: TDictionary<string, string> read FFileHeaders write FFileHeaders;
  end;

implementation

uses
  Classes,
  Winapi.Windows,
  Registry;

const
  FILE_HEADER_KEY = 'Software\TapperMedia\FileHeader';
  HEADERS_KEY = 'Software\TapperMedia\FileHeader\Headers';

{ TFileHeaderRepository }

constructor TFileHeaderRepository.Create;
begin
  FFileHeaders := TDictionary<string, string>.Create;
  Load;
end;

destructor TFileHeaderRepository.Destroy;
begin
  FFileHeaders.Free;
  inherited;
end;

function TFileHeaderRepository.GetHeaderText(const FileType: string): string;
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_CURRENT_USER;

    if Registry.OpenKeyReadOnly(HEADERS_KEY) then
    begin
      Result := Registry.ReadString(FileType);
      Registry.CloseKey;
    end;
  finally
    Registry.Free;
  end;
end;

procedure TFileHeaderRepository.Load;
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.OpenKeyReadOnly(FILE_HEADER_KEY) then
    begin
      FLastFileType := Registry.ReadString('LastFileType');
      Registry.CloseKey;
    end;
  finally
    Registry.Free;
  end;
  LoadFileHeaders;
end;

procedure TFileHeaderRepository.LoadFileHeaders;
var
  ValueNames: TStringList;
  ValueName: string;
  Registry: TRegistry;
begin
  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_CURRENT_USER;

    if Registry.OpenKeyReadOnly(HEADERS_KEY) then
    begin
      ValueNames := TStringList.Create;
      try
        Registry.GetValueNames(ValueNames);
        for ValueName in ValueNames do
        begin
          FFileHeaders.Add(ValueName, Registry.ReadString(ValueName));
        end;
      finally
        ValueNames.Free;
      end;
      Registry.CloseKey;
    end;
  finally
    Registry.Free;
  end;
end;

procedure TFileHeaderRepository.Save;
var
  ValueName: string;
  Registry: TRegistry;
begin
  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.OpenKey(FILE_HEADER_KEY, True) then
    begin
      Registry.WriteString('LastFileType', LastFileType);
      Registry.CloseKey;
    end;

    if Registry.OpenKey(HEADERS_KEY, True) then
    begin
      for ValueName in FFileHeaders.Keys do
      begin
        Registry.WriteExpandString(ValueName, FFileHeaders.Items[ValueName]);
      end;
      Registry.CloseKey;
    end;
  finally
    Registry.Free;
  end;
end;

end.
