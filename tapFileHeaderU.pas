unit tapFileHeaderU;

interface

uses
    System.Classes,
    ToolsAPI;

type
  TFileUnitHeaderWizard = class(TInterfacedObject, IOTANotifier, IOTAIDENotifier)
  private
    procedure AddUnitHeader;
  public
    //IOTAIDENotifier
    procedure AfterCompile(Succeeded: Boolean);
    procedure BeforeCompile(const Project: IOTAProject; var Cancel: Boolean);
    procedure FileNotification(NotifyCode: TOTAFileNotification; const FileName: string; var Cancel: Boolean);


    //Notifier methods
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;
  end;

///Test comment

implementation


{ TFileUnitHeaderWizard }


procedure TFileUnitHeaderWizard.Modified;
begin

end;

procedure TFileUnitHeaderWizard.AddUnitHeader;
var
    EditorServices: IOTAEditorServices;
    EditView: IOTAEditView;
    copyright: string;
begin
  copyright := '// copyright © 2011 by tmssoftware.com ';

  EditorServices := BorlandIDEServices as IOTAEditorServices;

  EditView := EditorServices.TopView;

  if Assigned(EditView) then
  begin
    // position cursor at 1,1
    EditView.Buffer.EditPosition.Move(1, 1);
    // insert copyright notice on top
    EditView.Buffer.EditPosition.InsertText(copyright);
  end;
end;

procedure TFileUnitHeaderWizard.AfterCompile(Succeeded: Boolean);
begin

end;

procedure TFileUnitHeaderWizard.AfterSave;
begin

end;

procedure TFileUnitHeaderWizard.BeforeCompile(const Project: IOTAProject;
  var Cancel: Boolean);
begin

end;

procedure TFileUnitHeaderWizard.BeforeSave;
begin
  AddUnitHeader;
end;

procedure TFileUnitHeaderWizard.Destroyed;
begin

end;

procedure TFileUnitHeaderWizard.FileNotification(NotifyCode: TOTAFileNotification; const FileName: string; var Cancel: Boolean);
begin
  case NotifyCode of
      ofnFileOpening: ;
      ofnFileOpened: ;
      ofnFileClosing: ;
      ofnDefaultDesktopLoad: ;
      ofnDefaultDesktopSave: ;
      ofnProjectDesktopLoad: ;
      ofnProjectDesktopSave: ;
      ofnPackageInstalled: ;
      ofnPackageUninstalled: ;
      ofnActiveProjectChanged: ;
      ofnProjectOpenedFromTemplate: ;
  end;
end;

//initialization
//    RegisterPackageWizard(TFileUnitHeaderWizard.Create);

end.
