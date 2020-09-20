unit tapToolsApiUtils;

interface

uses
  SysUtils,
  ToolsApi;

type
  TToolsApiUtils = class
  public
    class function SourceEditor(Module: IOTAModule): IOTASourceEditor;
    class function ActiveSourceEditor : IOTASourceEditor;
    class function CurrentProjectGroup: IOTAProjectGroup;
  end;

implementation

{ TToolsApiUtils }

{ Return the current project group, or nil if there is no project group. }
class function TToolsApiUtils.CurrentProjectGroup: IOTAProjectGroup;
var
  I: Integer;
  Svc: IOTAModuleServices;
  Module: IOTAModule;
begin
  Supports(BorlandIDEServices, IOTAModuleServices, Svc);
  for I := 0 to Svc.ModuleCount - 1 do
  begin
    Module := Svc.Modules[I];
    if Supports(Module, IOTAProjectGroup, Result) then
      Exit;
  end;
  Result := nil;
end;

class function TToolsApiUtils.ActiveSourceEditor: IOTASourceEditor;
var
  CM : IOTAModule;
begin
  Result := Nil;
  if BorlandIDEServices = nil then Exit;
  CM := (BorlandIDEServices as IOTAModuleServices).CurrentModule;
  Result := SourceEditor(CM);
end;

class function TToolsApiUtils.SourceEditor(Module: IOTAModule): IOTASourceEditor;
var
  iFileCount: Integer;
  i: Integer;
begin
  Result := nil;
  if Module = nil then
    Exit;
  iFileCount := Module.GetModuleFileCount;
  for i := 0 To iFileCount - 1 do
    if Module.GetModuleFileEditor(i).QueryInterface(IOTASourceEditor, Result) = S_OK then
      Break;
end;

end.
