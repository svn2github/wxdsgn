rem copy the project files to their correct locations

CALL common_vars.bat

copy Project1.dev %WXWIN%\samples\animate\anitest.dev
gsar -sProjectName -ranitest -o %WXWIN%\samples\animate\anitest.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\animate\anitest.dev
gsar -sSourceFile1 -ranitest.cpp -o %WXWIN%\samples\animate\anitest.dev

copy Project3.dev %WXWIN%\samples\artprov\artprov.dev
gsar -sProjectName -rartprov -o %WXWIN%\samples\artprov\artprov.dev
gsar -sSourceFile1 -rarttest.cpp -o %WXWIN%\samples\artprov\artprov.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\artprov\artprov.dev
gsar -sSourceFile2 -rartbrows.cpp -o %WXWIN%\samples\artprov\artprov.dev
gsar -sSourceFile3 -rarttest.rc -o %WXWIN%\samples\artprov\artprov.dev

copy Project1.dev %WXWIN%\samples\aui\aui.dev
gsar -sProjectName -raui -o %WXWIN%\samples\aui\aui.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\aui\aui.dev
gsar -sSourceFile1 -rauidemo.cpp -o %WXWIN%\samples\aui\aui.dev

copy Project4.dev %WXWIN%\demos\bombs\bombs.dev
gsar -sProjectName -rbombs -o %WXWIN%\demos\bombs\bombs.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\demos\bombs\bombs.dev
gsar -sSourceFile1 -rbombs.cpp -o %WXWIN%\demos\bombs\bombs.dev
gsar -sSourceFile2 -rbombs1.cpp -o %WXWIN%\demos\bombs\bombs.dev
gsar -sSourceFile3 -rgame.cpp -o %WXWIN%\demos\bombs\bombs.dev
gsar -sSourceFile4 -rbombs.rc -o %WXWIN%\demos\bombs\bombs.dev

copy Project2.dev %WXWIN%\samples\calendar\calendar.dev
gsar -sProjectName -rcalendar -o %WXWIN%\samples\calendar\calendar.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\calendar\calendar.dev
gsar -sSourceFile1 -rcalendar.cpp -o %WXWIN%\samples\calendar\calendar.dev
gsar -sSourceFile2 -rcalendar.rc -o %WXWIN%\samples\calendar\calendar.dev

copy Project2.dev %WXWIN%\samples\caret\caret.dev
gsar -sProjectName -rcaret -o %WXWIN%\samples\caret\caret.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\caret\caret.dev
gsar -sSourceFile1 -rcaret.cpp -o %WXWIN%\samples\caret\caret.dev
gsar -sSourceFile2 -rcaret.rc -o %WXWIN%\samples\caret\caret.dev

copy Project2.dev %WXWIN%\3rdparty\samples\chartart\chartart.dev
gsar -sProjectName -rchartart -o %WXWIN%\3rdparty\samples\chartart\chartart.dev
gsar -s=-mwindows -r=-lwxmsw27_chartart_@@_-mwindows -o %WXWIN%\3rdparty\samples\chartart\chartart.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\3rdparty\samples\chartart\chartart.dev
gsar -sSourceFile1 -rwxchart.cpp -o %WXWIN%\3rdparty\samples\chartart\chartart.dev
gsar -sSourceFile2:x0d:x0aCompileCpp=1 -rSourceFile2 -o %WXWIN%\3rdparty\samples\chartart\chartart.dev
gsar -sSourceFile2 -r..\..\..\include\common\3rdparty\wxchart.rc -o %WXWIN%\3rdparty\samples\chartart\chartart.dev
gsar -scommon\3rdparty\wxchart.rc:x0d:x0aFolder= -rcommon\3rdparty\wxchart.rc:x0d:x0aFolder=Resources -o %WXWIN%\3rdparty\samples\chartart\chartart.dev
gsar -s#pragma:x20interface  -r//#pragma:x20interface  -o %WXWIN%\3rdparty\samples\chartart\wxchart.cpp
gsar -s#pragma:x20implementation -r//#pragma:x20implementation -o %WXWIN%\3rdparty\samples\chartart\wxchart.cpp

copy Project2.dev %WXWIN%\samples\checklst\checklst.dev
gsar -sProjectName -rchecklst -o %WXWIN%\samples\checklst\checklst.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\checklst\checklst.dev
gsar -sSourceFile1 -rchecklst.cpp -o %WXWIN%\samples\checklst\checklst.dev
gsar -sSourceFile2 -rchecklst.rc -o %WXWIN%\samples\checklst\checklst.dev

copy Project1.dev %WXWIN%\samples\combo\combo.dev
gsar -sProjectName -rcombo -o %WXWIN%\samples\combo\combo.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\combo\combo.dev
gsar -sSourceFile1 -rcombo.cpp -o %WXWIN%\samples\combo\combo.dev

copy Project2.dev %WXWIN%\samples\config\conftest.dev
gsar -sProjectName -rconftest -o %WXWIN%\samples\config\conftest.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\config\conftest.dev
gsar -sSourceFile1 -rconftest.cpp -o %WXWIN%\samples\config\conftest.dev
gsar -sSourceFile2 -rconftest.rc -o %WXWIN%\samples\config\conftest.dev

copy Project1.dev %WXWIN%\samples\console\console.dev
gsar -sProjectName -rconsole -o %WXWIN%\samples\console\console.dev
gsar -s=-mwindows_@@_ -r= -o %WXWIN%\samples\console\console.dev
gsar -sWall_@@_ -rWall_@@_-D_CONSOLE _@@_-DwxUSE_GUI=0 _@@_ -o %WXWIN%\samples\console\console.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\console\console.dev
gsar -sSourceFile1 -rconsole.cpp -o %WXWIN%\samples\console\console.dev

copy Project2.dev %WXWIN%\samples\controls\controls.dev
gsar -sProjectName -rcontrols -o %WXWIN%\samples\controls\controls.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\controls\controls.dev
gsar -sSourceFile1 -rcontrols.cpp -o %WXWIN%\samples\controls\controls.dev
gsar -sSourceFile2 -rcontrols.rc -o %WXWIN%\samples\controls\controls.dev

copy Project1.dev %WXWIN%\samples\dataview\dataview.dev
gsar -sProjectName -rdataview -o %WXWIN%\samples\dataview\dataview.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\dataview\dataview.dev
gsar -sSourceFile1 -rdataview.cpp -o %WXWIN%\samples\dataview\dataview.dev

copy Project3.dev %WXWIN%\samples\db\dbtest.dev
gsar -sProjectName -rdbtest -o %WXWIN%\samples\db\dbtest.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\db\dbtest.dev
gsar -sSourceFile1 -rdbtest.cpp -o %WXWIN%\samples\db\dbtest.dev
gsar -sSourceFile2 -rlistdb.cpp -o %WXWIN%\samples\db\dbtest.dev
gsar -sSourceFile3 -rdbtest.rc -o %WXWIN%\samples\db\dbtest.dev

copy Project10.dev %WXWIN%\demos\dbbrowse\dbbrowse.dev
gsar -sProjectName -rdbbrowse -o %WXWIN%\demos\dbbrowse\dbbrowse.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\demos\dbbrowse\dbbrowse.dev
gsar -sSourceFile10 -rdbbrowse.rc -o %WXWIN%\demos\dbbrowse\dbbrowse.dev
gsar -sSourceFile1 -rbrowsedb.cpp -o %WXWIN%\demos\dbbrowse\dbbrowse.dev
gsar -sSourceFile2 -rdbbrowse.cpp -o %WXWIN%\demos\dbbrowse\dbbrowse.dev
gsar -sSourceFile3 -rdbgrid.cpp -o %WXWIN%\demos\dbbrowse\dbbrowse.dev
gsar -sSourceFile4 -rdbtree.cpp -o %WXWIN%\demos\dbbrowse\dbbrowse.dev
gsar -sSourceFile5 -rdlguser.cpp -o %WXWIN%\demos\dbbrowse\dbbrowse.dev
gsar -sSourceFile6 -rdoc.cpp -o %WXWIN%\demos\dbbrowse\dbbrowse.dev
gsar -sSourceFile7 -rdummy.cpp -o %WXWIN%\demos\dbbrowse\dbbrowse.dev
gsar -sSourceFile8 -rpgmctrl.cpp -o %WXWIN%\demos\dbbrowse\dbbrowse.dev
gsar -sSourceFile9 -rtabpgwin.cpp -o %WXWIN%\demos\dbbrowse\dbbrowse.dev

copy Project1.dev %WXWIN%\demos\debugrpt\debugrpt.dev
gsar -sProjectName -rdebugrpt -o %WXWIN%\demos\debugrpt\debugrpt.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\demos\debugrpt\debugrpt.dev
gsar -sSourceFile1 -rdebugrpt.cpp -o %WXWIN%\demos\debugrpt\debugrpt.dev

