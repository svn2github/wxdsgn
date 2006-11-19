rem copy the project files to their correct locations

rem CALL common_vars.bat

copy Project1.dev %DEVPAKDIR%\samples\samples\animate\anitest.dev
gsar -sProjectName -ranitest -o %DEVPAKDIR_GSAR%\samples\samples\animate\anitest.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\animate\anitest.dev
gsar -sSourceFile1 -ranitest.cpp -o %DEVPAKDIR_GSAR%\samples\samples\animate\anitest.dev

copy Project3.dev %DEVPAKDIR%\samples\samples\artprov\artprov.dev
gsar -sProjectName -rartprov -o %DEVPAKDIR_GSAR%\samples\samples\artprov\artprov.dev
gsar -sSourceFile1 -rarttest.cpp -o %DEVPAKDIR_GSAR%\samples\samples\artprov\artprov.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\artprov\artprov.dev
gsar -sSourceFile2 -rartbrows.cpp -o %DEVPAKDIR_GSAR%\samples\samples\artprov\artprov.dev
gsar -sSourceFile3 -rarttest.rc -o %DEVPAKDIR_GSAR%\samples\samples\artprov\artprov.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\aui\aui.dev
gsar -sProjectName -raui -o %DEVPAKDIR_GSAR%\samples\samples\aui\aui.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\aui\aui.dev
gsar -sSourceFile1 -rauidemo.cpp -o %DEVPAKDIR_GSAR%\samples\samples\aui\aui.dev

copy Project4.dev %DEVPAKDIR%\samples\samples\bombs\bombs.dev
gsar -sProjectName -rbombs -o %DEVPAKDIR_GSAR%\samples\samples\bombs\bombs.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\bombs\bombs.dev
gsar -sSourceFile1 -rbombs.cpp -o %DEVPAKDIR_GSAR%\samples\samples\bombs\bombs.dev
gsar -sSourceFile2 -rbombs1.cpp -o %DEVPAKDIR_GSAR%\samples\samples\bombs\bombs.dev
gsar -sSourceFile3 -rgame.cpp -o %DEVPAKDIR_GSAR%\samples\samples\bombs\bombs.dev
gsar -sSourceFile4 -rbombs.rc -o %DEVPAKDIR_GSAR%\samples\samples\bombs\bombs.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\calendar\calendar.dev
gsar -sProjectName -rcalendar -o %DEVPAKDIR_GSAR%\samples\samples\calendar\calendar.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\calendar\calendar.dev
gsar -sSourceFile1 -rcalendar.cpp -o %DEVPAKDIR_GSAR%\samples\samples\calendar\calendar.dev
gsar -sSourceFile2 -rcalendar.rc -o %DEVPAKDIR_GSAR%\samples\samples\calendar\calendar.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\caret\caret.dev
gsar -sProjectName -rcaret -o %DEVPAKDIR_GSAR%\samples\samples\caret\caret.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\caret\caret.dev
gsar -sSourceFile1 -rcaret.cpp -o %DEVPAKDIR_GSAR%\samples\samples\caret\caret.dev
gsar -sSourceFile2 -rcaret.rc -o %DEVPAKDIR_GSAR%\samples\samples\caret\caret.dev

copy Project2.dev %DEVPAKDIR%\extras\samples\chartart\chartart.dev
gsar -sProjectName -rchartart -o %DEVPAKDIR_GSAR%\extras\samples\chartart\chartart.dev
gsar -s=-mwindows -r=-lwxmsw27_chartart_@@_-mwindows -o %DEVPAKDIR_GSAR%\extras\samples\chartart\chartart.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\extras\samples\chartart\chartart.dev
gsar -sSourceFile1 -rwxchart.cpp -o %DEVPAKDIR_GSAR%\extras\samples\chartart\chartart.dev
gsar -sSourceFile2:x0d:x0aCompileCpp=1 -rSourceFile2 -o %DEVPAKDIR_GSAR%\extras\samples\chartart\chartart.dev
gsar -sSourceFile2 -r..\..\..\include\common\3rdparty\wxchart.rc -o %DEVPAKDIR_GSAR%\extras\samples\chartart\chartart.dev
gsar -scommon\3rdparty\wxchart.rc:x0d:x0aFolder= -rcommon\3rdparty\wxchart.rc:x0d:x0aFolder=Resources -o %DEVPAKDIR_GSAR%\extras\samples\chartart\chartart.dev
gsar -s#pragma:x20interface  -r//#pragma:x20interface  -o %DEVPAKDIR_GSAR%\extras\samples\chartart\wxchart.cpp
gsar -s#pragma:x20implementation -r//#pragma:x20implementation -o %DEVPAKDIR_GSAR%\extras\samples\chartart\wxchart.cpp

copy Project2.dev %DEVPAKDIR%\samples\samples\checklst\checklst.dev
gsar -sProjectName -rchecklst -o %DEVPAKDIR_GSAR%\samples\samples\checklst\checklst.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\checklst\checklst.dev
gsar -sSourceFile1 -rchecklst.cpp -o %DEVPAKDIR_GSAR%\samples\samples\checklst\checklst.dev
gsar -sSourceFile2 -rchecklst.rc -o %DEVPAKDIR_GSAR%\samples\samples\checklst\checklst.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\combo\combo.dev
gsar -sProjectName -rcombo -o %DEVPAKDIR_GSAR%\samples\samples\combo\combo.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\combo\combo.dev
gsar -sSourceFile1 -rcombo.cpp -o %DEVPAKDIR_GSAR%\samples\samples\combo\combo.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\config\conftest.dev
gsar -sProjectName -rconftest -o %DEVPAKDIR_GSAR%\samples\samples\config\conftest.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\config\conftest.dev
gsar -sSourceFile1 -rconftest.cpp -o %DEVPAKDIR_GSAR%\samples\samples\config\conftest.dev
gsar -sSourceFile2 -rconftest.rc -o %DEVPAKDIR_GSAR%\samples\samples\config\conftest.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\console\console.dev
gsar -sProjectName -rconsole -o %DEVPAKDIR_GSAR%\samples\samples\console\console.dev
gsar -s=-mwindows_@@_ -r= -o %DEVPAKDIR_GSAR%\samples\samples\console\console.dev
gsar -sWall_@@_ -rWall_@@_-D_CONSOLE _@@_-DwxUSE_GUI=0 _@@_ -o %DEVPAKDIR_GSAR%\samples\samples\console\console.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\console\console.dev
gsar -sSourceFile1 -rconsole.cpp -o %DEVPAKDIR_GSAR%\samples\samples\console\console.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\controls\controls.dev
gsar -sProjectName -rcontrols -o %DEVPAKDIR_GSAR%\samples\samples\controls\controls.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\controls\controls.dev
gsar -sSourceFile1 -rcontrols.cpp -o %DEVPAKDIR_GSAR%\samples\samples\controls\controls.dev
gsar -sSourceFile2 -rcontrols.rc -o %DEVPAKDIR_GSAR%\samples\samples\controls\controls.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\dataview\dataview.dev
gsar -sProjectName -rdataview -o %DEVPAKDIR_GSAR%\samples\samples\dataview\dataview.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\dataview\dataview.dev
gsar -sSourceFile1 -rdataview.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dataview\dataview.dev

copy Project3.dev %DEVPAKDIR%\samples\samples\db\dbtest.dev
gsar -sProjectName -rdbtest -o %DEVPAKDIR_GSAR%\samples\samples\db\dbtest.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\db\dbtest.dev
gsar -sSourceFile1 -rdbtest.cpp -o %DEVPAKDIR_GSAR%\samples\samples\db\dbtest.dev
gsar -sSourceFile2 -rlistdb.cpp -o %DEVPAKDIR_GSAR%\samples\samples\db\dbtest.dev
gsar -sSourceFile3 -rdbtest.rc -o %DEVPAKDIR_GSAR%\samples\samples\db\dbtest.dev

copy Project10.dev %DEVPAKDIR%\samples\samples\dbbrowse\dbbrowse.dev
gsar -sProjectName -rdbbrowse -o %DEVPAKDIR_GSAR%\samples\samples\dbbrowse\dbbrowse.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\dbbrowse\dbbrowse.dev
gsar -sSourceFile10 -rdbbrowse.rc -o %DEVPAKDIR_GSAR%\samples\samples\dbbrowse\dbbrowse.dev
gsar -sSourceFile1 -rbrowsedb.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dbbrowse\dbbrowse.dev
gsar -sSourceFile2 -rdbbrowse.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dbbrowse\dbbrowse.dev
gsar -sSourceFile3 -rdbgrid.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dbbrowse\dbbrowse.dev
gsar -sSourceFile4 -rdbtree.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dbbrowse\dbbrowse.dev
gsar -sSourceFile5 -rdlguser.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dbbrowse\dbbrowse.dev
gsar -sSourceFile6 -rdoc.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dbbrowse\dbbrowse.dev
gsar -sSourceFile7 -rdummy.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dbbrowse\dbbrowse.dev
gsar -sSourceFile8 -rpgmctrl.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dbbrowse\dbbrowse.dev
gsar -sSourceFile9 -rtabpgwin.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dbbrowse\dbbrowse.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\debugrpt\debugrpt.dev
gsar -sProjectName -rdebugrpt -o %DEVPAKDIR_GSAR%\samples\samples\debugrpt\debugrpt.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\debugrpt\debugrpt.dev
gsar -sSourceFile1 -rdebugrpt.cpp -o %DEVPAKDIR_GSAR%\samples\samples\debugrpt\debugrpt.dev

