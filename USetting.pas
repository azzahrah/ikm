unit USetting;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Edit;

type
  TFormSetting = class(TForm)
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    GridPanelLayout1: TGridPanelLayout;
    ToolBar2: TToolBar;
    SpeedButton2: TSpeedButton;
    Label2: TLabel;
    txtIP: TEdit;
    Label3: TLabel;
    txtPath: TEdit;
    Label4: TLabel;
    txtPort: TEdit;
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSetting: TFormSetting;

implementation

uses UDM;

{$R *.fmx}

procedure TFormSetting.FormShow(Sender: TObject);
begin
  try
    txtIP.Text := DM.config.ip;
    txtPath.Text := DM.config.path;
    txtPort.Text := DM.config.port.ToString;
  except
  end;
end;

procedure TFormSetting.SpeedButton2Click(Sender: TObject);
begin
  DM.config.ip := txtIP.Text;
  DM.config.path := txtPath.Text;
  DM.config.port := StrToInt(txtPort.Text);
  DM.config.save;
end;

end.
