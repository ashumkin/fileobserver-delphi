{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2014 Embarcadero Technologies, Inc.      }
{                                                       }
{*******************************************************}

unit FileObserverEx;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes;

type
// ===== Forward declarations =====

  JFileObserver = interface;//android.os.FileObserver
  JFileObserverEx = interface;//ru.zapped.test.fileobserverex.FileObserverEx
  JIFileObserverHandler = interface;//ru.zapped.test.fileobserverex.IFileObserverHandler

// ===== Interface declarations =====

  JFileObserverClass = interface(JObjectClass)
    ['{2F555F55-7F76-4625-A686-94F45924CEED}']
    {class} function _GetACCESS: Integer;
    {class} function _GetALL_EVENTS: Integer;
    {class} function _GetATTRIB: Integer;
    {class} function _GetCLOSE_NOWRITE: Integer;
    {class} function _GetCLOSE_WRITE: Integer;
    {class} function _GetCREATE: Integer;
    {class} function _GetDELETE: Integer;
    {class} function _GetDELETE_SELF: Integer;
    {class} function _GetMODIFY: Integer;
    {class} function _GetMOVED_FROM: Integer;
    {class} function _GetMOVED_TO: Integer;
    {class} function _GetMOVE_SELF: Integer;
    {class} function _GetOPEN: Integer;
    {class} function init(path: JString): JFileObserver; cdecl; overload;
    {class} function init(path: JString; mask: Integer): JFileObserver; cdecl; overload;
    {class} property ACCESS: Integer read _GetACCESS;
    {class} property ALL_EVENTS: Integer read _GetALL_EVENTS;
    {class} property ATTRIB: Integer read _GetATTRIB;
    {class} property CLOSE_NOWRITE: Integer read _GetCLOSE_NOWRITE;
    {class} property CLOSE_WRITE: Integer read _GetCLOSE_WRITE;
    {class} property CREATE: Integer read _GetCREATE;
    {class} property DELETE: Integer read _GetDELETE;
    {class} property DELETE_SELF: Integer read _GetDELETE_SELF;
    {class} property MODIFY: Integer read _GetMODIFY;
    {class} property MOVED_FROM: Integer read _GetMOVED_FROM;
    {class} property MOVED_TO: Integer read _GetMOVED_TO;
    {class} property MOVE_SELF: Integer read _GetMOVE_SELF;
    {class} property OPEN: Integer read _GetOPEN;
  end;

  [JavaSignature('android/os/FileObserver')]
  JFileObserver = interface(JObject)
    ['{0F296430-B72B-43BB-9210-09EE8D56E40B}']
    procedure onEvent(event: Integer; path: JString); cdecl;
    procedure startWatching; cdecl;
    procedure stopWatching; cdecl;
  end;
  TJFileObserver = class(TJavaGenericImport<JFileObserverClass, JFileObserver>) end;

  JFileObserverExClass = interface(JFileObserverClass)
    ['{9426B8B1-5EBF-4792-BF4B-3888F1650C55}']
    {class} function init(P1: JString): JFileObserverEx; cdecl; overload;
    {class} function init(P1: JString; P2: JIFileObserverHandler): JFileObserverEx; cdecl; overload;
  end;

  [JavaSignature('ru/zapped/test/fileobserverex/FileObserverEx')]
  JFileObserverEx = interface(JFileObserver)
    ['{C46C2A38-0B0F-4C73-8C8E-17022C02AF1E}']
    procedure onEvent(P1: Integer; P2: JString); cdecl;
    procedure startWatching; cdecl;
    procedure stopWatching; cdecl;
  end;
  TJFileObserverEx = class(TJavaGenericImport<JFileObserverExClass, JFileObserverEx>) end;

  JIFileObserverHandlerClass = interface(IJavaClass)
    ['{FD098D3A-A242-4511-B9B5-F44110A86609}']
  end;

  [JavaSignature('ru/zapped/test/fileobserverex/IFileObserverHandler')]
  JIFileObserverHandler = interface(IJavaInstance)
    ['{F72BABCA-F976-441C-8FAF-F32BEFD9193E}']
    procedure onEvent(P1: Integer; P2: JString); cdecl;
  end;
  TJIFileObserverHandler = class(TJavaGenericImport<JIFileObserverHandlerClass, JIFileObserverHandler>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('FileObserverEx.JFileObserver', TypeInfo(FileObserverEx.JFileObserver));
  TRegTypes.RegisterType('FileObserverEx.JFileObserverEx', TypeInfo(FileObserverEx.JFileObserverEx));
  TRegTypes.RegisterType('FileObserverEx.JIFileObserverHandler', TypeInfo(FileObserverEx.JIFileObserverHandler));
end;

initialization
  RegisterTypes;
end.