copy Project2.dev %DEVPAKDIR%\contrib\samples\deprecated\proplist\proplist.dev
gsar -sProjectName -rproplist -o %DEVPAKDIR_GSAR%\contrib\samples\deprecated\proplist\proplist.dev
gsar -s=-mwindows -r=-lwxmsw27_deprecated_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\deprecated\proplist\proplist.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\deprecated\proplist\proplist.dev
gsar -sSourceFile1 -rproplist.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\deprecated\proplist\proplist.dev
gsar -sSourceFile2 -rproplist.rc -o %DEVPAKDIR_GSAR%\contrib\samples\deprecated\proplist\proplist.dev

copy Project2.dev %DEVPAKDIR%\contrib\samples\deprecated\resource\resource.dev
gsar -sProjectName -rresource -o %DEVPAKDIR_GSAR%\contrib\samples\deprecated\resource\resource.dev
gsar -s=-mwindows -r=-lwxmsw27_deprecated_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\deprecated\resource\resource.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\deprecated\resource\resource.dev
gsar -sSourceFile1 -rresource.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\deprecated\resource\resource.dev
gsar -sSourceFile2 -rresource.rc -o %DEVPAKDIR_GSAR%\contrib\samples\deprecated\resource\resource.dev

copy Project2.dev %DEVPAKDIR%\contrib\samples\deprecated\treelay\treelay.dev
gsar -sProjectName -rtreelay -o %DEVPAKDIR_GSAR%\contrib\samples\deprecated\treelay\treelay.dev
gsar -s=-mwindows -r=-lwxmsw27_deprecated_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\deprecated\treelay\treelay.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\deprecated\treelay\treelay.dev
gsar -sSourceFile1 -rtreelay.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\deprecated\treelay\treelay.dev
gsar -sSourceFile2 -rtreelay.rc -o %DEVPAKDIR_GSAR%\contrib\samples\deprecated\treelay\treelay.dev

copy Project6.dev %DEVPAKDIR%\samples\samples\dialogs\dialogs.dev
gsar -sProjectName -rdialogs -o %DEVPAKDIR_GSAR%\samples\samples\dialogs\dialogs.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\dialogs\dialogs.dev
gsar -sSourceFile1 -rdialogs.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dialogs\dialogs.dev
gsar -sSourceFile2 -rdialogs.rc -o %DEVPAKDIR_GSAR%\samples\samples\dialogs\dialogs.dev
gsar -sSourceFile3 -r..\generic\colrdlgg.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dialogs\dialogs.dev
gsar -sSourceFile4 -r..\generic\dirdlgg.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dialogs\dialogs.dev
gsar -sSourceFile5 -r..\generic\filedlgg.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dialogs\dialogs.dev
gsar -sSourceFile6 -r..\generic\fontdlgg.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dialogs\dialogs.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\dialup\dialup.dev
gsar -sProjectName -rdialup -o %DEVPAKDIR_GSAR%\samples\samples\dialup\dialup.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\dialup\dialup.dev
gsar -sSourceFile1 -rnettest.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dialup\dialup.dev
gsar -sSourceFile2 -rnettest.rc -o %DEVPAKDIR_GSAR%\samples\samples\dialup\dialup.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\display\display.dev
gsar -sProjectName -rdisplay -o %DEVPAKDIR_GSAR%\samples\samples\display\display.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\display\display.dev
gsar -sSourceFile1 -rdisplay.cpp -o %DEVPAKDIR_GSAR%\samples\samples\display\display.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\dnd\dnd.dev
gsar -sProjectName -rdnd -o %DEVPAKDIR_GSAR%\samples\samples\dnd\dnd.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\dnd\dnd.dev
gsar -sSourceFile1 -rdnd.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dnd\dnd.dev
gsar -sSourceFile2 -rdnd.rc -o %DEVPAKDIR_GSAR%\samples\samples\dnd\dnd.dev

copy Project4.dev %DEVPAKDIR%\samples\samples\docview\docview.dev
gsar -sProjectName -rdocview -o %DEVPAKDIR_GSAR%\samples\samples\docview\docview.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\docview\docview.dev
gsar -sSourceFile1 -rdocview.cpp -o %DEVPAKDIR_GSAR%\samples\samples\docview\docview.dev
gsar -sSourceFile2 -rdoc.cpp -o %DEVPAKDIR_GSAR%\samples\samples\docview\docview.dev
gsar -sSourceFile3 -rview.cpp -o %DEVPAKDIR_GSAR%\samples\samples\docview\docview.dev
gsar -sSourceFile4 -rdocview.rc -o %DEVPAKDIR_GSAR%\samples\samples\docview\docview.dev

copy Project4.dev %DEVPAKDIR%\samples\samples\docvwmdi\docvwmdi.dev
gsar -sProjectName -rdocvwmdi -o %DEVPAKDIR_GSAR%\samples\samples\docvwmdi\docvwmdi.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\docvwmdi\docvwmdi.dev
gsar -sSourceFile1 -rdocview.cpp -o %DEVPAKDIR_GSAR%\samples\samples\docvwmdi\docvwmdi.dev
gsar -sSourceFile2 -rdoc.cpp -o %DEVPAKDIR_GSAR%\samples\samples\docvwmdi\docvwmdi.dev
gsar -sSourceFile3 -rview.cpp -o %DEVPAKDIR_GSAR%\samples\samples\docvwmdi\docvwmdi.dev
gsar -sSourceFile4 -rdocview.rc -o %DEVPAKDIR_GSAR%\samples\samples\docvwmdi\docvwmdi.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\dragimag\dragimag.dev
gsar -sProjectName -rdragimag -o %DEVPAKDIR_GSAR%\samples\samples\dragimag\dragimag.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\dragimag\dragimag.dev
gsar -sSourceFile1 -rdragimag.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dragimag\dragimag.dev
gsar -sSourceFile2 -rdragimag.rc -o %DEVPAKDIR_GSAR%\samples\samples\dragimag\dragimag.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\drawing\drawing.dev
gsar -sProjectName -rdrawing -o %DEVPAKDIR_GSAR%\samples\samples\drawing\drawing.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\drawing\drawing.dev
gsar -sSourceFile1 -rdrawing.cpp -o %DEVPAKDIR_GSAR%\samples\samples\drawing\drawing.dev
gsar -sSourceFile2 -rdrawing.rc -o %DEVPAKDIR_GSAR%\samples\samples\drawing\drawing.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\dynamic\dynamic.dev
gsar -sProjectName -rdynamic -o %DEVPAKDIR_GSAR%\samples\samples\dynamic\dynamic.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\dynamic\dynamic.dev
gsar -sSourceFile1 -rdynamic.cpp -o %DEVPAKDIR_GSAR%\samples\samples\dynamic\dynamic.dev
gsar -sSourceFile2 -rdynamic.rc -o %DEVPAKDIR_GSAR%\samples\samples\dynamic\dynamic.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\erase\erase.dev
gsar -sProjectName -rerase -o %DEVPAKDIR_GSAR%\samples\samples\erase\erase.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\erase\erase.dev
gsar -sSourceFile1 -rerase.cpp -o %DEVPAKDIR_GSAR%\samples\samples\erase\erase.dev
gsar -sSourceFile2 -rerase.rc -o %DEVPAKDIR_GSAR%\samples\samples\erase\erase.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\event\event.dev
gsar -sProjectName -revent -o %DEVPAKDIR_GSAR%\samples\samples\event\event.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\event\event.dev
gsar -sSourceFile1 -revent.cpp -o %DEVPAKDIR_GSAR%\samples\samples\event\event.dev
gsar -sSourceFile2 -revent.rc -o %DEVPAKDIR_GSAR%\samples\samples\event\event.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\except\except.dev
gsar -sProjectName -rexcept -o %DEVPAKDIR_GSAR%\samples\samples\except\except.dev
gsar -s_@@_-fno-exceptions -r_@@_-fexceptions -o %DEVPAKDIR_GSAR%\samples\samples\except\except.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\except\except.dev
gsar -sSourceFile1 -rexcept.cpp -o %DEVPAKDIR_GSAR%\samples\samples\except\except.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\exec\exec.dev
gsar -sProjectName -rexec -o %DEVPAKDIR_GSAR%\samples\samples\exec\exec.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\exec\exec.dev
gsar -sSourceFile1 -rexec.cpp -o %DEVPAKDIR_GSAR%\samples\samples\exec\exec.dev
gsar -sSourceFile2 -rexec.rc -o %DEVPAKDIR_GSAR%\samples\samples\exec\exec.dev

