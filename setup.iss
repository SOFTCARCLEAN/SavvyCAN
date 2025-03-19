[Setup]
AppName=SavvyCAN
AppVersion={#MyAppVersion}
DefaultDirName={autopf}\SavvyCAN
DefaultGroupName=SavvyCAN
OutputBaseFilename=SavvyCAN_Setup
Compression=lzma
SolidCompression=yes
WizardStyle=modern
LicenseFile=LICENSE.txt

[Files]
Source: "SavvyCAN.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "*.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "plugins\*"; DestDir: "{app}\plugins"; Flags: recursesubdirs ignoreversion
Source: "translations\*"; DestDir: "{app}\translations"; Flags: recursesubdirs ignoreversion

[Icons]
Name: "{group}\SavvyCAN"; Filename: "{app}\SavvyCAN.exe"
Name: "{group}\Uninstall SavvyCAN"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\SavvyCAN.exe"; Description: "Lancer SavvyCAN"; Flags: nowait postinstall

[UninstallDelete]
Type: filesandordirs; Name: "{app}"