copy Project2.dev contrib\%WXWIN%\samples\deprecated\proplist\proplist.dev
gsar -sProjectName -rproplist -o contrib\%WXWIN%\samples\deprecated\proplist\proplist.dev
gsar -s=-mwindows -r=-lwxmsw27_deprecated_@@_-mwindows -o contrib\%WXWIN%\samples\deprecated\proplist\proplist.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\deprecated\proplist\proplist.dev
gsar -sSourceFile1 -rproplist.cpp -o contrib\%WXWIN%\samples\deprecated\proplist\proplist.dev
gsar -sSourceFile2 -rproplist.rc -o contrib\%WXWIN%\samples\deprecated\proplist\proplist.dev

copy Project2.dev contrib\%WXWIN%\samples\deprecated\resource\resource.dev
gsar -sProjectName -rresource -o contrib\%WXWIN%\samples\deprecated\resource\resource.dev
gsar -s=-mwindows -r=-lwxmsw27_deprecated_@@_-mwindows -o contrib\%WXWIN%\samples\deprecated\resource\resource.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\deprecated\resource\resource.dev
gsar -sSourceFile1 -rresource.cpp -o contrib\%WXWIN%\samples\deprecated\resource\resource.dev
gsar -sSourceFile2 -rresource.rc -o contrib\%WXWIN%\samples\deprecated\resource\resource.dev

copy Project2.dev contrib\%WXWIN%\samples\deprecated\treelay\treelay.dev
gsar -sProjectName -rtreelay -o contrib\%WXWIN%\samples\deprecated\treelay\treelay.dev
gsar -s=-mwindows -r=-lwxmsw27_deprecated_@@_-mwindows -o contrib\%WXWIN%\samples\deprecated\treelay\treelay.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\deprecated\treelay\treelay.dev
gsar -sSourceFile1 -rtreelay.cpp -o contrib\%WXWIN%\samples\deprecated\treelay\treelay.dev
gsar -sSourceFile2 -rtreelay.rc -o contrib\%WXWIN%\samples\deprecated\treelay\treelay.dev

copy Project6.dev %WXWIN%\samples\dialogs\dialogs.dev
gsar -sProjectName -rdialogs -o %WXWIN%\samples\dialogs\dialogs.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\dialogs\dialogs.dev
gsar -sSourceFile1 -rdialogs.cpp -o %WXWIN%\samples\dialogs\dialogs.dev
gsar -sSourceFile2 -rdialogs.rc -o %WXWIN%\samples\dialogs\dialogs.dev
gsar -sSourceFile3 -r..\generic\colrdlgg.cpp -o %WXWIN%\samples\dialogs\dialogs.dev
gsar -sSourceFile4 -r..\generic\dirdlgg.cpp -o %WXWIN%\samples\dialogs\dialogs.dev
gsar -sSourceFile5 -r..\generic\filedlgg.cpp -o %WXWIN%\samples\dialogs\dialogs.dev
gsar -sSourceFile6 -r..\generic\fontdlgg.cpp -o %WXWIN%\samples\dialogs\dialogs.dev

copy Project2.dev %WXWIN%\samples\dialup\dialup.dev
gsar -sProjectName -rdialup -o %WXWIN%\samples\dialup\dialup.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\dialup\dialup.dev
gsar -sSourceFile1 -rnettest.cpp -o %WXWIN%\samples\dialup\dialup.dev
gsar -sSourceFile2 -rnettest.rc -o %WXWIN%\samples\dialup\dialup.dev

copy Project1.dev %WXWIN%\samples\display\display.dev
gsar -sProjectName -rdisplay -o %WXWIN%\samples\display\display.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\display\display.dev
gsar -sSourceFile1 -rdisplay.cpp -o %WXWIN%\samples\display\display.dev

copy Project2.dev %WXWIN%\samples\dnd\dnd.dev
gsar -sProjectName -rdnd -o %WXWIN%\samples\dnd\dnd.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\dnd\dnd.dev
gsar -sSourceFile1 -rdnd.cpp -o %WXWIN%\samples\dnd\dnd.dev
gsar -sSourceFile2 -rdnd.rc -o %WXWIN%\samples\dnd\dnd.dev

copy Project4.dev %WXWIN%\samples\docview\docview.dev
gsar -sProjectName -rdocview -o %WXWIN%\samples\docview\docview.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\docview\docview.dev
gsar -sSourceFile1 -rdocview.cpp -o %WXWIN%\samples\docview\docview.dev
gsar -sSourceFile2 -rdoc.cpp -o %WXWIN%\samples\docview\docview.dev
gsar -sSourceFile3 -rview.cpp -o %WXWIN%\samples\docview\docview.dev
gsar -sSourceFile4 -rdocview.rc -o %WXWIN%\samples\docview\docview.dev

copy Project4.dev %WXWIN%\samples\docvwmdi\docvwmdi.dev
gsar -sProjectName -rdocvwmdi -o %WXWIN%\samples\docvwmdi\docvwmdi.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\docvwmdi\docvwmdi.dev
gsar -sSourceFile1 -rdocview.cpp -o %WXWIN%\samples\docvwmdi\docvwmdi.dev
gsar -sSourceFile2 -rdoc.cpp -o %WXWIN%\samples\docvwmdi\docvwmdi.dev
gsar -sSourceFile3 -rview.cpp -o %WXWIN%\samples\docvwmdi\docvwmdi.dev
gsar -sSourceFile4 -rdocview.rc -o %WXWIN%\samples\docvwmdi\docvwmdi.dev

copy Project2.dev %WXWIN%\samples\dragimag\dragimag.dev
gsar -sProjectName -rdragimag -o %WXWIN%\samples\dragimag\dragimag.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\dragimag\dragimag.dev
gsar -sSourceFile1 -rdragimag.cpp -o %WXWIN%\samples\dragimag\dragimag.dev
gsar -sSourceFile2 -rdragimag.rc -o %WXWIN%\samples\dragimag\dragimag.dev

copy Project2.dev %WXWIN%\samples\drawing\drawing.dev
gsar -sProjectName -rdrawing -o %WXWIN%\samples\drawing\drawing.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\drawing\drawing.dev
gsar -sSourceFile1 -rdrawing.cpp -o %WXWIN%\samples\drawing\drawing.dev
gsar -sSourceFile2 -rdrawing.rc -o %WXWIN%\samples\drawing\drawing.dev

copy Project2.dev %WXWIN%\samples\dynamic\dynamic.dev
gsar -sProjectName -rdynamic -o %WXWIN%\samples\dynamic\dynamic.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\dynamic\dynamic.dev
gsar -sSourceFile1 -rdynamic.cpp -o %WXWIN%\samples\dynamic\dynamic.dev
gsar -sSourceFile2 -rdynamic.rc -o %WXWIN%\samples\dynamic\dynamic.dev

copy Project2.dev %WXWIN%\samples\erase\erase.dev
gsar -sProjectName -rerase -o %WXWIN%\samples\erase\erase.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\erase\erase.dev
gsar -sSourceFile1 -rerase.cpp -o %WXWIN%\samples\erase\erase.dev
gsar -sSourceFile2 -rerase.rc -o %WXWIN%\samples\erase\erase.dev

copy Project2.dev %WXWIN%\samples\event\event.dev
gsar -sProjectName -revent -o %WXWIN%\samples\event\event.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\event\event.dev
gsar -sSourceFile1 -revent.cpp -o %WXWIN%\samples\event\event.dev
gsar -sSourceFile2 -revent.rc -o %WXWIN%\samples\event\event.dev

copy Project1.dev %WXWIN%\samples\except\except.dev
gsar -sProjectName -rexcept -o %WXWIN%\samples\except\except.dev
gsar -s_@@_-fno-exceptions -r_@@_-fexceptions -o %WXWIN%\samples\except\except.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\except\except.dev
gsar -sSourceFile1 -rexcept.cpp -o %WXWIN%\samples\except\except.dev

copy Project2.dev %WXWIN%\samples\exec\exec.dev
gsar -sProjectName -rexec -o %WXWIN%\samples\exec\exec.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\exec\exec.dev
gsar -sSourceFile1 -rexec.cpp -o %WXWIN%\samples\exec\exec.dev
gsar -sSourceFile2 -rexec.rc -o %WXWIN%\samples\exec\exec.dev

