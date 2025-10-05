[Setup]
AppName=WeiqiHub
AppVersion=0.1.9
AppPublisher=WalrusWQ
AppPublisherURL=https://walruswq.com
WizardStyle=modern
DefaultDirName={autopf}\WeiqiHub
DefaultGroupName=WeiqiHub
UninstallDisplayIcon={app}\WeiqiHub.exe
Compression=lzma2
SolidCompression=yes

[Code]
function GetVCRedistDir(Param: string): string;
var
  Version: string;
begin
  Result := ExpandConstant('{param:VCRedistDir|' + GetEnv('VCToolsRedistDir') + '}');
  if Result = '' then
    Result := 'C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Redist\MSVC\14.44.35208';
end;

[Files]
Source: "x64/runner/Release/wqhub.exe"; DestDir: "{app}"; DestName: "WeiqiHub.exe"
Source: "x64/runner/Release/*.dll"; DestDir: "{app}"
Source: "x64/runner/Release/data/*"; DestDir: "{app}/data"; Flags: recursesubdirs
Source: "{#VCRedistPath}\msvcp140.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#VCRedistPath}\vcruntime140.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#VCRedistPath}\vcruntime140_1.dll"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\WeiqiHub"; Filename: "{app}\WeiqiHub.exe"
