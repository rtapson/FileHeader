unit tapFileHeaderOptionsU;

interface

uses
  ToolsAPI,
  Vcl.Forms,
  tapFileHeaderOptionsFrame,
  tapFileHeaderRepo;

type
  TIDEHelpHelperIDEOptionsInterface = Class(TInterfacedObject, INTAAddInOptions)
  strict private
    FFrame : TfrmFileHeaderOptions;
    FFileHeaders: TFileHeaderRepository;
  strict protected

  public
    Procedure DialogClosed(Accepted: Boolean);
    Procedure FrameCreated(AFrame: TCustomFrame);
    Function GetArea: String;
    Function GetCaption: String;
    Function GetFrameClass: TCustomFrameClass;
    Function GetHelpContext: Integer;
    Function IncludeInIDEInsight: Boolean;
    Function ValidateContents: Boolean;
  end;

implementation

{ TIDEHelpHelperIDEOptionsInterface }

procedure TIDEHelpHelperIDEOptionsInterface.DialogClosed(Accepted: Boolean);
begin
  if Accepted then
  begin
    FFrame.FinalizeFrame;
  end;
end;

procedure TIDEHelpHelperIDEOptionsInterface.FrameCreated(AFrame: TCustomFrame);
begin
  if AFrame is TfrmFileHeaderOptions  then
  begin
    FFileHeaders := TFileHeaderRepository.Create;

    FFrame := AFrame as TfrmFileHeaderOptions;
    FFrame.InitFrame(FFileHeaders);
  end;
end;

function TIDEHelpHelperIDEOptionsInterface.GetArea: String;
begin
  Result := '';
end;

function TIDEHelpHelperIDEOptionsInterface.GetCaption: String;
begin
  Result := 'File Header';
end;

function TIDEHelpHelperIDEOptionsInterface.GetFrameClass: TCustomFrameClass;
begin
  Result := TfrmFileHeaderOptions;
end;

function TIDEHelpHelperIDEOptionsInterface.GetHelpContext: Integer;
begin
  Result := 0;
end;

function TIDEHelpHelperIDEOptionsInterface.IncludeInIDEInsight: Boolean;
begin
  Result := True;
end;

function TIDEHelpHelperIDEOptionsInterface.ValidateContents: Boolean;
begin
  Result := True;
end;

end.