copy Project2.dev contrib\%WXWIN%\samples\fl\fl_demo1.dev
gsar -sProjectName -rfl_demo1 -o contrib\%WXWIN%\samples\fl\fl_demo1.dev
gsar -s=-mwindows -r=-lwxmsw27_fl_@@_-mwindows -o contrib\%WXWIN%\samples\fl\fl_demo1.dev
gsar -sWall_@@_ -rWall_@@_-DBMP_DIR=\\\"./bitmaps/\\\"_@@_ -o contrib\%WXWIN%\samples\fl\fl_demo1.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\fl\fl_demo1.dev
gsar -sSourceFile1 -rfl_demo1.cpp -o contrib\%WXWIN%\samples\fl\fl_demo1.dev
gsar -sSourceFile2 -rfl_demo1.rc -o contrib\%WXWIN%\samples\fl\fl_demo1.dev

copy Project2.dev contrib\%WXWIN%\samples\fl\fl_demo2.dev
gsar -sProjectName -rfl_demo2 -o contrib\%WXWIN%\samples\fl\fl_demo2.dev
gsar -s=-mwindows -r=-lwxmsw27_fl_@@_-mwindows -o contrib\%WXWIN%\samples\fl\fl_demo2.dev
gsar -sWall_@@_ -rWall_@@_-DBMP_DIR=\\\"./bitmaps/\\\"_@@_ -o contrib\%WXWIN%\samples\fl\fl_demo2.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\fl\fl_demo2.dev
gsar -sSourceFile1 -rfl_demo2.cpp -o contrib\%WXWIN%\samples\fl\fl_demo2.dev
gsar -sSourceFile2 -rfl_demo2.rc -o contrib\%WXWIN%\samples\fl\fl_demo2.dev
gsar -sICON:x20:x22mondrian -rICON:x20:x22sample -o contrib\%WXWIN%\samples\fl\fl_demo2.rc
gsar -s/* -r -o contrib\%WXWIN%\samples\fl\fl_demo2.rc
gsar -s*/ -r -o contrib\%WXWIN%\samples\fl\fl_demo2.rc

copy Project2.dev contrib\%WXWIN%\samples\fl\fl_sample1.dev
gsar -sProjectName -rfl_sample1 -o contrib\%WXWIN%\samples\fl\fl_sample1.dev
gsar -s=-mwindows -r=-lwxmsw27_fl_@@_-mwindows -o contrib\%WXWIN%\samples\fl\fl_sample1.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\\html\helpview\helpview.dev
gsar -sSourceFile1 -rfl_sample1.cpp -o contrib\%WXWIN%\samples\fl\fl_sample1.dev
gsar -sSourceFile2 -rfl_sample1.rc -o contrib\%WXWIN%\samples\fl\fl_sample1.dev

copy Project2.dev contrib\%WXWIN%\samples\fl\fl_sample2.dev
gsar -sProjectName -rfl_sample2 -o contrib\%WXWIN%\samples\fl\fl_sample2.dev
gsar -s=-mwindows -r=-lwxmsw27_fl_@@_-mwindows -o contrib\%WXWIN%\samples\fl\fl_sample2.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\fl\fl_sample2.dev
gsar -sSourceFile1 -rfl_sample2.cpp -o contrib\%WXWIN%\samples\fl\fl_sample2.dev
gsar -sSourceFile2 -rfl_sample2.rc -o contrib\%WXWIN%\samples\fl\fl_sample2.dev

copy Project2.dev contrib\%WXWIN%\samples\fl\fl_sample3.dev
gsar -sProjectName -rfl_sample3 -o contrib\%WXWIN%\samples\fl\fl_sample3.dev
gsar -s=-mwindows -r=-lwxmsw27_fl_@@_-mwindows -o contrib\%WXWIN%\samples\fl\fl_sample3.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\fl\fl_sample3.dev
gsar -sSourceFile1 -rfl_sample3.cpp -o contrib\%WXWIN%\samples\fl\fl_sample3.dev
gsar -sSourceFile2 -rfl_sample3.rc -o contrib\%WXWIN%\samples\fl\fl_sample3.dev

copy Project2.dev contrib\%WXWIN%\samples\foldbar\extended\extended.dev
gsar -sProjectName -rextended -o contrib\%WXWIN%\samples\foldbar\extended\extended.dev
gsar -s=-mwindows -r=-lwxmsw27_foldbar_@@_-mwindows -o contrib\%WXWIN%\samples\foldbar\extended\extended.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\foldbar\extended\extended.dev
gsar -sSourceFile1 -rextended.cpp -o contrib\%WXWIN%\samples\foldbar\extended\extended.dev
gsar -sSourceFile2 -rextended.rc -o contrib\%WXWIN%\samples\foldbar\extended\extended.dev

copy Project5.dev contrib\%WXWIN%\samples\foldbar\foldpanelbar\foldpanelbartest.dev
gsar -sProjectName -rfoldpanelbartest -o contrib\%WXWIN%\samples\foldbar\foldpanelbar\foldpanelbartest.dev
gsar -s=-mwindows -r=-lwxmsw27_foldbar_@@_-mwindows -o contrib\%WXWIN%\samples\foldbar\foldpanelbar\foldpanelbartest.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\foldbar\foldpanelbar\foldpanelbartest.dev
gsar -sSourceFile1 -rfoldpanelbartest.cpp -o contrib\%WXWIN%\samples\foldbar\foldpanelbar\foldpanelbartest.dev
gsar -sSourceFile2 -rfoldtestpanel.cpp -o contrib\%WXWIN%\samples\foldbar\foldpanelbar\foldpanelbartest.dev
gsar -sSourceFile3 -rlayouttest.cpp -o contrib\%WXWIN%\samples\foldbar\foldpanelbar\foldpanelbartest.dev
gsar -sSourceFile4 -rtest.cpp -o contrib\%WXWIN%\samples\foldbar\foldpanelbar\foldpanelbartest.dev
gsar -sSourceFile5 -rfoldpanelbartest.rc -o contrib\%WXWIN%\samples\foldbar\foldpanelbar\foldpanelbartest.dev

copy Project2.dev %WXWIN%\samples\font\font.dev
gsar -sProjectName -rfont -o %WXWIN%\samples\font\font.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\font\font.dev
gsar -sSourceFile1 -rfont.cpp -o %WXWIN%\samples\font\font.dev
gsar -sSourceFile2 -rfont.rc -o %WXWIN%\samples\font\font.dev

copy Project9.dev %WXWIN%\demos\forty\forty.dev
gsar -sProjectName -rforty -o %WXWIN%\demos\forty\forty.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\demos\forty\forty.dev
gsar -sSourceFile1 -rcanvas.cpp -o %WXWIN%\demos\forty\forty.dev
gsar -sSourceFile2 -rforty.cpp -o %WXWIN%\demos\forty\forty.dev
gsar -sSourceFile3 -rcard.cpp -o %WXWIN%\demos\forty\forty.dev
gsar -sSourceFile4 -rgame.cpp -o %WXWIN%\demos\forty\forty.dev
gsar -sSourceFile5 -rpile.cpp -o %WXWIN%\demos\forty\forty.dev
gsar -sSourceFile6 -rplayerdg.cpp -o %WXWIN%\demos\forty\forty.dev
gsar -sSourceFile7 -rscoredg.cpp -o %WXWIN%\demos\forty\forty.dev
gsar -sSourceFile8 -rscorefil.cpp -o %WXWIN%\demos\forty\forty.dev
gsar -sSourceFile9 -rforty.rc -o %WXWIN%\demos\forty\forty.dev

copy Project2.dev %WXWIN%\demos\fractal\fractal.dev
gsar -sProjectName -rfractal -o %WXWIN%\demos\fractal\fractal.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\demos\fractal\fractal.dev
gsar -sSourceFile1 -rfractal.cpp -o %WXWIN%\demos\fractal\fractal.dev
gsar -sSourceFile2 -rfractal.rc -o %WXWIN%\demos\fractal\fractal.dev

copy Project1.dev contrib\%WXWIN%\samples\gizmos\dynsash\dynsash.dev
gsar -sProjectName -rdynsash -o contrib\%WXWIN%\samples\gizmos\dynsash\dynsash.dev
gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o contrib\%WXWIN%\samples\gizmos\dynsash\dynsash.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\gizmos\dynsash\dynsash.dev
gsar -sSourceFile1 -rdynsash.cpp -o contrib\%WXWIN%\samples\gizmos\dynsash\dynsash.dev

copy Project1.dev contrib\%WXWIN%\samples\gizmos\dynsash_switch\dynsash_switch.dev
gsar -sProjectName -rdynsash_switch -o contrib\%WXWIN%\samples\gizmos\dynsash_switch\dynsash_switch.dev
gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o contrib\%WXWIN%\samples\gizmos\dynsash_switch\dynsash_switch.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\gizmos\dynsash_switch\dynsash_switch.dev
gsar -sSourceFile1 -rdynsash_switch.cpp -o contrib\%WXWIN%\samples\gizmos\dynsash_switch\dynsash_switch.dev