copy Project2.dev %DEVPAKDIR%\contrib\samples\fl\fl_demo1.dev
gsar -sProjectName -rfl_demo1 -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_demo1.dev
gsar -s=-mwindows -r=-lwxmsw27_fl_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_demo1.dev
gsar -sWall_@@_ -rWall_@@_-DBMP_DIR=\\\"./bitmaps/\\\"_@@_ -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_demo1.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_demo1.dev
gsar -sSourceFile1 -rfl_demo1.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_demo1.dev
gsar -sSourceFile2 -rfl_demo1.rc -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_demo1.dev

copy Project2.dev %DEVPAKDIR%\contrib\samples\fl\fl_demo2.dev
gsar -sProjectName -rfl_demo2 -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_demo2.dev
gsar -s=-mwindows -r=-lwxmsw27_fl_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_demo2.dev
gsar -sWall_@@_ -rWall_@@_-DBMP_DIR=\\\"./bitmaps/\\\"_@@_ -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_demo2.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_demo2.dev
gsar -sSourceFile1 -rfl_demo2.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_demo2.dev
gsar -sSourceFile2 -rfl_demo2.rc -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_demo2.dev
gsar -sICON:x20:x22mondrian -rICON:x20:x22sample -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_demo2.rc
gsar -s/* -r -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_demo2.rc
gsar -s*/ -r -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_demo2.rc

copy Project2.dev %DEVPAKDIR%\contrib\samples\fl\fl_sample1.dev
gsar -sProjectName -rfl_sample1 -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_sample1.dev
gsar -s=-mwindows -r=-lwxmsw27_fl_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_sample1.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\\html\helpview\helpview.dev
gsar -sSourceFile1 -rfl_sample1.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_sample1.dev
gsar -sSourceFile2 -rfl_sample1.rc -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_sample1.dev

copy Project2.dev %DEVPAKDIR%\contrib\samples\fl\fl_sample2.dev
gsar -sProjectName -rfl_sample2 -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_sample2.dev
gsar -s=-mwindows -r=-lwxmsw27_fl_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_sample2.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_sample2.dev
gsar -sSourceFile1 -rfl_sample2.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_sample2.dev
gsar -sSourceFile2 -rfl_sample2.rc -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_sample2.dev

copy Project2.dev %DEVPAKDIR%\contrib\samples\fl\fl_sample3.dev
gsar -sProjectName -rfl_sample3 -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_sample3.dev
gsar -s=-mwindows -r=-lwxmsw27_fl_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_sample3.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_sample3.dev
gsar -sSourceFile1 -rfl_sample3.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_sample3.dev
gsar -sSourceFile2 -rfl_sample3.rc -o %DEVPAKDIR_GSAR%\contrib\samples\fl\fl_sample3.dev

copy Project2.dev %DEVPAKDIR%\contrib\samples\foldbar\extended\extended.dev
gsar -sProjectName -rextended -o %DEVPAKDIR_GSAR%\contrib\samples\foldbar\extended\extended.dev
gsar -s=-mwindows -r=-lwxmsw27_foldbar_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\foldbar\extended\extended.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\foldbar\extended\extended.dev
gsar -sSourceFile1 -rextended.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\foldbar\extended\extended.dev
gsar -sSourceFile2 -rextended.rc -o %DEVPAKDIR_GSAR%\contrib\samples\foldbar\extended\extended.dev

copy Project5.dev %DEVPAKDIR%\contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev
gsar -sProjectName -rfoldpanelbartest -o %DEVPAKDIR_GSAR%\contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev
gsar -s=-mwindows -r=-lwxmsw27_foldbar_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev
gsar -sSourceFile1 -rfoldpanelbartest.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev
gsar -sSourceFile2 -rfoldtestpanel.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev
gsar -sSourceFile3 -rlayouttest.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev
gsar -sSourceFile4 -rtest.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev
gsar -sSourceFile5 -rfoldpanelbartest.rc -o %DEVPAKDIR_GSAR%\contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\font\font.dev
gsar -sProjectName -rfont -o %DEVPAKDIR_GSAR%\samples\samples\font\font.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\font\font.dev
gsar -sSourceFile1 -rfont.cpp -o %DEVPAKDIR_GSAR%\samples\samples\font\font.dev
gsar -sSourceFile2 -rfont.rc -o %DEVPAKDIR_GSAR%\samples\samples\font\font.dev

copy Project9.dev %DEVPAKDIR%\samples\samples\forty\forty.dev
gsar -sProjectName -rforty -o %DEVPAKDIR_GSAR%\samples\samples\forty\forty.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\forty\forty.dev
gsar -sSourceFile1 -rcanvas.cpp -o %DEVPAKDIR_GSAR%\samples\samples\forty\forty.dev
gsar -sSourceFile2 -rforty.cpp -o %DEVPAKDIR_GSAR%\samples\samples\forty\forty.dev
gsar -sSourceFile3 -rcard.cpp -o %DEVPAKDIR_GSAR%\samples\samples\forty\forty.dev
gsar -sSourceFile4 -rgame.cpp -o %DEVPAKDIR_GSAR%\samples\samples\forty\forty.dev
gsar -sSourceFile5 -rpile.cpp -o %DEVPAKDIR_GSAR%\samples\samples\forty\forty.dev
gsar -sSourceFile6 -rplayerdg.cpp -o %DEVPAKDIR_GSAR%\samples\samples\forty\forty.dev
gsar -sSourceFile7 -rscoredg.cpp -o %DEVPAKDIR_GSAR%\samples\samples\forty\forty.dev
gsar -sSourceFile8 -rscorefil.cpp -o %DEVPAKDIR_GSAR%\samples\samples\forty\forty.dev
gsar -sSourceFile9 -rforty.rc -o %DEVPAKDIR_GSAR%\samples\samples\forty\forty.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\fractal\fractal.dev
gsar -sProjectName -rfractal -o %DEVPAKDIR_GSAR%\samples\samples\fractal\fractal.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\fractal\fractal.dev
gsar -sSourceFile1 -rfractal.cpp -o %DEVPAKDIR_GSAR%\samples\samples\fractal\fractal.dev
gsar -sSourceFile2 -rfractal.rc -o %DEVPAKDIR_GSAR%\samples\samples\fractal\fractal.dev

copy Project1.dev %DEVPAKDIR%\contrib\samples\gizmos\dynsash\dynsash.dev
gsar -sProjectName -rdynsash -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\dynsash\dynsash.dev
gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\dynsash\dynsash.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\dynsash\dynsash.dev
gsar -sSourceFile1 -rdynsash.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\dynsash\dynsash.dev

copy Project1.dev %DEVPAKDIR%\contrib\samples\gizmos\dynsash_switch\dynsash_switch.dev
gsar -sProjectName -rdynsash_switch -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\dynsash_switch\dynsash_switch.dev
gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\dynsash_switch\dynsash_switch.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\dynsash_switch\dynsash_switch.dev
gsar -sSourceFile1 -rdynsash_switch.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\dynsash_switch\dynsash_switch.dev

copy Project1.dev %DEVPAKDIR%\contrib\samples\gizmos\editlbox\editlbox.dev
gsar -sProjectName -reditlbox -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\editlbox\editlbox.dev
gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\editlbox\editlbox.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\editlbox\editlbox.dev
gsar -sSourceFile1 -rtest.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\editlbox\editlbox.dev

copy Project1.dev %DEVPAKDIR%\contrib\samples\gizmos\led\led.dev
gsar -sProjectName -rled -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\led\led.dev
gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\led\led.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\led\led.dev
gsar -sSourceFile1 -rled.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\led\led.dev

copy Project1.dev %DEVPAKDIR%\contrib\samples\gizmos\multicell\multicell.dev
gsar -sProjectName -rmulticell -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\multicell\multicell.dev
gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\multicell\multicell.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\multicell\multicell.dev
gsar -sSourceFile1 -rmtest.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\multicell\multicell.dev

