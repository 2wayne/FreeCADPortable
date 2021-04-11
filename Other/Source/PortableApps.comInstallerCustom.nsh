!macro CustomCodePostInstall
	${If} ${FileExists} "$INSTDIR\App\FreeCAD64.7z"
		nsExec::Exec `"$INSTDIR\7ztemp\7z.exe" x "$INSTDIR\App\FreeCAD64.7z" -o"$INSTDIR\App\FreeCAD64" -aoa`
		Delete "$INSTDIR\App\FreeCAD64.7z"
	${EndIf}
	${If} ${FileExists} "$INSTDIR\App\FreeCAD.7z"
		nsExec::Exec `"$INSTDIR\7ztemp\7z.exe" x "$INSTDIR\App\FreeCAD.7z" -o"$INSTDIR\App\FreeCAD" -aoa`
	${EndIf}
	Delete "$INSTDIR\App\FreeCAD.7z"
!macroend
