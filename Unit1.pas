unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    sw1: TSwitch;
    procedure sw1Switch(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FFileObserver: JFileObserverEx;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  ;

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FFileObserver := TJFileObserverEx.JavaClass.init;
end;

procedure TForm1.sw1Switch(Sender: TObject);
begin
  if TSwitch(Sender).IsChecked then
    FFileObserver.startWatching
  else
    FFileObserver.stopWatching;
end;

end.
