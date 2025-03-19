#define SourcePath ".."
#define MyAppName "SavvyCAN"
#define MyAppPublisher "Softcar SA"
#define MyAppExeName "SavvyCAN.exe"
#define MyAppAssocName MyAppName + " File"
#define MyAppAssocExt ".exe"
#define MyAppAssocKey StringChange(MyAppAssocName, " ", "") + MyAppAssocExt


[Setup]
AppId={{3B2BD357-55C7-4B11-AEEE-D8C61D8B87BC}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
UninstallDisplayIcon={app}\{#MyAppExeName}
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
ChangesAssociations=yes
DisableProgramGroupPage=yes
OutputBaseFilename=SavvyCAN_Setup
SolidCompression=yes
WizardStyle=modern

[Files]
Source: "{#SourcePath}\bin\SavvyCAN.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourcePath}\bin\*.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourcePath}\bin\platforms\*"; DestDir: "{app}\platforms"; Flags: ignoreversion
Source: "{#SourcePath}\bin\plugins\*"; DestDir: "{app}\plugins"; Flags: ignoreversion
Source: "{#SourcePath}\bin\translations\*"; DestDir: "{app}\translations"; Flags: ignoreversion
Source: "{#SourcePath}\bin\styles\*"; DestDir: "{app}\styles"; Flags: ignoreversion
Source: "{#SourcePath}\bin\virtualkeyboard\*"; DestDir: "{app}\virtualkeyboard"; Flags: recursesubdirs ignoreversion

[Icons]
Name: "{group}\SavvyCAN"; Filename: "{app}\SavvyCAN.exe"
Name: "{group}\Uninstall SavvyCAN"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\SavvyCAN.exe"; Description: "Lancer SavvyCAN"; Flags: nowait postinstall

[UninstallDelete]
Type: filesandordirs; Name: "{app}"