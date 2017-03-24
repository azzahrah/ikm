unit Umain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.VideoView, FMX.VLC, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.TabControl, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  System.Generics.Collections, json, UDM, FMX.Edit, Androidapi.Helpers,
  FMX.Platform.Android, FMX.VirtualKeyboard, System.Actions, FMX.ActnList;

type


  TFormMain = class(TForm)
    IdHTTP1: TIdHTTP;
    ToolBar1: TToolBar;
    Label1: TLabel;
    GridPanelLayout1: TGridPanelLayout;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    ToolBar2: TToolBar;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation
uses UPolling,USetting;

{$R *.fmx}

procedure TFormMain.FormActivate(Sender: TObject);
begin
  //
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  //
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Self.StyleBook := DM.StyleBook1;
end;

procedure TFormMain.FormDeactivate(Sender: TObject);
begin
  //
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TFormMain.FormHide(Sender: TObject);
begin
  //
end;

procedure TFormMain.FormResize(Sender: TObject);
begin
  //
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  //
end;



procedure TFormMain.SpeedButton1Click(Sender: TObject);
var
  fp:TFormPolling;
begin
  fp:=TFormPolling.Create(nil);
  fp.show;
end;


procedure TFormMain.SpeedButton3Click(Sender: TObject);
var
  fp:TFormSetting;
begin
  fp:=TFormSetting.Create(nil);
  fp.show;
end;

end.
