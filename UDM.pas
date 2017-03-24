unit UDM;

interface

uses
  System.SysUtils, System.Classes,ioutils,FMX.dialogs, FMX.Types, FMX.Controls,
  System.ImageList, FMX.ImgList;

type
TStreamInfo = class(TObject)
    id: word;
    name: String;
    url: String;
    picture: String;
    category: String;
  public
    constructor Create;
  end;

  TMyConfig = class
  private
    constructor Create; overload;
  public
    ip: String;
    port: Integer;
    path: String;
    clientName: String;
    username: String;
    password: String;
    // TV Locked Status
    stream_locked: byte;
    stream_locked_id: Integer;
    stream_locked_name: String;
    stream_locked_url: String;
    last_stream_id: byte;
    runningtext: String;
    procedure load;
    function save: boolean;
  end;
  TDM = class(TDataModule)
    StyleBook1: TStyleBook;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    config: TMyConfig;
    KEY_DOWN_ACTIVE: boolean;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

Constructor TMyConfig.Create;
begin
  ip := '';
  port := 7070;
  path := '';
  clientName := '';
  username := '';
  password := '';
  stream_locked := 0;
  stream_locked_id := 0;
  stream_locked_name := '';
  stream_locked_url := '';
  last_stream_id := 0;
  runningtext := '';
end;

procedure TMyConfig.load;
var
  myFile: TextFile;
  text: string;
  filePath: String;
  i: Integer;
  list: TStringList;
begin
  try
    filePath := TPath.Combine(TPath.getdocumentspath, 'config.txt');
    list := TStringList.Create;
    list.LoadFromFile(filePath);
  except
    on E: Exception do
    begin
      showmessage('Error Load Config:' + E.Message);
      save;
      load;
      exit;
    end;

  end;
  if list.Count >= 1 then
  begin
    try
      self.ip := list[0];
    except
      on E: Exception do
      begin
        showmessage('Error IP:' + E.Message);
        self.ip := '127.0.0.1';
      end;
    end;
  end
  else
  begin
    self.ip := '127.0.0.1';
  end;

  if list.Count >= 2 then
  begin
    try
      self.port := strtoInt(list[1]);
    except
      on E: Exception do
      begin
        showmessage('Error Port:' + E.Message);
        self.port := 7070;
      end;
    end;
  end
  else
  begin
    self.port := 7070;
  end;

  if list.Count >= 3 then
  begin
    try
      self.path := list[2];
    except
      on E: Exception do
      begin
        showmessage('Error Path:' + E.Message);
        self.path := '';
      end;
    end;
  end
  else
  begin
    self.path := '';
  end;

   if list.Count >= 4 then
  begin
    try
      self.clientName := list[3];
    except
      on E: Exception do
      begin
        showmessage('Error clientName:' + E.Message);
        self.clientName := '';
      end;
    end;
  end
  else
  begin
    self.username := '';
  end;

  if list.Count >= 5 then
  begin
    try
      self.username := list[4];
    except
      on E: Exception do
      begin
        showmessage('Error Username:' + E.Message);
        self.username := '';
      end;
    end;
  end
  else
  begin
    self.username := '';
  end;

  if list.Count >= 6 then
  begin
    try
      self.password := list[5];
    except
      on E: Exception do
      begin
        showmessage('Error Password:' + E.Message);
        self.password := '';
      end;
    end;
  end
  else
  begin
    self.password := '';
  end;

  if list.Count >= 7 then
  begin
    try
      self.stream_locked := strtoInt(list[6]);
    except
      on E: Exception do
      begin
        showmessage('Error stream_locked:' + E.Message);
        self.stream_locked := 0;
      end;
    end;
  end
  else
  begin
    self.stream_locked := 0;
  end;

  if list.Count >= 8 then
  begin
    try
      self.stream_locked_id := strtoInt(list[7]);
    except
      on E: Exception do
      begin
        showmessage('Error stream_locked_id:' + E.Message);
        self.stream_locked_id := 0;
      end;
    end;
  end
  else
  begin
    self.stream_locked_id := 0;
  end;

  if list.Count >= 9 then
  begin
    try
      self.stream_locked_name := list[8];
    except
      on E: Exception do
      begin
        showmessage('Error stream_locked_name:' + E.Message);
        self.stream_locked_name := '';
      end;
    end;
  end
  else
  begin
    self.stream_locked_name := '';
  end;

  if list.Count >= 10 then
  begin
    try
      self.stream_locked_url := list[9];
    except
      on E: Exception do
      begin
        showmessage('Error stream_locked_url:' + E.Message);
        self.stream_locked_url := '';
      end;
    end;
  end
  else
  begin
    self.stream_locked_url := '';
  end;

  if list.Count >= 11 then
  begin
    try
      self.last_stream_id := strtoInt(list[10]);
    except
      on E: Exception do
      begin
        showmessage('Error last_stream_id:' + E.Message);
        self.last_stream_id := 0;
      end;
    end;
  end
  else
  begin
    self.last_stream_id := 0;
  end;

  if list.Count >= 12 then
  begin
    try
      self.runningtext := list[11];
    except
      on E: Exception do
      begin
        showmessage('Error runningtext:' + E.Message);
        self.runningtext := '';
      end;
    end;
  end
  else
  begin
    self.runningtext := '';
  end;
end;

function TMyConfig.save: boolean;
var
  myFile: TextFile;
  text: string;
  pathFile: String;
begin
  try
    pathFile := TPath.Combine(TPath.getdocumentspath, 'config.txt');
    // Try to open the Test.txt file for writing to
    AssignFile(myFile, pathFile);
    ReWrite(myFile);
    // Write a couple of well known words to this file
    WriteLn(myFile, ip);
    WriteLn(myFile, port.ToString);
    WriteLn(myFile, path);
    WriteLn(myFile, clientName);
    WriteLn(myFile, username);
    WriteLn(myFile, password);
    WriteLn(myFile, stream_locked.ToString);
    WriteLn(myFile, stream_locked_id);
    WriteLn(myFile, stream_locked_name);
    WriteLn(myFile, stream_locked_url);
    WriteLn(myFile, last_stream_id.ToString);
    WriteLn(myFile, runningtext);

    { ip: String;
      port: Integer;
      clientName:String;
      username: String;
      password: String;
      autologin: Integer;
      //TV Locked Status
      tv_locked:byte;
      tv_locked_id:integer;
      tv_locked_url:String;
      last_stream_id:Byte;
      runningtext:String; }

    // Close the file
    CloseFile(myFile);
    result := true;
  except
    on E: Exception do
    begin
      //showmessage(E.Message);
      result := false;
    end;

  end;
end;



{ TStreamInfo }

constructor TStreamInfo.Create;
begin
  id := 0;
  name := '';
  url := '';
  picture := '';
  category := '';
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  KEY_DOWN_ACTIVE:=false;
  config := TMyConfig.Create;
  config.load;
end;

end.