copy Project1.dev %DEVPAKDIR%\contrib\samples\gizmos\splittree\splittree.dev
gsar -sProjectName -rsplittree -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\splittree\splittree.dev
gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\splittree\splittree.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\splittree\splittree.dev
gsar -sSourceFile1 -rtree.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\splittree\splittree.dev
gsar -sSourceFile1 -rtree.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\splittree\splittree.dev
gsar -swxICON_SMALL_CLOSED_FOLDER -r../../art/folder.xpm -o %DEVPAKDIR_GSAR%\contrib\samples\gizmos\splittree\splittree.dev
gsar -swxICON_SMALL_FILE -r../../art/fileopen.xpm %DEVPAKDIR%\contrib\samples\gizmos\splittree\splittree.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\grid\grid.dev
gsar -sProjectName -rgrid -o %DEVPAKDIR_GSAR%\samples\samples\grid\grid.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\grid\grid.dev
gsar -sSourceFile1 -rgriddemo.cpp -o %DEVPAKDIR_GSAR%\samples\samples\grid\grid.dev
gsar -sSourceFile2 -rgriddemo.rc -o %DEVPAKDIR_GSAR%\samples\samples\grid\grid.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\help\help.dev
gsar -sProjectName -rhelp -o %DEVPAKDIR_GSAR%\samples\samples\help\help.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\help\help.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\\html\helpview\helpview.dev
gsar -sSourceFile1 -rdemo.cpp -o %DEVPAKDIR_GSAR%\samples\samples\help\help.dev
gsar -sSourceFile2 -rdemo.rc -o %DEVPAKDIR_GSAR%\samples\samples\help\help.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\htlbox\htlbox.dev
gsar -sProjectName -rhtlbox -o %DEVPAKDIR_GSAR%\samples\samples\htlbox\htlbox.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\help\help.dev
gsar -sSourceFile1 -rhtlbox.cpp -o %DEVPAKDIR_GSAR%\samples\samples\htlbox\htlbox.dev
gsar -sSourceFile2 -rhtlbox.rc -o %DEVPAKDIR_GSAR%\samples\samples\htlbox\htlbox.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\html\about\about.dev
gsar -sProjectName -rabout -o %DEVPAKDIR_GSAR%\samples\samples\html\about\about.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\html\about\about.dev
gsar -sSourceFile1 -rabout.cpp -o %DEVPAKDIR_GSAR%\samples\samples\html\about\about.dev
gsar -sSourceFile2 -rabout.rc -o %DEVPAKDIR_GSAR%\samples\samples\html\about\about.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\html\help\help.dev
gsar -sProjectName -rhelp -o %DEVPAKDIR_GSAR%\samples\samples\html\help\help.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\html\help\help.dev
gsar -sSourceFile1 -rhelp.cpp -o %DEVPAKDIR_GSAR%\samples\samples\html\help\help.dev
gsar -sSourceFile2 -rhelp.rc -o %DEVPAKDIR_GSAR%\samples\samples\html\help\help.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\html\helpview\helpview.dev
gsar -sProjectName -rhelpview -o %DEVPAKDIR_GSAR%\samples\samples\html\helpview\helpview.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\html\helpview\helpview.dev
gsar -sSourceFile1 -rhelpview.cpp -o %DEVPAKDIR_GSAR%\samples\samples\html\helpview\helpview.dev
gsar -sSourceFile2 -rhelpview.rc -o %DEVPAKDIR_GSAR%\samples\samples\html\helpview\helpview.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\html\printing\printing.dev
gsar -sProjectName -rprinting -o %DEVPAKDIR_GSAR%\samples\samples\html\printing\printing.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\html\printing\printing.dev
gsar -sSourceFile1 -rprinting.cpp -o %DEVPAKDIR_GSAR%\samples\samples\html\printing\printing.dev
gsar -sSourceFile2 -rprinting.rc -o %DEVPAKDIR_GSAR%\samples\samples\html\printing\printing.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\html\test\test.dev
gsar -sProjectName -rtest -o %DEVPAKDIR_GSAR%\samples\samples\html\test\test.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\html\test\test.dev
gsar -sSourceFile1 -rtest.cpp -o %DEVPAKDIR_GSAR%\samples\samples\html\test\test.dev
gsar -sSourceFile2 -rtest.rc -o %DEVPAKDIR_GSAR%\samples\samples\html\test\test.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\html\virtual\virtual.dev
gsar -sProjectName -rvirtual -o %DEVPAKDIR_GSAR%\samples\samples\html\virtual\virtual.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\html\virtual\virtual.dev
gsar -sSourceFile1 -rvirtual.cpp -o %DEVPAKDIR_GSAR%\samples\samples\html\virtual\virtual.dev
gsar -sSourceFile2 -rvirtual.rc -o %DEVPAKDIR_GSAR%\samples\samples\html\virtual\virtual.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\html\widget\widget.dev
gsar -sProjectName -rwidget -o %DEVPAKDIR_GSAR%\samples\samples\html\widget\widget.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\html\widget\widget.dev
gsar -sSourceFile1 -rwidget.cpp -o %DEVPAKDIR_GSAR%\samples\samples\html\widget\widget.dev
gsar -sSourceFile2 -rwidget.rc -o %DEVPAKDIR_GSAR%\samples\samples\html\widget\widget.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\html\zip\zip.dev
gsar -sProjectName -rzip -o %DEVPAKDIR_GSAR%\samples\samples\html\zip\zip.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\html\zip\zip.dev
gsar -sSourceFile1 -rzip.cpp -o %DEVPAKDIR_GSAR%\samples\samples\html\zip\zip.dev
gsar -sSourceFile2 -rzip.rc -o %DEVPAKDIR_GSAR%\samples\samples\html\zip\zip.dev

copy Project1.dev %DEVPAKDIR%\extras\samples\ifm\ifm.dev
gsar -sProjectName -rifm -o %DEVPAKDIR_GSAR%\extras\samples\ifm\ifm.dev
gsar -s=-mwindows -r=-lwxmsw27_ifm_@@_-mwindows -o %DEVPAKDIR_GSAR%\extras\samples\ifm\ifm.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\extras\samples\ifm\ifm.dev
gsar -sSourceFile1 -rmain.cpp -o %DEVPAKDIR_GSAR%\extras\samples\ifm\ifm.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\image\image.dev
gsar -sProjectName -rimage -o %DEVPAKDIR_GSAR%\samples\samples\image\image.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\image\image.dev
gsar -sSourceFile1 -rimage.cpp -o %DEVPAKDIR_GSAR%\samples\samples\image\image.dev
gsar -sSourceFile2 -rimage.rc -o %DEVPAKDIR_GSAR%\samples\samples\image\image.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\internat\internat.dev
gsar -sProjectName -rinternat -o %DEVPAKDIR_GSAR%\samples\samples\internat\internat.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\internat\internat.dev
gsar -sSourceFile1 -rinternat.cpp -o %DEVPAKDIR_GSAR%\samples\samples\internat\internat.dev
gsar -sSourceFile2 -rinternat.rc -o %DEVPAKDIR_GSAR%\samples\samples\internat\internat.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\ipc\ipcclient.dev
gsar -sProjectName -rclient -o %DEVPAKDIR_GSAR%\samples\samples\ipc\ipcclient.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\ipc\ipcclient.dev
gsar -sSourceFile1 -rclient.cpp -o %DEVPAKDIR_GSAR%\samples\samples\ipc\ipcclient.dev
gsar -sSourceFile2 -rclient.rc -o %DEVPAKDIR_GSAR%\samples\samples\ipc\ipcclient.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\ipc\ipcserver.dev
gsar -sProjectName -rserver -o %DEVPAKDIR_GSAR%\samples\samples\ipc\ipcserver.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\ipc\ipcserver.dev
gsar -sSourceFile1 -rserver.cpp -o %DEVPAKDIR_GSAR%\samples\samples\ipc\ipcserver.dev
gsar -sSourceFile2 -rserver.rc -o %DEVPAKDIR_GSAR%\samples\samples\ipc\ipcserver.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\joytest\joytest.dev
gsar -sProjectName -rjoytest -o %DEVPAKDIR_GSAR%\samples\samples\joytest\joytest.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\joytest\joytest.dev
gsar -sSourceFile1 -rjoytest.cpp -o %DEVPAKDIR_GSAR%\samples\samples\joytest\joytest.dev
gsar -sSourceFile2 -rjoytest.rc -o %DEVPAKDIR_GSAR%\samples\samples\joytest\joytest.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\keyboard\keyboard.dev
gsar -sProjectName -rkeyboard -o %DEVPAKDIR_GSAR%\samples\samples\keyboard\keyboard.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\keyboard\keyboard.dev
gsar -sSourceFile1 -rkeyboard.cpp -o %DEVPAKDIR_GSAR%\samples\samples\keyboard\keyboard.dev
gsar -sSourceFile2 -rkeyboard.rc -o %DEVPAKDIR_GSAR%\samples\samples\keyboard\keyboard.dev

copy Project3.dev %DEVPAKDIR%\samples\samples\layout\layout.dev
gsar -sProjectName -rlayout -o %DEVPAKDIR_GSAR%\samples\samples\layout\layout.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\layout\layout.dev
gsar -sSourceFile1 -rlayout.cpp -o %DEVPAKDIR_GSAR%\samples\samples\layout\layout.dev
gsar -sSourceFile2 -rexpt.cpp -o %DEVPAKDIR_GSAR%\samples\samples\layout\layout.dev
gsar -sSourceFile3 -rlayout.rc -o %DEVPAKDIR_GSAR%\samples\samples\layout\layout.dev

