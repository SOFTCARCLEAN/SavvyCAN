[Setup]
AppName=SavvyCAN
AppVersion={#MyAppVersion}
DefaultDirName={autopf}\SavvyCAN
DefaultGroupName=SavvyCAN
OutputBaseFilename=SavvyCAN_Setup
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Files]
Source: "bin\SavvyCAN.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "bin\*.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "bin\platforms\*"; DestDir: "{app}\platforms"; Flags: recursesubdirs ignoreversion
Source: "bin\plugins\*"; DestDir: "{app}\plugins"; Flags: recursesubdirs ignoreversion
Source: "bin\translations\*"; DestDir: "{app}\translations"; Flags: recursesubdirs ignoreversion
Source: "bin\styles\*"; DestDir: "{app}\styles"; Flags: recursesubdirs ignoreversion
Source: "bin\virtualkeyboard\*"; DestDir: "{app}\virtualkeyboard"; Flags: recursesubdirs ignoreversion

[Icons]
Name: "{group}\SavvyCAN"; Filename: "{app}\SavvyCAN.exe"
Name: "{group}\Uninstall SavvyCAN"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\SavvyCAN.exe"; Description: "Lancer SavvyCAN"; Flags: nowait postinstall

[UninstallDelete]
Type: filesandordirs; Name: "{app}"