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
OutputBaseFilename=SavvyCAN_{#MyAppVersion}_Setup
SolidCompression=yes
WizardStyle=modern

[Files]
Source: "bin\SavvyCAN.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "bin\*.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "bin\platforms\*"; DestDir: "{app}\platforms"; Flags: recursesubdirs ignoreversion
Source: "bin\bearer\*"; DestDir: "{app}\bearer"; Flags: recursesubdirs ignoreversion
Source: "bin\canbus\*"; DestDir: "{app}\canbus"; Flags: recursesubdirs ignoreversion
Source: "bin\iconengines\*"; DestDir: "{app}\iconengines"; Flags: recursesubdirs ignoreversion
Source: "bin\imageformats\*"; DestDir: "{app}\imageformats"; Flags: recursesubdirs ignoreversion
Source: "bin\printsupport\*"; DestDir: "{app}\printsupport"; Flags: recursesubdirs ignoreversion
Source: "bin\translations\*"; DestDir: "{app}\translations"; Flags: recursesubdirs ignoreversion
Source: "bin\styles\*"; DestDir: "{app}\styles"; Flags: recursesubdirs ignoreversion

[Icons]
Name: "{group}\SavvyCAN"; Filename: "{app}\SavvyCAN.exe"
Name: "{group}\Uninstall SavvyCAN"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\SavvyCAN.exe"; Description: "Lancer SavvyCAN"; Flags: nowait postinstall

[UninstallDelete]
Type: filesandordirs; Name: "{app}"