copy Project1.dev contrib\%WXWIN%\samples\gizmos\editlbox\editlbox.dev
gsar -sProjectName -reditlbox -o contrib\%WXWIN%\samples\gizmos\editlbox\editlbox.dev
gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o contrib\%WXWIN%\samples\gizmos\editlbox\editlbox.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\gizmos\editlbox\editlbox.dev
gsar -sSourceFile1 -rtest.cpp -o contrib\%WXWIN%\samples\gizmos\editlbox\editlbox.dev

copy Project1.dev contrib\%WXWIN%\samples\gizmos\led\led.dev
gsar -sProjectName -rled -o contrib\%WXWIN%\samples\gizmos\led\led.dev
gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o contrib\%WXWIN%\samples\gizmos\led\led.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\gizmos\led\led.dev
gsar -sSourceFile1 -rled.cpp -o contrib\%WXWIN%\samples\gizmos\led\led.dev

copy Project1.dev contrib\%WXWIN%\samples\gizmos\multicell\multicell.dev
gsar -sProjectName -rmulticell -o contrib\%WXWIN%\samples\gizmos\multicell\multicell.dev
gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o contrib\%WXWIN%\samples\gizmos\multicell\multicell.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\gizmos\multicell\multicell.dev
gsar -sSourceFile1 -rmtest.cpp -o contrib\%WXWIN%\samples\gizmos\multicell\multicell.dev

copy Project1.dev contrib\%WXWIN%\samples\gizmos\splittree\splittree.dev
gsar -sProjectName -rsplittree -o contrib\%WXWIN%\samples\gizmos\splittree\splittree.dev
gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o contrib\%WXWIN%\samples\gizmos\splittree\splittree.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\gizmos\splittree\splittree.dev
gsar -sSourceFile1 -rtree.cpp -o contrib\%WXWIN%\samples\gizmos\splittree\splittree.dev
gsar -sSourceFile1 -rtree.cpp -o contrib\%WXWIN%\samples\gizmos\splittree\splittree.dev
gsar -swxICON_SMALL_CLOSED_FOLDER -r../../art/folder.xpm -o contrib\%WXWIN%\samples\gizmos\splittree\splittree.dev
gsar -swxICON_SMALL_FILE -r../../art/fileopen.xpm contrib\%WXWIN%\samples\gizmos\splittree\splittree.dev

copy Project2.dev %WXWIN%\samples\grid\grid.dev
gsar -sProjectName -rgrid -o %WXWIN%\samples\grid\grid.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\grid\grid.dev
gsar -sSourceFile1 -rgriddemo.cpp -o %WXWIN%\samples\grid\grid.dev
gsar -sSourceFile2 -rgriddemo.rc -o %WXWIN%\samples\grid\grid.dev

copy Project2.dev %WXWIN%\samples\help\help.dev
gsar -sProjectName -rhelp -o %WXWIN%\samples\help\help.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\help\help.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\\html\helpview\helpview.dev
gsar -sSourceFile1 -rdemo.cpp -o %WXWIN%\samples\help\help.dev
gsar -sSourceFile2 -rdemo.rc -o %WXWIN%\samples\help\help.dev

copy Project2.dev %WXWIN%\samples\htlbox\htlbox.dev
gsar -sProjectName -rhtlbox -o %WXWIN%\samples\htlbox\htlbox.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\help\help.dev
gsar -sSourceFile1 -rhtlbox.cpp -o %WXWIN%\samples\htlbox\htlbox.dev
gsar -sSourceFile2 -rhtlbox.rc -o %WXWIN%\samples\htlbox\htlbox.dev

copy Project2.dev %WXWIN%\samples\html\about\about.dev
gsar -sProjectName -rabout -o %WXWIN%\samples\html\about\about.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\html\about\about.dev
gsar -sSourceFile1 -rabout.cpp -o %WXWIN%\samples\html\about\about.dev
gsar -sSourceFile2 -rabout.rc -o %WXWIN%\samples\html\about\about.dev

copy Project2.dev %WXWIN%\samples\html\help\help.dev
gsar -sProjectName -rhelp -o %WXWIN%\samples\html\help\help.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\html\help\help.dev
gsar -sSourceFile1 -rhelp.cpp -o %WXWIN%\samples\html\help\help.dev
gsar -sSourceFile2 -rhelp.rc -o %WXWIN%\samples\html\help\help.dev

copy Project2.dev %WXWIN%\samples\html\helpview\helpview.dev
gsar -sProjectName -rhelpview -o %WXWIN%\samples\html\helpview\helpview.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\html\helpview\helpview.dev
gsar -sSourceFile1 -rhelpview.cpp -o %WXWIN%\samples\html\helpview\helpview.dev
gsar -sSourceFile2 -rhelpview.rc -o %WXWIN%\samples\html\helpview\helpview.dev

copy Project2.dev %WXWIN%\samples\html\printing\printing.dev
gsar -sProjectName -rprinting -o %WXWIN%\samples\html\printing\printing.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\html\printing\printing.dev
gsar -sSourceFile1 -rprinting.cpp -o %WXWIN%\samples\html\printing\printing.dev
gsar -sSourceFile2 -rprinting.rc -o %WXWIN%\samples\html\printing\printing.dev

copy Project2.dev %WXWIN%\samples\html\test\test.dev
gsar -sProjectName -rtest -o %WXWIN%\samples\html\test\test.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\html\test\test.dev
gsar -sSourceFile1 -rtest.cpp -o %WXWIN%\samples\html\test\test.dev
gsar -sSourceFile2 -rtest.rc -o %WXWIN%\samples\html\test\test.dev

copy Project2.dev %WXWIN%\samples\html\virtual\virtual.dev
gsar -sProjectName -rvirtual -o %WXWIN%\samples\html\virtual\virtual.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\html\virtual\virtual.dev
gsar -sSourceFile1 -rvirtual.cpp -o %WXWIN%\samples\html\virtual\virtual.dev
gsar -sSourceFile2 -rvirtual.rc -o %WXWIN%\samples\html\virtual\virtual.dev

copy Project2.dev %WXWIN%\samples\html\widget\widget.dev
gsar -sProjectName -rwidget -o %WXWIN%\samples\html\widget\widget.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\html\widget\widget.dev
gsar -sSourceFile1 -rwidget.cpp -o %WXWIN%\samples\html\widget\widget.dev
gsar -sSourceFile2 -rwidget.rc -o %WXWIN%\samples\html\widget\widget.dev

copy Project2.dev %WXWIN%\samples\html\zip\zip.dev
gsar -sProjectName -rzip -o %WXWIN%\samples\html\zip\zip.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\html\zip\zip.dev
gsar -sSourceFile1 -rzip.cpp -o %WXWIN%\samples\html\zip\zip.dev
gsar -sSourceFile2 -rzip.rc -o %WXWIN%\samples\html\zip\zip.dev

copy Project1.dev %WXWIN%\3rdparty\samples\ifm\ifm.dev
gsar -sProjectName -rifm -o %WXWIN%\3rdparty\samples\ifm\ifm.dev
gsar -s=-mwindows -r=-lwxmsw27_ifm_@@_-mwindows -o %WXWIN%\3rdparty\samples\ifm\ifm.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\3rdparty\samples\ifm\ifm.dev
gsar -sSourceFile1 -rmain.cpp -o %WXWIN%\3rdparty\samples\ifm\ifm.dev

copy Project2.dev %WXWIN%\samples\image\image.dev
gsar -sProjectName -rimage -o %WXWIN%\samples\image\image.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\image\image.dev
gsar -sSourceFile1 -rimage.cpp -o %WXWIN%\samples\image\image.dev
gsar -sSourceFile2 -rimage.rc -o %WXWIN%\samples\image\image.dev

copy Project2.dev %WXWIN%\samples\internat\internat.dev
gsar -sProjectName -rinternat -o %WXWIN%\samples\internat\internat.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\internat\internat.dev
gsar -sSourceFile1 -rinternat.cpp -o %WXWIN%\samples\internat\internat.dev
gsar -sSourceFile2 -rinternat.rc -o %WXWIN%\samples\internat\internat.dev

copy Project2.dev %WXWIN%\samples\ipc\ipcclient.dev
gsar -sProjectName -rclient -o %WXWIN%\samples\ipc\ipcclient.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\ipc\ipcclient.dev
gsar -sSourceFile1 -rclient.cpp -o %WXWIN%\samples\ipc\ipcclient.dev
gsar -sSourceFile2 -rclient.rc -o %WXWIN%\samples\ipc\ipcclient.dev

copy Project2.dev %WXWIN%\samples\ipc\ipcserver.dev
gsar -sProjectName -rserver -o %WXWIN%\samples\ipc\ipcserver.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\ipc\ipcserver.dev
gsar -sSourceFile1 -rserver.cpp -o %WXWIN%\samples\ipc\ipcserver.dev
gsar -sSourceFile2 -rserver.rc -o %WXWIN%\samples\ipc\ipcserver.dev