copy Project5.dev %DEVPAKDIR%\samples\samples\life\life.dev
gsar -sProjectName -rlife -o %DEVPAKDIR_GSAR%\samples\samples\life\life.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\life\life.dev
gsar -sSourceFile1 -rgame.cpp -o %DEVPAKDIR_GSAR%\samples\samples\life\life.dev
gsar -sSourceFile2 -rdialogs.cpp -o %DEVPAKDIR_GSAR%\samples\samples\life\life.dev
gsar -sSourceFile3 -rlife.cpp -o %DEVPAKDIR_GSAR%\samples\samples\life\life.dev
gsar -sSourceFile4 -rreader.cpp -o %DEVPAKDIR_GSAR%\samples\samples\life\life.dev
gsar -sSourceFile5 -rlife.rc -o %DEVPAKDIR_GSAR%\samples\samples\life\life.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\listbox\listbox.dev
gsar -sProjectName -rlistbox -o %DEVPAKDIR_GSAR%\samples\samples\listbox\listbox.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\listbox\listbox.dev
gsar -sSourceFile1 -rlboxtest.cpp -o %DEVPAKDIR_GSAR%\samples\samples\listbox\listbox.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\listctrl\listctrl.dev
gsar -sProjectName -rlistctrl -o %DEVPAKDIR_GSAR%\samples\samples\listctrl\listctrl.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\listctrl\listctrl.dev
gsar -sSourceFile1 -rlisttest.cpp -o %DEVPAKDIR_GSAR%\samples\samples\listctrl\listctrl.dev
gsar -sSourceFile2 -rlisttest.rc -o %DEVPAKDIR_GSAR%\samples\samples\listctrl\listctrl.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\mdi\mdi.dev
gsar -sProjectName -rmdi -o %DEVPAKDIR_GSAR%\samples\samples\mdi\mdi.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\mdi\mdi.dev
gsar -sSourceFile1 -rmdi.cpp -o %DEVPAKDIR_GSAR%\samples\samples\mdi\mdi.dev
gsar -sSourceFile2 -rmdi.rc -o %DEVPAKDIR_GSAR%\samples\samples\mdi\mdi.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\mediaplayer\mediaplayer.dev
gsar -sProjectName -rmediaplayer -o %DEVPAKDIR_GSAR%\samples\samples\mediaplayer\mediaplayer.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\mediaplayer\mediaplayer.dev
gsar -sSourceFile1 -rmediaplayer.cpp -o %DEVPAKDIR_GSAR%\samples\samples\mediaplayer\mediaplayer.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\memcheck\memcheck.dev
gsar -sProjectName -rmemcheck -o %DEVPAKDIR_GSAR%\samples\samples\memcheck\memcheck.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\memcheck\memcheck.dev
gsar -sSourceFile1 -rmemcheck.cpp -o %DEVPAKDIR_GSAR%\samples\samples\memcheck\memcheck.dev
gsar -sSourceFile2 -rmemcheck.rc -o %DEVPAKDIR_GSAR%\samples\samples\memcheck\memcheck.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\menu\menu.dev
gsar -sProjectName -rmenu -o %DEVPAKDIR_GSAR%\samples\samples\menu\menu.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\menu\menu.dev
gsar -sSourceFile1 -rmenu.cpp -o %DEVPAKDIR_GSAR%\samples\samples\menu\menu.dev
gsar -sSourceFile2 -rmenu.rc -o %DEVPAKDIR_GSAR%\samples\samples\menu\menu.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\mfc\mfctest.dev
gsar -sProjectName -rmfctest -o %DEVPAKDIR_GSAR%\samples\samples\mfc\mfctest.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\mfc\mfctest.dev
gsar -sSourceFile1 -rmfctest.cpp -o %DEVPAKDIR_GSAR%\samples\samples\mfc\mfctest.dev
gsar -sSourceFile2 -rmfctest.rc -o %DEVPAKDIR_GSAR%\samples\samples\mfc\mfctest.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\minifram\minifram.dev
gsar -sProjectName -rminifram -o %DEVPAKDIR_GSAR%\samples\samples\minifram\minifram.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\minifram\minifram.dev
gsar -sSourceFile1 -rminifram.cpp -o %DEVPAKDIR_GSAR%\samples\samples\minifram\minifram.dev
gsar -sSourceFile2 -rminifram.rc -o %DEVPAKDIR_GSAR%\samples\samples\minifram\minifram.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\minimal\minimal.dev
gsar -sProjectName -rminimal -o %DEVPAKDIR_GSAR%\samples\samples\minimal\minimal.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\minimal\minimal.dev
gsar -sSourceFile1 -rminimal.cpp -o %DEVPAKDIR_GSAR%\samples\samples\minimal\minimal.dev
gsar -sSourceFile2 -rminimal.rc -o %DEVPAKDIR_GSAR%\samples\samples\minimal\minimal.dev

copy Project3.dev %DEVPAKDIR%\contrib\samples\mmedia\mmedia.dev
gsar -sProjectName -rmmedia -o %DEVPAKDIR_GSAR%\contrib\samples\mmedia\mmedia.dev
gsar -s=-mwindows -r=-lwxmsw27_mmedia_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\mmedia\mmedia.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\mmedia\mmedia.dev
gsar -sSourceFile1 -rmmboard.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\mmedia\mmedia.dev
gsar -sSourceFile2 -rmmbman.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\mmedia\mmedia.dev
gsar -sSourceFile3 -rmmboard.rc -o %DEVPAKDIR_GSAR%\contrib\samples\mmedia\mmedia.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\mobile\styles\styles.dev
gsar -sProjectName -rstyles -o %DEVPAKDIR_GSAR%\samples\samples\mobile\styles\styles.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\mobile\styles\styles.dev
gsar -sSourceFile1 -rstyles.cpp -o %DEVPAKDIR_GSAR%\samples\samples\mobile\styles\styles.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\multimon\multimon.dev
gsar -sProjectName -rmultimon -o %DEVPAKDIR_GSAR%\samples\samples\multimon\multimon.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\multimon\multimon.dev
gsar -sSourceFile1 -rmultimon_test.cpp -o %DEVPAKDIR_GSAR%\samples\samples\multimon\multimon.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\mobile\wxedit\wxedit.dev
gsar -sProjectName -rwxedit -o %DEVPAKDIR_GSAR%\samples\samples\mobile\wxedit\wxedit.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\mobile\wxedit\wxedit.dev
gsar -sSourceFile1 -rwxedit.cpp -o %DEVPAKDIR_GSAR%\samples\samples\mobile\wxedit\wxedit.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\nativdlg\nativdlg.dev
gsar -sProjectName -rnativdlg -o %DEVPAKDIR_GSAR%\samples\samples\nativdlg\nativdlg.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\nativdlg\nativdlg.dev
gsar -sSourceFile1 -rnativdlg.cpp -o %DEVPAKDIR_GSAR%\samples\samples\nativdlg\nativdlg.dev
gsar -sSourceFile2 -rnativdlg.rc -o %DEVPAKDIR_GSAR%\samples\samples\nativdlg\nativdlg.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\notebook\notebook.dev
gsar -sProjectName -rnotebook -o %DEVPAKDIR_GSAR%\samples\samples\notebook\notebook.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\notebook\notebook.dev
gsar -sSourceFile1 -rnotebook.cpp -o %DEVPAKDIR_GSAR%\samples\samples\notebook\notebook.dev

copy Project5.dev %DEVPAKDIR%\contrib\samples\ogl\ogledit\ogledit.dev
gsar -sProjectName -rogledit -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\ogledit\ogledit.dev
gsar -s=-mwindows -r=-lwxmsw27_ogl_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\ogledit\ogledit.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\ogledit\ogledit.dev
gsar -sSourceFile1 -rogledit.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\ogledit\ogledit.dev
gsar -sSourceFile2 -rdoc.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\ogledit\ogledit.dev
gsar -sSourceFile3 -rpalette.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\ogledit\ogledit.dev
gsar -sSourceFile4 -rview.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\ogledit\ogledit.dev
gsar -sSourceFile5 -rogledit.rc -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\ogledit\ogledit.dev

