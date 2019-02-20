unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls,
  FileObserverEx, FMX.Edit;

type
  TForm1 = class(TForm)
    sw1: TSwitch;
    edPath: TEdit;
    procedure sw1Switch(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormSaveState(Sender: TObject);
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
  System.IOUtils,
  Androidapi.Helpers, Androidapi.JNIBridge, Androidapi.JNI.JavaTypes;

type
  TFileObserverHandler = class(TJavaLocal, JIFileObserverHandler)
    procedure onEvent(P1: Integer; P2: JString); cdecl;
  end;

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
var
  LReader: TBinaryReader;
begin
  FFileObserverHandler := TFileObserverHandler.Create;
  SaveState.StoragePath := TPath.GetHomePath;
  if SaveState.Stream.Size > 0 then
  begin
    LReader := TBinaryReader.Create(SaveState.Stream);
    try
      edPath.Text := LReader.ReadString;
    finally
      FreeAndNil(LReader);
    end;
  end;
end;

procedure TForm1.FormSaveState(Sender: TObject);
var
  LWriter: TBinaryWriter;
begin
  SaveState.Stream.Clear;
  if edPath.Text.Length > 0 then
  begin
    LWriter := TBinaryWriter.Create(SaveState.Stream);
    try
      LWriter.Write(edPath.Text);
    finally
      FreeAndNil(LWriter);
    end;
  end;
end;

procedure TForm1.sw1Switch(Sender: TObject);
begin
  if TSwitch(Sender).IsChecked then
  begin
    FFileObserver := TJFileObserverEx.JavaClass.init
      (StringToJString(edPath.Text), FFileObserverHandler);
    FFileObserver.startWatching;
  end
  else if Assigned(FFileObserver) then
    FFileObserver.stopWatching;
end;

{ TFileObserverHandler }

procedure TFileObserverHandler.onEvent(P1: Integer; P2: JString);
begin
  Log.d('onEvent: %d, %s  ', [P1, JStringToString(P2)]);
end;

end.