copy Project2.dev %WXWIN%\samples\joytest\joytest.dev
gsar -sProjectName -rjoytest -o %WXWIN%\samples\joytest\joytest.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\joytest\joytest.dev
gsar -sSourceFile1 -rjoytest.cpp -o %WXWIN%\samples\joytest\joytest.dev
gsar -sSourceFile2 -rjoytest.rc -o %WXWIN%\samples\joytest\joytest.dev

copy Project2.dev %WXWIN%\samples\keyboard\keyboard.dev
gsar -sProjectName -rkeyboard -o %WXWIN%\samples\keyboard\keyboard.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\keyboard\keyboard.dev
gsar -sSourceFile1 -rkeyboard.cpp -o %WXWIN%\samples\keyboard\keyboard.dev
gsar -sSourceFile2 -rkeyboard.rc -o %WXWIN%\samples\keyboard\keyboard.dev

copy Project3.dev %WXWIN%\samples\layout\layout.dev
gsar -sProjectName -rlayout -o %WXWIN%\samples\layout\layout.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\layout\layout.dev
gsar -sSourceFile1 -rlayout.cpp -o %WXWIN%\samples\layout\layout.dev
gsar -sSourceFile2 -rexpt.cpp -o %WXWIN%\samples\layout\layout.dev
gsar -sSourceFile3 -rlayout.rc -o %WXWIN%\samples\layout\layout.dev

copy Project5.dev %WXWIN%\demos\life\life.dev
gsar -sProjectName -rlife -o %WXWIN%\demos\life\life.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\demos\life\life.dev
gsar -sSourceFile1 -rgame.cpp -o %WXWIN%\demos\life\life.dev
gsar -sSourceFile2 -rdialogs.cpp -o %WXWIN%\demos\life\life.dev
gsar -sSourceFile3 -rlife.cpp -o %WXWIN%\demos\life\life.dev
gsar -sSourceFile4 -rreader.cpp -o %WXWIN%\demos\life\life.dev
gsar -sSourceFile5 -rlife.rc -o %WXWIN%\demos\life\life.dev

copy Project1.dev %WXWIN%\samples\listbox\listbox.dev
gsar -sProjectName -rlistbox -o %WXWIN%\samples\listbox\listbox.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\listbox\listbox.dev
gsar -sSourceFile1 -rlboxtest.cpp -o %WXWIN%\samples\listbox\listbox.dev

copy Project2.dev %WXWIN%\samples\listctrl\listctrl.dev
gsar -sProjectName -rlistctrl -o %WXWIN%\samples\listctrl\listctrl.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\listctrl\listctrl.dev
gsar -sSourceFile1 -rlisttest.cpp -o %WXWIN%\samples\listctrl\listctrl.dev
gsar -sSourceFile2 -rlisttest.rc -o %WXWIN%\samples\listctrl\listctrl.dev

copy Project2.dev %WXWIN%\samples\mdi\mdi.dev
gsar -sProjectName -rmdi -o %WXWIN%\samples\mdi\mdi.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\mdi\mdi.dev
gsar -sSourceFile1 -rmdi.cpp -o %WXWIN%\samples\mdi\mdi.dev
gsar -sSourceFile2 -rmdi.rc -o %WXWIN%\samples\mdi\mdi.dev

copy Project1.dev %WXWIN%\samples\mediaplayer\mediaplayer.dev
gsar -sProjectName -rmediaplayer -o %WXWIN%\samples\mediaplayer\mediaplayer.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\mediaplayer\mediaplayer.dev
gsar -sSourceFile1 -rmediaplayer.cpp -o %WXWIN%\samples\mediaplayer\mediaplayer.dev

copy Project2.dev %WXWIN%\samples\memcheck\memcheck.dev
gsar -sProjectName -rmemcheck -o %WXWIN%\samples\memcheck\memcheck.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\memcheck\memcheck.dev
gsar -sSourceFile1 -rmemcheck.cpp -o %WXWIN%\samples\memcheck\memcheck.dev
gsar -sSourceFile2 -rmemcheck.rc -o %WXWIN%\samples\memcheck\memcheck.dev

copy Project2.dev %WXWIN%\samples\menu\menu.dev
gsar -sProjectName -rmenu -o %WXWIN%\samples\menu\menu.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\menu\menu.dev
gsar -sSourceFile1 -rmenu.cpp -o %WXWIN%\samples\menu\menu.dev
gsar -sSourceFile2 -rmenu.rc -o %WXWIN%\samples\menu\menu.dev

copy Project2.dev %WXWIN%\samples\mfc\mfctest.dev
gsar -sProjectName -rmfctest -o %WXWIN%\samples\mfc\mfctest.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\mfc\mfctest.dev
gsar -sSourceFile1 -rmfctest.cpp -o %WXWIN%\samples\mfc\mfctest.dev
gsar -sSourceFile2 -rmfctest.rc -o %WXWIN%\samples\mfc\mfctest.dev

copy Project2.dev %WXWIN%\samples\minifram\minifram.dev
gsar -sProjectName -rminifram -o %WXWIN%\samples\minifram\minifram.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\minifram\minifram.dev
gsar -sSourceFile1 -rminifram.cpp -o %WXWIN%\samples\minifram\minifram.dev
gsar -sSourceFile2 -rminifram.rc -o %WXWIN%\samples\minifram\minifram.dev

copy Project2.dev %WXWIN%\samples\minimal\minimal.dev
gsar -sProjectName -rminimal -o %WXWIN%\samples\minimal\minimal.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\minimal\minimal.dev
gsar -sSourceFile1 -rminimal.cpp -o %WXWIN%\samples\minimal\minimal.dev
gsar -sSourceFile2 -rminimal.rc -o %WXWIN%\samples\minimal\minimal.dev

copy Project3.dev contrib\%WXWIN%\samples\mmedia\mmedia.dev
gsar -sProjectName -rmmedia -o contrib\%WXWIN%\samples\mmedia\mmedia.dev
gsar -s=-mwindows -r=-lwxmsw27_mmedia_@@_-mwindows -o contrib\%WXWIN%\samples\mmedia\mmedia.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\mmedia\mmedia.dev
gsar -sSourceFile1 -rmmboard.cpp -o contrib\%WXWIN%\samples\mmedia\mmedia.dev
gsar -sSourceFile2 -rmmbman.cpp -o contrib\%WXWIN%\samples\mmedia\mmedia.dev
gsar -sSourceFile3 -rmmboard.rc -o contrib\%WXWIN%\samples\mmedia\mmedia.dev

copy Project1.dev %WXWIN%\samples\mobile\styles\styles.dev
gsar -sProjectName -rstyles -o %WXWIN%\samples\mobile\styles\styles.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\mobile\styles\styles.dev
gsar -sSourceFile1 -rstyles.cpp -o %WXWIN%\samples\mobile\styles\styles.dev

copy Project1.dev %WXWIN%\samples\multimon\multimon.dev
gsar -sProjectName -rmultimon -o %WXWIN%\samples\multimon\multimon.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\multimon\multimon.dev
gsar -sSourceFile1 -rmultimon_test.cpp -o %WXWIN%\samples\multimon\multimon.dev

copy Project1.dev %WXWIN%\samples\mobile\wxedit\wxedit.dev
gsar -sProjectName -rwxedit -o %WXWIN%\samples\mobile\wxedit\wxedit.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\mobile\wxedit\wxedit.dev
gsar -sSourceFile1 -rwxedit.cpp -o %WXWIN%\samples\mobile\wxedit\wxedit.dev

copy Project2.dev %WXWIN%\samples\nativdlg\nativdlg.dev
gsar -sProjectName -rnativdlg -o %WXWIN%\samples\nativdlg\nativdlg.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\nativdlg\nativdlg.dev
gsar -sSourceFile1 -rnativdlg.cpp -o %WXWIN%\samples\nativdlg\nativdlg.dev
gsar -sSourceFile2 -rnativdlg.rc -o %WXWIN%\samples\nativdlg\nativdlg.dev

copy Project1.dev %WXWIN%\samples\notebook\notebook.dev
gsar -sProjectName -rnotebook -o %WXWIN%\samples\notebook\notebook.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\notebook\notebook.dev
gsar -sSourceFile1 -rnotebook.cpp -o %WXWIN%\samples\notebook\notebook.dev