copy Project11.dev %DEVPAKDIR%\contrib\samples\ogl\studio\studio.dev
gsar -sProjectName -rstudio -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\studio\studio.dev
gsar -s=-mwindows -r=-lwxmsw27_ogl_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\studio\studio.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\studio\studio.dev
gsar -sSourceFile10 -rview.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\studio\studio.dev
gsar -sSourceFile11 -rstudio.rc -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\studio\studio.dev
gsar -sSourceFile1 -rcspalette.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\studio\studio.dev
gsar -sSourceFile2 -rcsprint.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\studio\studio.dev
gsar -sSourceFile3 -rdialogs.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\studio\studio.dev
gsar -sSourceFile4 -rdoc.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\studio\studio.dev
gsar -sSourceFile5 -rmainfrm.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\studio\studio.dev
gsar -sSourceFile6 -rproject.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\studio\studio.dev
gsar -sSourceFile7 -rshapes.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\studio\studio.dev
gsar -sSourceFile8 -rstudio.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\studio\studio.dev
gsar -sSourceFile9 -rsymbols.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\ogl\studio\studio.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\oleauto\oleauto.dev
gsar -sProjectName -roleauto -o %DEVPAKDIR_GSAR%\samples\samples\oleauto\oleauto.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\oleauto\oleauto.dev
gsar -sSourceFile1 -roleauto.cpp -o %DEVPAKDIR_GSAR%\samples\samples\oleauto\oleauto.dev
gsar -sSourceFile2 -roleauto.rc -o %DEVPAKDIR_GSAR%\samples\samples\oleauto\oleauto.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\opengl\cube\cube.dev
gsar -sProjectName -rcube -o %DEVPAKDIR_GSAR%\samples\samples\opengl\cube\cube.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\opengl\cube\cube.dev
gsar -sSourceFile1 -rcube.cpp -o %DEVPAKDIR_GSAR%\samples\samples\opengl\cube\cube.dev
gsar -sSourceFile2 -rcube.rc -o %DEVPAKDIR_GSAR%\samples\samples\opengl\cube\cube.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\opengl\isosurf\isosurf.dev
gsar -sProjectName -risosurf -o %DEVPAKDIR_GSAR%\samples\samples\opengl\isosurf\isosurf.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\opengl\isosurf\isosurf.dev
gsar -sSourceFile1 -risosurf.cpp -o %DEVPAKDIR_GSAR%\samples\samples\opengl\isosurf\isosurf.dev
gsar -sSourceFile2 -risosurf.rc -o %DEVPAKDIR_GSAR%\samples\samples\opengl\isosurf\isosurf.dev

copy Project4.dev %DEVPAKDIR%\samples\samples\opengl\penguin\penguin.dev
gsar -sProjectName -rpenguin -o %DEVPAKDIR_GSAR%\samples\samples\opengl\penguin\penguin.dev
gsar -s-lopengl32_@@_ -r-lopengl32_@@_-lglu32_@@_ -o %DEVPAKDIR_GSAR%\samples\samples\opengl\penguin\penguin.dev
gsar -sCompiler=-fno-rtti_@@_- -rCompiler=- -o %DEVPAKDIR_GSAR%\samples\samples\opengl\penguin\penguin.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\opengl\penguin\penguin.dev
gsar -sSourceFile1 -rpenguin.cpp -o %DEVPAKDIR_GSAR%\samples\samples\opengl\penguin\penguin.dev
gsar -sSourceFile2:x0d:x0aCompileCpp=1 -rtrackball.c:x0d:x0aCompileCpp=0 -o %DEVPAKDIR_GSAR%\samples\samples\opengl\penguin\penguin.dev
gsar -sSourceFile3 -rdxfrenderer.cpp -o %DEVPAKDIR_GSAR%\samples\samples\opengl\penguin\penguin.dev
gsar -sSourceFile4 -rpenguin.rc -o %DEVPAKDIR_GSAR%\samples\samples\opengl\penguin\penguin.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\ownerdrw\ownerdrw.dev
gsar -sProjectName -rownerdrw -o %DEVPAKDIR_GSAR%\samples\samples\ownerdrw\ownerdrw.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\ownerdrw\ownerdrw.dev
gsar -sSourceFile1 -rownerdrw.cpp -o %DEVPAKDIR_GSAR%\samples\samples\ownerdrw\ownerdrw.dev
gsar -sSourceFile2 -rownerdrw.rc -o %DEVPAKDIR_GSAR%\samples\samples\ownerdrw\ownerdrw.dev

copy Project2.dev %DEVPAKDIR%\contrib\samples\plot\plot.dev
gsar -sProjectName -rplot -o %DEVPAKDIR_GSAR%\contrib\samples\plot\plot.dev
gsar -s=-mwindows -r=-lwxmsw27_plot_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\plot\plot.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\plot\plot.dev
gsar -sSourceFile1 -rplot.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\plot\plot.dev
gsar -sSourceFile2 -rplot.rc -o %DEVPAKDIR_GSAR%\contrib\samples\plot\plot.dev

copy Project2.dev %DEVPAKDIR%\extras\samples\plotctrl\plotctrl.dev
gsar -sProjectName -rplotctrl -o %DEVPAKDIR_GSAR%\extras\samples\plotctrl\plotctrl.dev
gsar -s=-mwindows -r=-lwxmsw27_plotctrl_@@_-lwxmsw27_things_@@_-mwindows -o %DEVPAKDIR_GSAR%\extras\samples\plotctrl\plotctrl.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\extras\samples\plotctrl\plotctrl.dev
gsar -sSourceFile1 -rwxplotctrl.cpp -o %DEVPAKDIR_GSAR%\extras\samples\plotctrl\plotctrl.dev
gsar -sSourceFile2 -rwxplotctrl.rc -o %DEVPAKDIR_GSAR%\extras\samples\plotctrl\plotctrl.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\png\png.dev
gsar -sProjectName -rpng -o %DEVPAKDIR_GSAR%\samples\samples\png\png.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\png\png.dev
gsar -sSourceFile1 -rpngdemo.cpp -o %DEVPAKDIR_GSAR%\samples\samples\png\png.dev
gsar -sSourceFile2 -rpngdemo.rc -o %DEVPAKDIR_GSAR%\samples\samples\png\png.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\poem\poem.dev
gsar -sProjectName -rpoem -o %DEVPAKDIR_GSAR%\samples\samples\poem\poem.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\poem\poem.dev
gsar -sSourceFile1 -rwxpoem.cpp -o %DEVPAKDIR_GSAR%\samples\samples\poem\poem.dev
gsar -sSourceFile2 -rwxpoem.rc -o %DEVPAKDIR_GSAR%\samples\samples\poem\poem.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\popup\popup.dev
gsar -sProjectName -rpopup -o %DEVPAKDIR_GSAR%\samples\samples\popup\popup.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\popup\popup.dev
gsar -sSourceFile1 -rpopup.cpp -o %DEVPAKDIR_GSAR%\samples\samples\popup\popup.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\power\power.dev
gsar -sProjectName -rpower -o %DEVPAKDIR_GSAR%\samples\samples\power\power.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\power\power.dev
gsar -sSourceFile1 -rpower.cpp -o %DEVPAKDIR_GSAR%\samples\samples\power\power.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\printing\printing.dev
gsar -sProjectName -rprinting -o %DEVPAKDIR_GSAR%\samples\samples\printing\printing.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\printing\printing.dev
gsar -sSourceFile1 -rprinting.cpp -o %DEVPAKDIR_GSAR%\samples\samples\printing\printing.dev
gsar -sSourceFile2 -rprinting.rc -o %DEVPAKDIR_GSAR%\samples\samples\printing\printing.dev

copy Project2.dev %DEVPAKDIR%\extras\samples\propgrid\propgrid.dev
gsar -sProjectName -rpropgrid -o %DEVPAKDIR_GSAR%\extras\samples\propgrid\propgrid.dev
gsar -s=-mwindows -r=-lwxmsw27_propgrid_@@_-mwindows -o %DEVPAKDIR_GSAR%\extras\samples\propgrid\propgrid.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\extras\samples\propgrid\propgrid.dev
gsar -sSourceFile1 -rpropgridsample.cpp -o %DEVPAKDIR_GSAR%\extras\samples\propgrid\propgrid.dev
gsar -sSourceFile2 -rsampleprops.cpp -o %DEVPAKDIR_GSAR%\extras\samples\propgrid\propgrid.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\propsize\propsize.dev
gsar -sProjectName -rpropsize -o %DEVPAKDIR_GSAR%\samples\samples\propsize\propsize.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\propsize\propsize.dev
gsar -sSourceFile1 -rpropsize.cpp -o %DEVPAKDIR_GSAR%\samples\samples\propsize\propsize.dev
gsar -sSourceFile2 -rpropsize.rc -o %DEVPAKDIR_GSAR%\samples\samples\propsize\propsize.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\regtest\regtest.dev
gsar -sProjectName -rregtest -o %DEVPAKDIR_GSAR%\samples\samples\regtest\regtest.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\regtest\regtest.dev
gsar -sSourceFile1 -rregtest.cpp -o %DEVPAKDIR_GSAR%\samples\samples\regtest\regtest.dev
gsar -sSourceFile2 -rregtest.rc -o %DEVPAKDIR_GSAR%\samples\samples\regtest\regtest.dev

