${SegmentFile}

${Segment.OnInit}
	${registry::Read} "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" "CurrentBuild" $0 $1

	${If} $0 < 9600 ;Windows 7/8.0
		StrCpy $AppName "FreeCAD"
		${If} ${IsWin2000}
			StrCpy $1 2000
		${ElseIf} ${IsWinXP}
			StrCpy $1 XP
		${ElseIf} ${IsWin2003}
			StrCpy $1 2003
		${ElseIf} ${IsWinVista}
			StrCpy $1 Vista
		${ElseIf} ${IsWin2008}
			StrCpy $1 2008
		${ElseIf} ${IsWin7}
			StrCpy $1 7
		${ElseIf} ${IsWin2008R2}
			StrCpy $1 "2008 R2"
		${ElseIf} ${IsWin8}
			StrCpy $1 8
		${ElseIf} ${IsWin2012}
			StrCpy $1 2012
		${Else}
			StrCpy $1 "Pre-Win8.1"
		${EndIf}	
		StrCpy $0 "8.1"
		MessageBox MB_OK "$(LauncherIncompatibleMinOS)"
		Abort
	${EndIf}
!macroend

${SegmentInit}
	;Ensure we have a proper Documents path
	ExpandEnvStrings $1 "%PortableApps.comDocuments%"
	${If} $1 == ""
	${OrIfNot} ${FileExists} "$1\*.*"
		${GetParent} $EXEDIR $3
		${GetParent} $3 $1
		${If} $1 == "" ;Be sure we didn't just GetParent on Root
			StrCpy $1 $3
		${EndIf}
		${If} ${FileExists} "$1\Documents\*.*"
			StrCpy $2 "$1\Documents"
		${Else}
			${GetRoot} $EXEDIR $1
			${If} ${FileExists} "$1\Documents\*.*"
				StrCpy $2 "$1\Documents"
			${Else}
				StrCpy $2 "$1"
			${EndIf}
		${EndIf}
		System::Call 'Kernel32::SetEnvironmentVariable(t, t) i("PortableApps.comDocuments", "$2").r0'
		${WordReplace} $2 "\" "/" "+" $3
		System::Call 'Kernel32::SetEnvironmentVariable(t, t) i("PortableApps.comDocuments:ForwardSlash", "$3").r0'
	${EndIf}
!macroend