copy Project5.dev contrib\%WXWIN%\samples\ogl\ogledit\ogledit.dev
gsar -sProjectName -rogledit -o contrib\%WXWIN%\samples\ogl\ogledit\ogledit.dev
gsar -s=-mwindows -r=-lwxmsw27_ogl_@@_-mwindows -o contrib\%WXWIN%\samples\ogl\ogledit\ogledit.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\ogl\ogledit\ogledit.dev
gsar -sSourceFile1 -rogledit.cpp -o contrib\%WXWIN%\samples\ogl\ogledit\ogledit.dev
gsar -sSourceFile2 -rdoc.cpp -o contrib\%WXWIN%\samples\ogl\ogledit\ogledit.dev
gsar -sSourceFile3 -rpalette.cpp -o contrib\%WXWIN%\samples\ogl\ogledit\ogledit.dev
gsar -sSourceFile4 -rview.cpp -o contrib\%WXWIN%\samples\ogl\ogledit\ogledit.dev
gsar -sSourceFile5 -rogledit.rc -o contrib\%WXWIN%\samples\ogl\ogledit\ogledit.dev

copy Project11.dev contrib\%WXWIN%\samples\ogl\studio\studio.dev
gsar -sProjectName -rstudio -o contrib\%WXWIN%\samples\ogl\studio\studio.dev
gsar -s=-mwindows -r=-lwxmsw27_ogl_@@_-mwindows -o contrib\%WXWIN%\samples\ogl\studio\studio.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\ogl\studio\studio.dev
gsar -sSourceFile10 -rview.cpp -o contrib\%WXWIN%\samples\ogl\studio\studio.dev
gsar -sSourceFile11 -rstudio.rc -o contrib\%WXWIN%\samples\ogl\studio\studio.dev
gsar -sSourceFile1 -rcspalette.cpp -o contrib\%WXWIN%\samples\ogl\studio\studio.dev
gsar -sSourceFile2 -rcsprint.cpp -o contrib\%WXWIN%\samples\ogl\studio\studio.dev
gsar -sSourceFile3 -rdialogs.cpp -o contrib\%WXWIN%\samples\ogl\studio\studio.dev
gsar -sSourceFile4 -rdoc.cpp -o contrib\%WXWIN%\samples\ogl\studio\studio.dev
gsar -sSourceFile5 -rmainfrm.cpp -o contrib\%WXWIN%\samples\ogl\studio\studio.dev
gsar -sSourceFile6 -rproject.cpp -o contrib\%WXWIN%\samples\ogl\studio\studio.dev
gsar -sSourceFile7 -rshapes.cpp -o contrib\%WXWIN%\samples\ogl\studio\studio.dev
gsar -sSourceFile8 -rstudio.cpp -o contrib\%WXWIN%\samples\ogl\studio\studio.dev
gsar -sSourceFile9 -rsymbols.cpp -o contrib\%WXWIN%\samples\ogl\studio\studio.dev

copy Project2.dev %WXWIN%\samples\oleauto\oleauto.dev
gsar -sProjectName -roleauto -o %WXWIN%\samples\oleauto\oleauto.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\oleauto\oleauto.dev
gsar -sSourceFile1 -roleauto.cpp -o %WXWIN%\samples\oleauto\oleauto.dev
gsar -sSourceFile2 -roleauto.rc -o %WXWIN%\samples\oleauto\oleauto.dev

copy Project2.dev %WXWIN%\samples\opengl\cube\cube.dev
gsar -sProjectName -rcube -o %WXWIN%\samples\opengl\cube\cube.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\opengl\cube\cube.dev
gsar -sSourceFile1 -rcube.cpp -o %WXWIN%\samples\opengl\cube\cube.dev
gsar -sSourceFile2 -rcube.rc -o %WXWIN%\samples\opengl\cube\cube.dev

copy Project1.dev %WXWIN%\samples\opengl\isosurf\isosurf.dev
gsar -sProjectName -risosurf -o %WXWIN%\samples\opengl\isosurf\isosurf.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\opengl\isosurf\isosurf.dev
gsar -sSourceFile1 -risosurf.cpp -o %WXWIN%\samples\opengl\isosurf\isosurf.dev
gsar -sSourceFile2 -risosurf.rc -o %WXWIN%\samples\opengl\isosurf\isosurf.dev

copy Project4.dev %WXWIN%\samples\opengl\penguin\penguin.dev
gsar -sProjectName -rpenguin -o %WXWIN%\samples\opengl\penguin\penguin.dev
gsar -s-lopengl32_@@_ -r-lopengl32_@@_-lglu32_@@_ -o %WXWIN%\samples\opengl\penguin\penguin.dev
gsar -sCompiler=-fno-rtti_@@_- -rCompiler=- -o %WXWIN%\samples\opengl\penguin\penguin.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\opengl\penguin\penguin.dev
gsar -sSourceFile1 -rpenguin.cpp -o %WXWIN%\samples\opengl\penguin\penguin.dev
gsar -sSourceFile2:x0d:x0aCompileCpp=1 -rtrackball.c:x0d:x0aCompileCpp=0 -o %WXWIN%\samples\opengl\penguin\penguin.dev
gsar -sSourceFile3 -rdxfrenderer.cpp -o %WXWIN%\samples\opengl\penguin\penguin.dev
gsar -sSourceFile4 -rpenguin.rc -o %WXWIN%\samples\opengl\penguin\penguin.dev

copy Project2.dev %WXWIN%\samples\ownerdrw\ownerdrw.dev
gsar -sProjectName -rownerdrw -o %WXWIN%\samples\ownerdrw\ownerdrw.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\ownerdrw\ownerdrw.dev
gsar -sSourceFile1 -rownerdrw.cpp -o %WXWIN%\samples\ownerdrw\ownerdrw.dev
gsar -sSourceFile2 -rownerdrw.rc -o %WXWIN%\samples\ownerdrw\ownerdrw.dev

copy Project2.dev contrib\%WXWIN%\samples\plot\plot.dev
gsar -sProjectName -rplot -o contrib\%WXWIN%\samples\plot\plot.dev
gsar -s=-mwindows -r=-lwxmsw27_plot_@@_-mwindows -o contrib\%WXWIN%\samples\plot\plot.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\plot\plot.dev
gsar -sSourceFile1 -rplot.cpp -o contrib\%WXWIN%\samples\plot\plot.dev
gsar -sSourceFile2 -rplot.rc -o contrib\%WXWIN%\samples\plot\plot.dev

copy Project2.dev %WXWIN%\3rdparty\samples\plotctrl\plotctrl.dev
gsar -sProjectName -rplotctrl -o %WXWIN%\3rdparty\samples\plotctrl\plotctrl.dev
gsar -s=-mwindows -r=-lwxmsw27_plotctrl_@@_-lwxmsw27_things_@@_-mwindows -o %WXWIN%\3rdparty\samples\plotctrl\plotctrl.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\3rdparty\samples\plotctrl\plotctrl.dev
gsar -sSourceFile1 -rwxplotctrl.cpp -o %WXWIN%\3rdparty\samples\plotctrl\plotctrl.dev
gsar -sSourceFile2 -rwxplotctrl.rc -o %WXWIN%\3rdparty\samples\plotctrl\plotctrl.dev

copy Project2.dev %WXWIN%\samples\png\png.dev
gsar -sProjectName -rpng -o %WXWIN%\samples\png\png.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\png\png.dev
gsar -sSourceFile1 -rpngdemo.cpp -o %WXWIN%\samples\png\png.dev
gsar -sSourceFile2 -rpngdemo.rc -o %WXWIN%\samples\png\png.dev

copy Project2.dev %WXWIN%\demos\poem\poem.dev
gsar -sProjectName -rpoem -o %WXWIN%\demos\poem\poem.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\demos\poem\poem.dev
gsar -sSourceFile1 -rwxpoem.cpp -o %WXWIN%\demos\poem\poem.dev
gsar -sSourceFile2 -rwxpoem.rc -o %WXWIN%\demos\poem\poem.dev

copy Project1.dev %WXWIN%\samples\popup\popup.dev
gsar -sProjectName -rpopup -o %WXWIN%\samples\popup\popup.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\popup\popup.dev
gsar -sSourceFile1 -rpopup.cpp -o %WXWIN%\samples\popup\popup.dev

copy Project1.dev %WXWIN%\samples\power\power.dev
gsar -sProjectName -rpower -o %WXWIN%\samples\power\power.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\power\power.dev
gsar -sSourceFile1 -rpower.cpp -o %WXWIN%\samples\power\power.dev

copy Project2.dev %WXWIN%\samples\printing\printing.dev
gsar -sProjectName -rprinting -o %WXWIN%\samples\printing\printing.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\printing\printing.dev
gsar -sSourceFile1 -rprinting.cpp -o %WXWIN%\samples\printing\printing.dev
gsar -sSourceFile2 -rprinting.rc -o %WXWIN%\samples\printing\printing.dev

