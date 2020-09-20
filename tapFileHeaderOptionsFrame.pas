unit tapFileHeaderOptionsFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  tapFileHeaderRepo, System.ImageList, Vcl.ImgList, Vcl.Buttons;

type
  TfrmFileHeaderOptions = class(TFrame)
    Label2: TLabel;
    FileTypesCombobox: TComboBox;
    Label3: TLabel;
    FileHeaderMemo: TMemo;
    CurrentYearButton: TSpeedButton;
    ImageList1: TImageList;
    CurrentMonthButton: TSpeedButton;
    CurrentDayButton: TSpeedButton;
    CurrentTimeButton: TSpeedButton;
    ProjectGroupButton: TSpeedButton;
    ProjectButton: TSpeedButton;
    FileNameButton: TSpeedButton;
    procedure FileTypesComboboxChange(Sender: TObject);
    procedure FileHeaderMemoChange(Sender: TObject);
    procedure CurrentYearButtonClick(Sender: TObject);
    procedure CurrentMonthButtonClick(Sender: TObject);
    procedure CurrentDayButtonClick(Sender: TObject);
    procedure CurrentTimeButtonClick(Sender: TObject);
    procedure FileNameButtonClick(Sender: TObject);
    procedure ProjectButtonClick(Sender: TObject);
    procedure ProjectGroupButtonClick(Sender: TObject);
  private
    { Private declarations }
    FFileHeaders: TFileHeaderRepository;
  public
    { Public declarations }
    procedure InitFrame(FileHeaders: TFileHeaderRepository);
    procedure FinalizeFrame();
  end;

implementation

{$R *.dfm}

uses
  tapKeywords;

{ TfrmFileHeaderOptions }

procedure TfrmFileHeaderOptions.FileHeaderMemoChange(Sender: TObject);
begin
  FFileHeaders.FileHeaders.AddOrSetValue(FileTypesCombobox.Text, FileHeaderMemo.Text);
end;

procedure TfrmFileHeaderOptions.FileNameButtonClick(Sender: TObject);
begin
  FileHeaderMemo.SelText := THeaderKeywords.FileName;
end;

procedure TfrmFileHeaderOptions.FileTypesComboboxChange(Sender: TObject);
var
  FileHeader: string;
begin
  if FFileHeaders.FileHeaders.TryGetValue(FileTypesCombobox.Text, FileHeader) then
  begin
    FileHeaderMemo.Clear;
    FileHeaderMemo.Lines.Add(FileHeader);
  end;
end;

procedure TfrmFileHeaderOptions.FinalizeFrame;
begin
  FFileHeaders.LastFileType := FileTypesCombobox.Text;
  FFileHeaders.Save;
end;

procedure TfrmFileHeaderOptions.InitFrame(FileHeaders: TFileHeaderRepository);
var
  FileType: string;
begin
  FFileHeaders := FileHeaders;
  FileTypesCombobox.Clear;
  for FileType in FileHeaders.FileHeaders.Keys  do
  begin
    FileTypesCombobox.Items.Add(FileType);
  end;

  if FFileHeaders.LastFileType <> '' then
  begin
    FileTypesCombobox.Text := FFileHeaders.LastFileType;
    FileTypesComboboxChange(FileTypesCombobox);
  end;

end;

procedure TfrmFileHeaderOptions.ProjectButtonClick(Sender: TObject);
begin
  FileHeaderMemo.SelText := THeaderKeywords.Project;
end;

procedure TfrmFileHeaderOptions.ProjectGroupButtonClick(Sender: TObject);
begin
  FileHeaderMemo.SelText := THeaderKeywords.ProjectGroup;
end;

procedure TfrmFileHeaderOptions.CurrentDayButtonClick(Sender: TObject);
begin
  FileHeaderMemo.SelText := THeaderKeywords.CurrentDay;
end;

procedure TfrmFileHeaderOptions.CurrentMonthButtonClick(Sender: TObject);
begin
  FileHeaderMemo.SelText := THeaderKeywords.CurrentMonth;
end;

procedure TfrmFileHeaderOptions.CurrentTimeButtonClick(Sender: TObject);
begin
  FileHeaderMemo.SelText := THeaderKeywords.CurrentTime;
end;

procedure TfrmFileHeaderOptions.CurrentYearButtonClick(Sender: TObject);
begin
  FileHeaderMemo.SelText := THeaderKeywords.CurrentYear;
end;

end.
