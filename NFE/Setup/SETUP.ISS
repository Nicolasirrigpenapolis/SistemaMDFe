[Setup]
AppName=Emissor de MDF-e (Layout 3.00)
AppVerName=Emissor de MDF-e (Layout 3.00) 1.0.763
AppVersion=1.0.763
AppCopyright=(C)2024 Ygor Eduardo Dellalio
DefaultDirName=Emissor de MDFE
DefaultGroupName=MDFE
OutputDir=.
OutputBaseFilename=MDFE_INSTALAR
WindowVisible=no
WindowShowCaption=no
WindowStartMaximized=no
VersionInfoVersion=1.0.763
VersionInfoCompany=Ygor Eduardo Dellalio
VersionInfoTextVersion=1.0.763
VersionInfoCopyright=(C)2024 Ygor Eduardo Dellalio
VersionInfoDescription=Emissor de MDF-e (Layout 3.00)
PrivilegesRequired=admin

[Languages]
Name:pb; MessagesFile: compiler:languages\BrazilianPortuguese.isl

[Files]

;Diretório da aplicação
Source: ..\NFE.EXE;      DestDir: {app}; Flags: ignoreversion restartreplace
Source: ..\NFE.XML;      DestDir: {app}; Flags: ignoreversion restartreplace
Source: ..\Help\NFE.CHM; DestDir: {app}; Flags: ignoreversion restartreplace
Source: ..\NFE.RES;      DestDir: {app}; Flags: ignoreversion restartreplace
Source: ..\ADAPTA.EXE;       DestDir: {app}; Flags: ignoreversion restartreplace
Source: ..\DADOSNFE-SQL.SQL; DestDir: {app}; Flags: ignoreversion restartreplace

;VB runtime
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\VBRunTime\STDOLE2.TLB;  DestDir: "{sys}"; OnlyBelowVersion: 0,6; Flags: uninsneveruninstall sharedfile regtypelib
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\VBRunTime\MSVBVM60.DLL; DestDir: "{sys}"; OnlyBelowVersion: 0,6; Flags: uninsneveruninstall sharedfile regserver
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\VBRunTime\OLEAUT32.DLL; DestDir: "{sys}"; OnlyBelowVersion: 0,6; Flags: uninsneveruninstall sharedfile regserver
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\VBRunTime\OLEPRO32.DLL; DestDir: "{sys}"; OnlyBelowVersion: 0,6; Flags: uninsneveruninstall sharedfile regserver
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\VBRunTime\ASYCFILT.DLL; DestDir: "{sys}"; OnlyBelowVersion: 0,6; Flags: uninsneveruninstall sharedfile
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\VBRunTime\COMCAT.DLL;   DestDir: "{sys}"; OnlyBelowVersion: 0,6; Flags: uninsneveruninstall sharedfile regserver

;ActiveX comuns/Componentes auxiliares
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\Common\MSCOMCTL.OCX;  DestDir: {sys}; Flags: sharedfile regserver
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\Common\MSSTDFMT.DLL;  DestDir: {sys}; Flags: sharedfile regserver
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\Common\TABCTL32.OCX;  DestDir: {sys}; Flags: sharedfile regserver
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\Common\EZTW32.DLL;   DestDir: {sys}; Flags: restartreplace uninsneveruninstall sharedfile

;Winsock 2
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\Common\MSWINSCK.OCX; DestDir: {sys}; Flags: uninsneveruninstall onlyifdoesntexist sharedfile regserver
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\Common\MSMAPI32.OCX;   DestDir: {sys}; Flags: uninsneveruninstall sharedfile regserver

;Controles para gráficos
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\Graph\GRAPH32.OCX;  DestDir: {sys}; Flags: sharedfile regserver
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\Graph\GSWDLL32.DLL; DestDir: {sys}; Flags: sharedfile
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\Graph\GSWAG32.DLL;  DestDir: {sys}; Flags: sharedfile
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\Graph\GSW32.EXE;    DestDir: {sys}; Flags: sharedfile