rem copy Project1.dev %DEVPAKDIR%\samples\samples\render\renddll.dev
rem gsar -sProjectName -rrenddll -o %DEVPAKDIR_GSAR%\samples\samples\render\renddll.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\render\renddll.dev
rem gsar -sSourceFile1 -rrenddll.cpp -o %DEVPAKDIR_GSAR%\samples\samples\render\renddll.dev

rem copy Project1.dev %DEVPAKDIR%\samples\samples\render\render.dev
rem gsar -sProjectName -rrender -o %DEVPAKDIR_GSAR%\samples\samples\render\render.dev
rem gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\render\render.dev
rem gsar -sSourceFile1 -rrender.cpp -o %DEVPAKDIR_GSAR%\samples\samples\render\render.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\richtext\richtext.dev
gsar -sProjectName -rrichtext -o %DEVPAKDIR_GSAR%\samples\samples\richtext\richtext.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\richtext\richtext.dev
gsar -sSourceFile1 -rrichtext.cpp -o %DEVPAKDIR_GSAR%\samples\samples\richtext\richtext.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\rotate\rotate.dev
gsar -sProjectName -rrotate -o %DEVPAKDIR_GSAR%\samples\samples\rotate\rotate.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\rotate\rotate.dev
gsar -sSourceFile1 -rrotate.cpp -o %DEVPAKDIR_GSAR%\samples\samples\rotate\rotate.dev
gsar -sSourceFile2 -rrotate.rc -o %DEVPAKDIR_GSAR%\samples\samples\rotate\rotate.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\sashtest\sashtest.dev
gsar -sProjectName -rsashtest -o %DEVPAKDIR_GSAR%\samples\samples\sashtest\sashtest.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\sashtest\sashtest.dev
gsar -sSourceFile1 -rsashtest.cpp -o %DEVPAKDIR_GSAR%\samples\samples\sashtest\sashtest.dev
gsar -sSourceFile2 -rsashtest.rc -o %DEVPAKDIR_GSAR%\samples\samples\sashtest\sashtest.dev

copy Project4.dev %DEVPAKDIR%\extras\samples\scintilla\scintilla.dev
gsar -sProjectName -rscintilla -o %DEVPAKDIR_GSAR%\extras\samples\scintilla\scintilla.dev
gsar -s=-mwindows -r=-lwxmsw27_scintilla_@@_-mwindows -o %DEVPAKDIR_GSAR%\extras\samples\scintilla\scintilla.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\extras\samples\scintilla\scintilla.dev
gsar -sSourceFile1 -redit.cpp -o %DEVPAKDIR_GSAR%\extras\samples\scintilla\scintilla.dev
gsar -sSourceFile2 -rprefs.cpp -o %DEVPAKDIR_GSAR%\extras\samples\scintilla\scintilla.dev
gsar -sSourceFile3 -rtest.cpp -o %DEVPAKDIR_GSAR%\extras\samples\scintilla\scintilla.dev
gsar -sSourceFile4 -rtest.rc -o %DEVPAKDIR_GSAR%\extras\samples\scintilla\scintilla.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\scroll\scroll.dev
gsar -sProjectName -rscroll -o %DEVPAKDIR_GSAR%\samples\samples\scroll\scroll.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\scroll\scroll.dev
gsar -sSourceFile1 -rscroll.cpp -o %DEVPAKDIR_GSAR%\samples\samples\scroll\scroll.dev
gsar -sSourceFile2 -rscroll.rc -o %DEVPAKDIR_GSAR%\samples\samples\scroll\scroll.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\scrollsub\scrollsub.dev
gsar -sProjectName -rscrollsub -o %DEVPAKDIR_GSAR%\samples\samples\scrollsub\scrollsub.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\scrollsub\scrollsub.dev
gsar -sSourceFile1 -rscrollsub.cpp -o %DEVPAKDIR_GSAR%\samples\samples\scrollsub\scrollsub.dev
gsar -sSourceFile2 -rscrollsub.rc -o %DEVPAKDIR_GSAR%\samples\samples\scrollsub\scrollsub.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\shaped\shaped.dev
gsar -sProjectName -rshaped -o %DEVPAKDIR_GSAR%\samples\samples\shaped\shaped.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\shaped\shaped.dev
gsar -sSourceFile1 -rshaped.cpp -o %DEVPAKDIR_GSAR%\samples\samples\shaped\shaped.dev
gsar -sSourceFile2 -rshaped.rc -o %DEVPAKDIR_GSAR%\samples\samples\shaped\shaped.dev

copy Project2.dev %DEVPAKDIR%\extras\samples\sheet\sheetdemo.dev
gsar -sProjectName -rsheetdemo -o %DEVPAKDIR_GSAR%\extras\samples\sheet\sheetdemo.dev
gsar -s=-mwindows -r=-lwxmsw27_sheet_@@_-mwindows -o %DEVPAKDIR_GSAR%\extras\samples\sheet\sheetdemo.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\extras\samples\sheet\sheetdemo.dev
gsar -sSourceFile1 -rsheetdemo.cpp -o %DEVPAKDIR_GSAR%\extras\samples\sheet\sheetdemo.dev
gsar -sSourceFile2 -rsheetdemo.rc -o %DEVPAKDIR_GSAR%\extras\samples\sheet\sheetdemo.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\sockets\client.dev
gsar -sProjectName -rclient -o %DEVPAKDIR_GSAR%\samples\samples\sockets\client.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\sockets\client.dev
gsar -sSourceFile1 -rclient.cpp -o %DEVPAKDIR_GSAR%\samples\samples\sockets\client.dev
gsar -sSourceFile2 -rclient.rc -o %DEVPAKDIR_GSAR%\samples\samples\sockets\client.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\sockets\server.dev
gsar -sProjectName -rserver -o %DEVPAKDIR_GSAR%\samples\samples\sockets\server.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\\html\helpview\helpview.dev
gsar -sSourceFile1 -rserver.cpp -o %DEVPAKDIR_GSAR%\samples\samples\sockets\server.dev
gsar -sSourceFile2 -rserver.rc -o %DEVPAKDIR_GSAR%\samples\samples\sockets\server.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\sound\sound.dev
gsar -sProjectName -rsound -o %DEVPAKDIR_GSAR%\samples\samples\sound\sound.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\sockets\server.dev
gsar -sSourceFile1 -rsound.cpp -o %DEVPAKDIR_GSAR%\samples\samples\sound\sound.dev
gsar -sSourceFile2 -rsound.rc -o %DEVPAKDIR_GSAR%\samples\samples\sound\sound.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\splash\splash.dev
gsar -sProjectName -rsplash -o %DEVPAKDIR_GSAR%\samples\samples\splash\splash.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\splash\splash.dev
gsar -sSourceFile1 -rsplash.cpp -o %DEVPAKDIR_GSAR%\samples\samples\splash\splash.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\splitter\splitter.dev
gsar -sProjectName -rsplitter -o %DEVPAKDIR_GSAR%\samples\samples\splitter\splitter.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\splitter\splitter.dev
gsar -sSourceFile1 -rsplitter.cpp -o %DEVPAKDIR_GSAR%\samples\samples\splitter\splitter.dev
gsar -sSourceFile2 -rsplitter.rc -o %DEVPAKDIR_GSAR%\samples\samples\splitter\splitter.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\statbar\statbar.dev
gsar -sProjectName -rstatbar -o %DEVPAKDIR_GSAR%\samples\samples\statbar\statbar.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\statbar\statbar.dev
gsar -sSourceFile1 -rstatbar.cpp -o %DEVPAKDIR_GSAR%\samples\samples\statbar\statbar.dev
gsar -sSourceFile2 -rstatbar.rc -o %DEVPAKDIR_GSAR%\samples\samples\statbar\statbar.dev

copy Project4.dev %DEVPAKDIR%\contrib\samples\stc\stc.dev
gsar -sProjectName -rstc -o %DEVPAKDIR_GSAR%\contrib\samples\stc\stc.dev
gsar -s=-mwindows -r=-lwxmsw27_stc_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\stc\stc.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\stc\stc.dev
gsar -sSourceFile1 -redit.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\stc\stc.dev
gsar -sSourceFile2 -rprefs.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\stc\stc.dev
gsar -sSourceFile3 -rstctest.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\stc\stc.dev
gsar -sSourceFile4 -rstctest.rc -o %DEVPAKDIR_GSAR%\contrib\samples\stc\stc.dev

