unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls,
  FileObserverEx;

type
  TForm1 = class(TForm)
    sw1: TSwitch;
    procedure sw1Switch(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FFileObserver: JFileObserverEx;
    FFileObserverHandler: JIFileObserverHandler;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Androidapi.Helpers, Androidapi.JNIBridge, Androidapi.JNI.JavaTypes;

type
  TFileObserverHandler = class(TJavaLocal, JIFileObserverHandler)
    procedure onEvent(P1: Integer; P2: JString); cdecl;
  end;

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FFileObserverHandler := TFileObserverHandler.Create;
  FFileObserver := TJFileObserverEx.JavaClass.init(StringToJString('/mnt/sdcard/Movies'), FFileObserverHandler);
end;

procedure TForm1.sw1Switch(Sender: TObject);
begin
  if TSwitch(Sender).IsChecked then
    FFileObserver.startWatching
  else
    FFileObserver.stopWatching;
end;

{ TFileObserverHandler }

procedure TFileObserverHandler.onEvent(P1: Integer; P2: JString);
begin
  Log.d('onEvent: %d, %s', [P1, JStringToString(P2)]);
end;

end.
