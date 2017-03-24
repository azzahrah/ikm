unit UThanks;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TFormThanks = class(TForm)
    Layout1: TLayout;
    Label11: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    counter:Integer;
  public
    { Public declarations }
  end;

var
  FormThanks: TFormThanks;

implementation
uses UDM;

{$R *.fmx}

procedure TFormThanks.FormCreate(Sender: TObject);
begin
  counter:=0;
  Self.StyleBook:=DM.StyleBook1;
end;

procedure TFormThanks.Timer1Timer(Sender: TObject);
begin
  Inc(counter);
  if counter>=3 then
     Self.Close;
end;

end.