copy Project2.dev %WXWIN%\3rdparty\samples\propgrid\propgrid.dev
gsar -sProjectName -rpropgrid -o %WXWIN%\3rdparty\samples\propgrid\propgrid.dev
gsar -s=-mwindows -r=-lwxmsw27_propgrid_@@_-mwindows -o %WXWIN%\3rdparty\samples\propgrid\propgrid.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\3rdparty\samples\propgrid\propgrid.dev
gsar -sSourceFile1 -rpropgridsample.cpp -o %WXWIN%\3rdparty\samples\propgrid\propgrid.dev
gsar -sSourceFile2 -rsampleprops.cpp -o %WXWIN%\3rdparty\samples\propgrid\propgrid.dev

copy Project2.dev %WXWIN%\samples\propsize\propsize.dev
gsar -sProjectName -rpropsize -o %WXWIN%\samples\propsize\propsize.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\propsize\propsize.dev
gsar -sSourceFile1 -rpropsize.cpp -o %WXWIN%\samples\propsize\propsize.dev
gsar -sSourceFile2 -rpropsize.rc -o %WXWIN%\samples\propsize\propsize.dev

copy Project2.dev %WXWIN%\samples\regtest\regtest.dev
gsar -sProjectName -rregtest -o %WXWIN%\samples\regtest\regtest.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\regtest\regtest.dev
gsar -sSourceFile1 -rregtest.cpp -o %WXWIN%\samples\regtest\regtest.dev
gsar -sSourceFile2 -rregtest.rc -o %WXWIN%\samples\regtest\regtest.dev

rem copy Project1.dev %WXWIN%\samples\render\renddll.dev
rem gsar -sProjectName -rrenddll -o %WXWIN%\samples\render\renddll.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\render\renddll.dev
rem gsar -sSourceFile1 -rrenddll.cpp -o %WXWIN%\samples\render\renddll.dev

rem copy Project1.dev %WXWIN%\samples\render\render.dev
rem gsar -sProjectName -rrender -o %WXWIN%\samples\render\render.dev
rem gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\render\render.dev
rem gsar -sSourceFile1 -rrender.cpp -o %WXWIN%\samples\render\render.dev

copy Project1.dev %WXWIN%\samples\richtext\richtext.dev
gsar -sProjectName -rrichtext -o %WXWIN%\samples\richtext\richtext.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\richtext\richtext.dev
gsar -sSourceFile1 -rrichtext.cpp -o %WXWIN%\samples\richtext\richtext.dev

copy Project2.dev %WXWIN%\samples\rotate\rotate.dev
gsar -sProjectName -rrotate -o %WXWIN%\samples\rotate\rotate.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\rotate\rotate.dev
gsar -sSourceFile1 -rrotate.cpp -o %WXWIN%\samples\rotate\rotate.dev
gsar -sSourceFile2 -rrotate.rc -o %WXWIN%\samples\rotate\rotate.dev

copy Project2.dev %WXWIN%\samples\sashtest\sashtest.dev
gsar -sProjectName -rsashtest -o %WXWIN%\samples\sashtest\sashtest.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\sashtest\sashtest.dev
gsar -sSourceFile1 -rsashtest.cpp -o %WXWIN%\samples\sashtest\sashtest.dev
gsar -sSourceFile2 -rsashtest.rc -o %WXWIN%\samples\sashtest\sashtest.dev

copy Project4.dev %WXWIN%\3rdparty\samples\scintilla\scintilla.dev
gsar -sProjectName -rscintilla -o %WXWIN%\3rdparty\samples\scintilla\scintilla.dev
gsar -s=-mwindows -r=-lwxmsw27_scintilla_@@_-mwindows -o %WXWIN%\3rdparty\samples\scintilla\scintilla.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\3rdparty\samples\scintilla\scintilla.dev
gsar -sSourceFile1 -redit.cpp -o %WXWIN%\3rdparty\samples\scintilla\scintilla.dev
gsar -sSourceFile2 -rprefs.cpp -o %WXWIN%\3rdparty\samples\scintilla\scintilla.dev
gsar -sSourceFile3 -rtest.cpp -o %WXWIN%\3rdparty\samples\scintilla\scintilla.dev
gsar -sSourceFile4 -rtest.rc -o %WXWIN%\3rdparty\samples\scintilla\scintilla.dev

copy Project2.dev %WXWIN%\samples\scroll\scroll.dev
gsar -sProjectName -rscroll -o %WXWIN%\samples\scroll\scroll.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\scroll\scroll.dev
gsar -sSourceFile1 -rscroll.cpp -o %WXWIN%\samples\scroll\scroll.dev
gsar -sSourceFile2 -rscroll.rc -o %WXWIN%\samples\scroll\scroll.dev

copy Project2.dev %WXWIN%\samples\scrollsub\scrollsub.dev
gsar -sProjectName -rscrollsub -o %WXWIN%\samples\scrollsub\scrollsub.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\scrollsub\scrollsub.dev
gsar -sSourceFile1 -rscrollsub.cpp -o %WXWIN%\samples\scrollsub\scrollsub.dev
gsar -sSourceFile2 -rscrollsub.rc -o %WXWIN%\samples\scrollsub\scrollsub.dev

copy Project2.dev %WXWIN%\samples\shaped\shaped.dev
gsar -sProjectName -rshaped -o %WXWIN%\samples\shaped\shaped.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\shaped\shaped.dev
gsar -sSourceFile1 -rshaped.cpp -o %WXWIN%\samples\shaped\shaped.dev
gsar -sSourceFile2 -rshaped.rc -o %WXWIN%\samples\shaped\shaped.dev

copy Project2.dev %WXWIN%\3rdparty\samples\sheet\sheetdemo.dev
gsar -sProjectName -rsheetdemo -o %WXWIN%\3rdparty\samples\sheet\sheetdemo.dev
gsar -s=-mwindows -r=-lwxmsw27_sheet_@@_-mwindows -o %WXWIN%\3rdparty\samples\sheet\sheetdemo.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\3rdparty\samples\sheet\sheetdemo.dev
gsar -sSourceFile1 -rsheetdemo.cpp -o %WXWIN%\3rdparty\samples\sheet\sheetdemo.dev
gsar -sSourceFile2 -rsheetdemo.rc -o %WXWIN%\3rdparty\samples\sheet\sheetdemo.dev

copy Project2.dev %WXWIN%\samples\sockets\client.dev
gsar -sProjectName -rclient -o %WXWIN%\samples\sockets\client.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\sockets\client.dev
gsar -sSourceFile1 -rclient.cpp -o %WXWIN%\samples\sockets\client.dev
gsar -sSourceFile2 -rclient.rc -o %WXWIN%\samples\sockets\client.dev

copy Project2.dev %WXWIN%\samples\sockets\server.dev
gsar -sProjectName -rserver -o %WXWIN%\samples\sockets\server.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\\html\helpview\helpview.dev
gsar -sSourceFile1 -rserver.cpp -o %WXWIN%\samples\sockets\server.dev
gsar -sSourceFile2 -rserver.rc -o %WXWIN%\samples\sockets\server.dev

copy Project2.dev %WXWIN%\samples\sound\sound.dev
gsar -sProjectName -rsound -o %WXWIN%\samples\sound\sound.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\sockets\server.dev
gsar -sSourceFile1 -rsound.cpp -o %WXWIN%\samples\sound\sound.dev
gsar -sSourceFile2 -rsound.rc -o %WXWIN%\samples\sound\sound.dev

copy Project1.dev %WXWIN%\samples\splash\splash.dev
gsar -sProjectName -rsplash -o %WXWIN%\samples\splash\splash.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\splash\splash.dev
gsar -sSourceFile1 -rsplash.cpp -o %WXWIN%\samples\splash\splash.dev

copy Project2.dev %WXWIN%\samples\splitter\splitter.dev
gsar -sProjectName -rsplitter -o %WXWIN%\samples\splitter\splitter.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\splitter\splitter.dev
gsar -sSourceFile1 -rsplitter.cpp -o %WXWIN%\samples\splitter\splitter.dev
gsar -sSourceFile2 -rsplitter.rc -o %WXWIN%\samples\splitter\splitter.dev

copy Project2.dev %WXWIN%\samples\statbar\statbar.dev
gsar -sProjectName -rstatbar -o %WXWIN%\samples\statbar\statbar.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\statbar\statbar.dev
gsar -sSourceFile1 -rstatbar.cpp -o %WXWIN%\samples\statbar\statbar.dev
gsar -sSourceFile2 -rstatbar.rc -o %WXWIN%\samples\statbar\statbar.dev

