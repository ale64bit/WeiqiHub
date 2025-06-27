[Setup]
AppName=WeiqiHub
AppVersion=0.1.3
AppPublisher=WalrusWQ
AppPublisherURL=https://walruswq.com
WizardStyle=modern
DefaultDirName={autopf}\WeiqiHub
DefaultGroupName=WeiqiHub
UninstallDisplayIcon={app}\WeiqiHub.exe
Compression=lzma2
SolidCompression=yes

[Files]
Source: "x64/runner/Release/wqhub.exe"; DestDir: "{app}"; DestName: "WeiqiHub.exe"
Source: "x64/runner/Release/*.dll"; DestDir: "{app}"
Source: "x64/runner/Release/data/*"; DestDir: "{app}/data"; Flags: recursesubdirs
Source: "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Redist\MSVC\14.44.35208\x64\Microsoft.VC143.CRT\msvcp140.dll"; DestDir: "{app}"
Source: "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Redist\MSVC\14.44.35208\x64\Microsoft.VC143.CRT\vcruntime140.dll"; DestDir: "{app}"
Source: "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Redist\MSVC\14.44.35208\x64\Microsoft.VC143.CRT\vcruntime140_1.dll"; DestDir: "{app}"

[Icons]
Name: "{group}\WeiqiHub"; Filename: "{app}\WeiqiHub.exe"