copy Project2.dev %DEVPAKDIR%\contrib\samples\svg\svg.dev
gsar -ssvg -rchartart -o %DEVPAKDIR_GSAR%\contrib\samples\svg\svg.dev
gsar -s=-mwindows -r=-lwxmsw27_svg_@@_-mwindows -o %DEVPAKDIR_GSAR%\contrib\samples\svg\svg.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\contrib\samples\svg\svg.dev
gsar -sSourceFile1 -rsvgtest.cpp -o %DEVPAKDIR_GSAR%\contrib\samples\svg\svg.dev
gsar -sSourceFile2 -rsvgtest.rc -o %DEVPAKDIR_GSAR%\contrib\samples\svg\svg.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\taskbar\taskbar.dev
gsar -sProjectName -rtaskbar -o %DEVPAKDIR_GSAR%\samples\samples\taskbar\taskbar.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\taskbar\taskbar.dev
gsar -sSourceFile1 -rtbtest.cpp -o %DEVPAKDIR_GSAR%\samples\samples\taskbar\taskbar.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\text\text.dev
gsar -sProjectName -rtext -o %DEVPAKDIR_GSAR%\samples\samples\text\text.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\text\text.dev
gsar -sSourceFile1 -rtext.cpp -o %DEVPAKDIR_GSAR%\samples\samples\text\text.dev
gsar -sSourceFile2 -rtext.rc -o %DEVPAKDIR_GSAR%\samples\samples\text\text.dev

copy Project3.dev %DEVPAKDIR%\extras\samples\things\filebrws\filebrws.dev
gsar -sProjectName -rfilebrws -o %DEVPAKDIR_GSAR%\extras\samples\things\filebrws\filebrws.dev
gsar -s=-mwindows -r=-lwxmsw27_things_@@_-mwindows -o %DEVPAKDIR_GSAR%\extras\samples\things\filebrws\filebrws.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\extras\samples\things\filebrws\filebrws.dev
gsar -sSourceFile1 -rwxfilebrowser.cpp -o %DEVPAKDIR_GSAR%\extras\samples\things\filebrws\filebrws.dev
gsar -sSourceFile2 -rwxfilebrowser.rc -o %DEVPAKDIR_GSAR%\extras\samples\things\filebrws\filebrws.dev
gsar -sSourceFile3 -r..\..\generic\filedlgg.cpp -o %DEVPAKDIR_GSAR%\extras\samples\things\filebrws\filebrws.dev

copy Project2.dev %DEVPAKDIR%\extras\samples\things\things\things.dev
gsar -sProjectName -rthings -o %DEVPAKDIR_GSAR%\extras\samples\things\things\things.dev
gsar -s=-mwindows -r=-lwxmsw27_things_@@_-mwindows -o %DEVPAKDIR_GSAR%\extras\samples\things\things\things.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\extras\samples\things\things\things.dev
gsar -sSourceFile1 -rthingsdemo.cpp -o %DEVPAKDIR_GSAR%\extras\samples\things\things\things.dev
gsar -sSourceFile2 -rthingsdemo.rc -o %DEVPAKDIR_GSAR%\extras\samples\things\things\things.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\thread\thread.dev
gsar -sProjectName -rthread -o %DEVPAKDIR_GSAR%\samples\samples\thread\thread.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\thread\thread.dev
gsar -sSourceFile1 -rthread.cpp -o %DEVPAKDIR_GSAR%\samples\samples\thread\thread.dev
gsar -sSourceFile2 -rthread.rc -o %DEVPAKDIR_GSAR%\samples\samples\thread\thread.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\toolbar\toolbar.dev
gsar -sProjectName -rtoolbar -o %DEVPAKDIR_GSAR%\samples\samples\toolbar\toolbar.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\toolbar\toolbar.dev
gsar -sSourceFile1 -rtoolbar.cpp -o %DEVPAKDIR_GSAR%\samples\samples\toolbar\toolbar.dev
gsar -sSourceFile2 -rtoolbar.rc -o %DEVPAKDIR_GSAR%\samples\samples\toolbar\toolbar.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\treectrl\treectrl.dev
gsar -sProjectName -rtreectrl -o %DEVPAKDIR_GSAR%\samples\samples\treectrl\treectrl.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\treectrl\treectrl.dev
gsar -sSourceFile1 -rtreetest.cpp -o %DEVPAKDIR_GSAR%\samples\samples\treectrl\treectrl.dev

copy Project2.dev %DEVPAKDIR%\extras\samples\treelisttest\treelisttest.dev
gsar -sProjectName -rtreelisttest -o %DEVPAKDIR_GSAR%\extras\samples\treelisttest\treelisttest.dev
gsar -s=-mwindows -r=-lwxmsw27_treelistctrl_@@_-mwindows -o %DEVPAKDIR_GSAR%\extras\samples\treelisttest\treelisttest.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\extras\samples\treelisttest\treelisttest.dev
gsar -sSourceFile1 -rtreelisttest.cpp -o %DEVPAKDIR_GSAR%\extras\samples\treelisttest\treelisttest.dev
gsar -sSourceFile2 -rtreelisttest.rc -o %DEVPAKDIR_GSAR%\extras\samples\treelisttest\treelisttest.dev
gsar -s#if:x20defined(__WINDOWS__) -r#if:x20defined(__WINDOWS__):x20&&:x20!defined(__GNUWIN32__) -o %DEVPAKDIR_GSAR%\extras\samples\treelisttest\treelisttest.cpp 

copy Project2.dev %DEVPAKDIR%\extras\samples\treemultictrl\treemultictrl.dev
gsar -sProjectName -rtreemultictrl -o %DEVPAKDIR_GSAR%\extras\samples\treemultictrl\treemultictrl.dev
gsar -s=-mwindows -r=-lwxmsw27_treemultictrl_@@_-mwindows -o %DEVPAKDIR_GSAR%\extras\samples\treemultictrl\treemultictrl.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\extras\samples\treemultictrl\treemultictrl.dev
gsar -sSourceFile1 -rmultictrltest.cpp -o %DEVPAKDIR_GSAR%\extras\samples\treemultictrl\treemultictrl.dev
gsar -sSourceFile2 -rmultictrltest.rc -o %DEVPAKDIR_GSAR%\extras\samples\treemultictrl\treemultictrl.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\typetest\typetest.dev
gsar -sProjectName -rtypetest -o %DEVPAKDIR_GSAR%\samples\samples\typetest\typetest.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\typetest\typetest.dev
gsar -sSourceFile1 -rtypetest.cpp -o %DEVPAKDIR_GSAR%\samples\samples\typetest\typetest.dev
gsar -sSourceFile2 -rtypetest.rc -o %DEVPAKDIR_GSAR%\samples\samples\typetest\typetest.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\validate\validate.dev
gsar -sProjectName -rvalidate -o %DEVPAKDIR_GSAR%\samples\samples\validate\validate.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\validate\validate.dev
gsar -sSourceFile1 -rvalidate.cpp -o %DEVPAKDIR_GSAR%\samples\samples\validate\validate.dev

copy Project1.dev %DEVPAKDIR%\samples\samples\vscroll\vscroll.dev
gsar -sProjectName -rvscroll -o %DEVPAKDIR_GSAR%\samples\samples\vscroll\vscroll.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\vscroll\vscroll.dev
gsar -sSourceFile1 -rvstest.cpp -o %DEVPAKDIR_GSAR%\samples\samples\vscroll\vscroll.dev

copy Widgets.dev %DEVPAKDIR%\samples\samples\widgets\widgets.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\widgets\widgets.dev

copy Project2.dev %DEVPAKDIR%\samples\samples\wizard\wizard.dev
gsar -sProjectName -rwizard -o %DEVPAKDIR_GSAR%\samples\samples\wizard\wizard.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\wizard\wizard.dev
gsar -sSourceFile1 -rwizard.cpp -o %DEVPAKDIR_GSAR%\samples\samples\wizard\wizard.dev
gsar -sSourceFile2 -rwizard.rc -o %DEVPAKDIR_GSAR%\samples\samples\wizard\wizard.dev

copy Project5.dev %DEVPAKDIR%\samples\samples\xrc\xrcdemo.dev
gsar -sProjectName -rxrcdemo -o %DEVPAKDIR_GSAR%\samples\samples\xrc\xrcdemo.dev
gsar -sExeOutput=output -rExeOutput= -o %DEVPAKDIR_GSAR%\samples\samples\xrc\xrcdemo.dev
gsar -sSourceFile1 -rmyframe.cpp -o %DEVPAKDIR_GSAR%\samples\samples\xrc\xrcdemo.dev
gsar -sSourceFile2 -rcustclas.cpp -o %DEVPAKDIR_GSAR%\samples\samples\xrc\xrcdemo.dev
gsar -sSourceFile3 -rderivdlg.cpp -o %DEVPAKDIR_GSAR%\samples\samples\xrc\xrcdemo.dev
gsar -sSourceFile4 -rxrcdemo.cpp -o %DEVPAKDIR_GSAR%\samples\samples\xrc\xrcdemo.dev
gsar -sSourceFile5 -rxrcdemo.rc -o %DEVPAKDIR_GSAR%\samples\samples\xrc\xrcdemo.dev