copy Project4.dev contrib\%WXWIN%\samples\stc\stc.dev
gsar -sProjectName -rstc -o contrib\%WXWIN%\samples\stc\stc.dev
gsar -s=-mwindows -r=-lwxmsw27_stc_@@_-mwindows -o contrib\%WXWIN%\samples\stc\stc.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\stc\stc.dev
gsar -sSourceFile1 -redit.cpp -o contrib\%WXWIN%\samples\stc\stc.dev
gsar -sSourceFile2 -rprefs.cpp -o contrib\%WXWIN%\samples\stc\stc.dev
gsar -sSourceFile3 -rstctest.cpp -o contrib\%WXWIN%\samples\stc\stc.dev
gsar -sSourceFile4 -rstctest.rc -o contrib\%WXWIN%\samples\stc\stc.dev

copy Project2.dev contrib\%WXWIN%\samples\svg\svg.dev
gsar -ssvg -rchartart -o contrib\%WXWIN%\samples\svg\svg.dev
gsar -s=-mwindows -r=-lwxmsw27_svg_@@_-mwindows -o contrib\%WXWIN%\samples\svg\svg.dev
gsar -sExeOutput=output -rExeOutput= -o contrib\%WXWIN%\samples\svg\svg.dev
gsar -sSourceFile1 -rsvgtest.cpp -o contrib\%WXWIN%\samples\svg\svg.dev
gsar -sSourceFile2 -rsvgtest.rc -o contrib\%WXWIN%\samples\svg\svg.dev

copy Project1.dev %WXWIN%\samples\taskbar\taskbar.dev
gsar -sProjectName -rtaskbar -o %WXWIN%\samples\taskbar\taskbar.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\taskbar\taskbar.dev
gsar -sSourceFile1 -rtbtest.cpp -o %WXWIN%\samples\taskbar\taskbar.dev

copy Project2.dev %WXWIN%\samples\text\text.dev
gsar -sProjectName -rtext -o %WXWIN%\samples\text\text.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\text\text.dev
gsar -sSourceFile1 -rtext.cpp -o %WXWIN%\samples\text\text.dev
gsar -sSourceFile2 -rtext.rc -o %WXWIN%\samples\text\text.dev

copy Project3.dev %WXWIN%\3rdparty\samples\things\filebrws\filebrws.dev
gsar -sProjectName -rfilebrws -o %WXWIN%\3rdparty\samples\things\filebrws\filebrws.dev
gsar -s=-mwindows -r=-lwxmsw27_things_@@_-mwindows -o %WXWIN%\3rdparty\samples\things\filebrws\filebrws.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\3rdparty\samples\things\filebrws\filebrws.dev
gsar -sSourceFile1 -rwxfilebrowser.cpp -o %WXWIN%\3rdparty\samples\things\filebrws\filebrws.dev
gsar -sSourceFile2 -rwxfilebrowser.rc -o %WXWIN%\3rdparty\samples\things\filebrws\filebrws.dev
gsar -sSourceFile3 -r..\..\generic\filedlgg.cpp -o %WXWIN%\3rdparty\samples\things\filebrws\filebrws.dev

copy Project2.dev %WXWIN%\3rdparty\samples\things\things\things.dev
gsar -sProjectName -rthings -o %WXWIN%\3rdparty\samples\things\things\things.dev
gsar -s=-mwindows -r=-lwxmsw27_things_@@_-mwindows -o %WXWIN%\3rdparty\samples\things\things\things.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\3rdparty\samples\things\things\things.dev
gsar -sSourceFile1 -rthingsdemo.cpp -o %WXWIN%\3rdparty\samples\things\things\things.dev
gsar -sSourceFile2 -rthingsdemo.rc -o %WXWIN%\3rdparty\samples\things\things\things.dev

copy Project2.dev %WXWIN%\samples\thread\thread.dev
gsar -sProjectName -rthread -o %WXWIN%\samples\thread\thread.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\thread\thread.dev
gsar -sSourceFile1 -rthread.cpp -o %WXWIN%\samples\thread\thread.dev
gsar -sSourceFile2 -rthread.rc -o %WXWIN%\samples\thread\thread.dev

copy Project2.dev %WXWIN%\samples\toolbar\toolbar.dev
gsar -sProjectName -rtoolbar -o %WXWIN%\samples\toolbar\toolbar.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\toolbar\toolbar.dev
gsar -sSourceFile1 -rtoolbar.cpp -o %WXWIN%\samples\toolbar\toolbar.dev
gsar -sSourceFile2 -rtoolbar.rc -o %WXWIN%\samples\toolbar\toolbar.dev

copy Project1.dev %WXWIN%\samples\treectrl\treectrl.dev
gsar -sProjectName -rtreectrl -o %WXWIN%\samples\treectrl\treectrl.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\treectrl\treectrl.dev
gsar -sSourceFile1 -rtreetest.cpp -o %WXWIN%\samples\treectrl\treectrl.dev

copy Project2.dev %WXWIN%\3rdparty\samples\treelisttest\treelisttest.dev
gsar -sProjectName -rtreelisttest -o %WXWIN%\3rdparty\samples\treelisttest\treelisttest.dev
gsar -s=-mwindows -r=-lwxmsw27_treelistctrl_@@_-mwindows -o %WXWIN%\3rdparty\samples\treelisttest\treelisttest.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\3rdparty\samples\treelisttest\treelisttest.dev
gsar -sSourceFile1 -rtreelisttest.cpp -o %WXWIN%\3rdparty\samples\treelisttest\treelisttest.dev
gsar -sSourceFile2 -rtreelisttest.rc -o %WXWIN%\3rdparty\samples\treelisttest\treelisttest.dev
gsar -s#if:x20defined(__WINDOWS__) -r#if:x20defined(__WINDOWS__):x20&&:x20!defined(__GNUWIN32__) -o %WXWIN%\3rdparty\samples\treelisttest\treelisttest.cpp 

copy Project2.dev %WXWIN%\3rdparty\samples\treemultictrl\treemultictrl.dev
gsar -sProjectName -rtreemultictrl -o %WXWIN%\3rdparty\samples\treemultictrl\treemultictrl.dev
gsar -s=-mwindows -r=-lwxmsw27_treemultictrl_@@_-mwindows -o %WXWIN%\3rdparty\samples\treemultictrl\treemultictrl.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\3rdparty\samples\treemultictrl\treemultictrl.dev
gsar -sSourceFile1 -rmultictrltest.cpp -o %WXWIN%\3rdparty\samples\treemultictrl\treemultictrl.dev
gsar -sSourceFile2 -rmultictrltest.rc -o %WXWIN%\3rdparty\samples\treemultictrl\treemultictrl.dev

copy Project2.dev %WXWIN%\samples\typetest\typetest.dev
gsar -sProjectName -rtypetest -o %WXWIN%\samples\typetest\typetest.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\typetest\typetest.dev
gsar -sSourceFile1 -rtypetest.cpp -o %WXWIN%\samples\typetest\typetest.dev
gsar -sSourceFile2 -rtypetest.rc -o %WXWIN%\samples\typetest\typetest.dev

copy Project1.dev %WXWIN%\samples\validate\validate.dev
gsar -sProjectName -rvalidate -o %WXWIN%\samples\validate\validate.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\validate\validate.dev
gsar -sSourceFile1 -rvalidate.cpp -o %WXWIN%\samples\validate\validate.dev

copy Project1.dev %WXWIN%\samples\vscroll\vscroll.dev
gsar -sProjectName -rvscroll -o %WXWIN%\samples\vscroll\vscroll.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\vscroll\vscroll.dev
gsar -sSourceFile1 -rvstest.cpp -o %WXWIN%\samples\vscroll\vscroll.dev

copy Widgets.dev %WXWIN%\samples\widgets\widgets.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\widgets\widgets.dev

copy Project2.dev %WXWIN%\samples\wizard\wizard.dev
gsar -sProjectName -rwizard -o %WXWIN%\samples\wizard\wizard.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\wizard\wizard.dev
gsar -sSourceFile1 -rwizard.cpp -o %WXWIN%\samples\wizard\wizard.dev
gsar -sSourceFile2 -rwizard.rc -o %WXWIN%\samples\wizard\wizard.dev

copy Project5.dev %WXWIN%\samples\xrc\xrcdemo.dev
gsar -sProjectName -rxrcdemo -o %WXWIN%\samples\xrc\xrcdemo.dev
gsar -sExeOutput=output -rExeOutput= -o %WXWIN%\samples\xrc\xrcdemo.dev
gsar -sSourceFile1 -rmyframe.cpp -o %WXWIN%\samples\xrc\xrcdemo.dev
gsar -sSourceFile2 -rcustclas.cpp -o %WXWIN%\samples\xrc\xrcdemo.dev
gsar -sSourceFile3 -rderivdlg.cpp -o %WXWIN%\samples\xrc\xrcdemo.dev
gsar -sSourceFile4 -rxrcdemo.cpp -o %WXWIN%\samples\xrc\xrcdemo.dev
gsar -sSourceFile5 -rxrcdemo.rc -o %WXWIN%\samples\xrc\xrcdemo.dev
pause
