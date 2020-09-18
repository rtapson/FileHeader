unit tapFileHeaderOptionsFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmFileHeaderOptions = class(TFrame)
    Label2: TLabel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    Memo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitFrame();
    procedure FinalizeFrame();
  end;

implementation

{$R *.dfm}

{ TfrmFileHeaderOptions }

procedure TfrmFileHeaderOptions.FinalizeFrame;
begin

end;

procedure TfrmFileHeaderOptions.InitFrame;
begin

end;

end.