;MDAC Components
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\MDAC\MDAC_TYP_2_7_SP1.EXE;  DestDir: {tmp}; OnlyBelowVersion: 0,6; Flags: deleteafterinstall
Source: C:\Program Files (x86)\SSI Tecnologia\GAS-2007\Redist\MDAC\MDAC_TYP_2_8_SP1.EXE;  DestDir: {tmp}; OnlyBelowVersion: 0,6; Flags: deleteafterinstall

[Icons]
Name: {group}\Emissor de MDF-e (Layout 3.00); Filename: {app}\NFE.EXE;WorkingDir: {app}; IconFilename: {app}\NFE.EXE; IconIndex: 0

[Run]
Filename: {tmp}\MDAC_TYP_2_7_SP1.EXE; Parameters: "/Q:A /C:""dasetup /Q /N"""; WorkingDir: {tmp}; Flags: skipifdoesntexist; MinVersion: 4.0,4.0; OnlyBelowVersion: 0,5.0
Filename: {tmp}\MDAC_TYP_2_8_SP1.EXE; Parameters: "/Q:A /C:""dasetup /Q /N"""; WorkingDir: {tmp}; Flags: skipifdoesntexist; MinVersion: 4.0,4.0; OnlyBelowVersion: 0,5.0
Filename: {app}\NFE.EXE;WorkingDir: {app}; Flags: postinstall nowait

[Tasks]

[Code]

Function CheckWindowsVersion(AllowedVersions: String): Boolean;
Var
   Version: TWindowsVersion;
   WinVersion: String;
   Minor: String;
Begin
 GetWindowsVersionEx(Version);

 If Not Version.NTPlatform Then
  Begin
   Minor := IntToStr(Version.Minor);
   SetLength(Minor, 1);
   case StrToInt(Minor) of 
    0:
     WinVersion := '95'; 
    1:
     WinVersion := '98'; 
    9:
     WinVersion := 'Me';
   End;
  End
 Else If Version.Major = 4 Then
  Begin
   WinVersion := 'NT';
  End
 Else If Version.Major = 5 Then
  Begin
   case Version.Minor of
    0:
     WinVersion := '2000';
    1:
     WinVersion := 'XP';
    2:
     WinVersion := '2003';
   End;
  End
 Else If Version.Major = 6 Then
  Begin
   WinVersion := 'Vista';
  End;

 Result := False;

 If WinVersion <> '' Then
  Begin
   If Pos(WinVersion, AllowedVersions) > 0 Then
    Result := True;
  End;

End;

Function CheckIEVersion(AllowedVersion: Integer): Boolean;
Var
   IEVersion: String;
Begin
 Result := False;
 If RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Internet Explorer', 'Version', IEVersion) Then
  Begin
   SetLength(IEVersion, 1);
   If StrToInt(IEVersion) >= AllowedVersion Then
    Result := True;
  End;
End;

Function InitializeSetup():Boolean;
Var
   ErrorMessage: String;
Begin
 Result := True;

 // Check allowed windows versions
 Result := CheckWindowsVersion('Win95,Win98,WinMe,WinNT,Win2000,WinXP,Win2003,WinVista');
 ErrorMessage := 'Instalador não suportado para essa versão do Windows';

 // Check internet explorer version, mininum version required is 6.0 for Windows NT
 If Result Then
  Begin
   If CheckWindowsVersion('WinNT') Then
   Begin
    Result := CheckIEVersion(6);
    ErrorMessage := 'Para essa instalação é exigida a versão do Internet Explorer 6.0 ou superior instalada. A Instalação não pode continuar.';
   End;
  End;

 // Check internet explorer version, mininum version required is 5.0
 If Result Then
  Begin
   Result := CheckIEVersion(5);
   ErrorMessage := 'Para essa instalação é exigida a versão do Internet Explorer 5.0 ou superior instalada. A Instalação não pode continuar.';
  End;

 If Not Result Then
  MsgBox(ErrorMessage, mbError, MB_OK);

End;

