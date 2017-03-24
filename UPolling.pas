unit UPolling;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit, FMX.ScrollBox,
  FMX.Memo, FMX.Objects, json, UDM, System.Generics.Collections,
  IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, UThanks;

type

  TCallbackType = (ctSavePolling, ctLoadPolling);
  _TMyCallback = procedure(success: boolean; logs: TStringList) of object;

  TMyThread = Class(TThread)
    Procedure Execute; override;
  private
    success: boolean;
    logs: TStringList;
    cb: _TMyCallback;
    procedure SavePolling;
  public
    ct: TCallbackType;
    params: TStringList;
  End;

  TFormPolling = class(TForm)
    GridPanelLayout1: TGridPanelLayout;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    ToolBar2: TToolBar;
    Label2: TLabel;
    GridPanelLayout2: TGridPanelLayout;
    btnSP: TRoundRect;
    btnCP: TRoundRect;
    btnTP: TRoundRect;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    IdHTTP1: TIdHTTP;
    Layout1: TLayout;
    Layout2: TLayout;
    ToolBar3: TToolBar;
    Label7: TLabel;
    GridPanelLayout3: TGridPanelLayout;
    Label11: TLabel;
    GridPanelLayout4: TGridPanelLayout;
    Memo1: TMemo;
    Button1: TButton;
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Memo1Enter(Sender: TObject);
    procedure Memo1Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSPClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    pilihan: String;
    ft: TFormThanks;
    procedure callbackLoadChannel(success: boolean; logs: TStringList);
    procedure OnCloseFormThanks(Sender: TObject; var Action: TCloseAction);
  public
    { Public declarations }
  end;

var
  FormPolling: TFormPolling;

implementation

{$R *.fmx}

procedure TMyThread.SavePolling;
var
  lHTTP: TIdHTTP;
  response: String;
  jsonArray: TJSONArray;
  jsonRoot: TJSONObject;
  jsonObject: TJSONObject;
  code: String;
  i: Integer;
  si: TStreamInfo;
  channels: TList<TStreamInfo>;
  url: String;
begin
  logs := TStringList.Create;
  lHTTP := TIdHTTP.Create(nil);
  success := true;
  code := '';
  channels := TList<TStreamInfo>.Create;
  params.Add('rand=' + IntToStr(Random(1000)));
  url := 'http://' + DM.config.ip + DM.config.path +
    '/antrian/scripts/android/post.php';
  logs.Add(url);
  try
    try
      lHTTP.Request.ContentType := 'application/x-www-form-urlencoded';
      lHTTP.Request.Method := 'post';
      response := lHTTP.Post(url, params);
      logs.Add(response);
    except
      on E: Exception do
      begin
        logs.Add(E.Message);
        success := false;
      end;
    end;
  finally
    lHTTP.Free;
  end;
  if Assigned(cb) then
    Synchronize(
      procedure
      begin
        cb(success, logs)
      end);

end;

procedure TMyThread.Execute;
begin
  case ct of
    ctSavePolling:
      begin
        SavePolling;
      end;
  end;
end;

procedure TFormPolling.Image1Click(Sender: TObject);
begin
  //
end;

procedure TFormPolling.Image2Click(Sender: TObject);
begin
  //
end;

procedure TFormPolling.Image3Click(Sender: TObject);
begin
  //
end;

procedure TFormPolling.Memo1Enter(Sender: TObject);
begin
  if Memo1.Text.Trim = 'Ketik Komentar' then
    Memo1.Text := '';
end;

procedure TFormPolling.Memo1Exit(Sender: TObject);
begin
  if Memo1.Text.Trim = '' then
    Memo1.Text := 'Ketik Komentar';
end;

procedure TFormPolling.btnSPClick(Sender: TObject);
var
  rec: TRoundRect;
begin
  rec := TRoundRect(Sender);
  if rec.Tag = 0 then
    pilihan := 'pilihan=Sangat Puas'
  else if rec.Tag = 1 then
    pilihan := 'pilihan=Cukup Puas'
  else if rec.Tag = 2 then
    pilihan := 'pilihan=Tidak Puas'
  else
  begin
    showmessage('Tentukan Pilihan');
    exit;
  end;

  Memo1.Lines.Clear;
  Layout1.Visible := false;
  Layout2.Visible := true;
  Layout2.Align := TAlignLayout.Client;
end;

procedure TFormPolling.OnCloseFormThanks(Sender: TObject;
var Action: TCloseAction);
begin
  Layout2.Visible := false;
  Layout1.Visible := true;
  Layout1.Align := TAlignLayout.Client;
  Action := TCloseAction.caFree;
end;

procedure TFormPolling.Button1Click(Sender: TObject);
var
  _params: TStringList;
  rec: TRoundRect;
  r: Integer;

begin
  rec := TRoundRect(Sender);
  _params := TStringList.Create;
  _params.Add('tag=save_polling');
  _params.Add('sub_tag=update_polling');
  _params.Add('comment=' + Memo1.Text);
  _params.Add(pilihan);
  with TMyThread.Create(true) do
  begin
    FreeOnTerminate := true;
    cb := callbackLoadChannel;
    params := _params;
    Resume;
  end;
  ft := TFormThanks.Create(self);
  ft.Label11.Text := 'Sedang Menyimpan Data...';
  ft.OnClose := OnCloseFormThanks;
  ft.Show;

end;

procedure TFormPolling.callbackLoadChannel(success: boolean; logs: TStringList);
var
  i: Integer;
begin
  if success then
  begin
    Memo1.Lines.Clear;
    ft.Label11.Text := 'Terimakasih Atas Masukan Anda, Simpan Data berhasil';
  end
  else
  begin
    ft.Label11.Text := 'Gagal Menyimpan Data';
    for i := 0 to logs.Count - 1 do
    begin
      ft.Label11.Text := ft.Label11.Text + ',' + logs[i];
    end;
  end;
  ft.Timer1.Enabled := true;
end;

procedure TFormPolling.FormCreate(Sender: TObject);
begin
  self.StyleBook := DM.StyleBook1;
  Layout2.Visible:=false;
  Layout1.Visible:=true;
  Layout1.Align:=TAlignLayout.Client;
end;

end.
