rem copy the project files to their correct locations

copy Project1.dev samples\animate\anitest.dev
C:\gsar -sProjectName -ranitest -o samples\animate\anitest.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\animate\anitest.dev
C:\gsar -sSourceFile1 -ranitest.cpp -o samples\animate\anitest.dev

copy Project3.dev samples\artprov\artprov.dev
C:\gsar -sProjectName -rartprov -o samples\artprov\artprov.dev
C:\gsar -sSourceFile1 -rarttest.cpp -o samples\artprov\artprov.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\artprov\artprov.dev
C:\gsar -sSourceFile2 -rartbrows.cpp -o samples\artprov\artprov.dev
C:\gsar -sSourceFile3 -rarttest.rc -o samples\artprov\artprov.dev

copy Project1.dev samples\aui\aui.dev
C:\gsar -sProjectName -raui -o samples\aui\aui.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\aui\aui.dev
C:\gsar -sSourceFile1 -rauidemo.cpp -o samples\aui\aui.dev

copy Project4.dev demos\bombs\bombs.dev
C:\gsar -sProjectName -rbombs -o demos\bombs\bombs.dev
C:\gsar -sExeOutput=output -rExeOutput= -o demos\bombs\bombs.dev
C:\gsar -sSourceFile1 -rbombs.cpp -o demos\bombs\bombs.dev
C:\gsar -sSourceFile2 -rbombs1.cpp -o demos\bombs\bombs.dev
C:\gsar -sSourceFile3 -rgame.cpp -o demos\bombs\bombs.dev
C:\gsar -sSourceFile4 -rbombs.rc -o demos\bombs\bombs.dev

copy Project2.dev samples\calendar\calendar.dev
C:\gsar -sProjectName -rcalendar -o samples\calendar\calendar.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\calendar\calendar.dev
C:\gsar -sSourceFile1 -rcalendar.cpp -o samples\calendar\calendar.dev
C:\gsar -sSourceFile2 -rcalendar.rc -o samples\calendar\calendar.dev

copy Project2.dev samples\caret\caret.dev
C:\gsar -sProjectName -rcaret -o samples\caret\caret.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\caret\caret.dev
C:\gsar -sSourceFile1 -rcaret.cpp -o samples\caret\caret.dev
C:\gsar -sSourceFile2 -rcaret.rc -o samples\caret\caret.dev

copy Project2.dev 3rdparty\samples\chartart\chartart.dev
C:\gsar -sProjectName -rchartart -o 3rdparty\samples\chartart\chartart.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_chartart_@@_-mwindows -o 3rdparty\samples\chartart\chartart.dev
C:\gsar -sExeOutput=output -rExeOutput= -o 3rdparty\samples\chartart\chartart.dev
C:\gsar -sSourceFile1 -rwxchart.cpp -o 3rdparty\samples\chartart\chartart.dev
C:\gsar -sSourceFile2:x0d:x0aCompileCpp=1 -rSourceFile2 -o 3rdparty\samples\chartart\chartart.dev
C:\gsar -sSourceFile2 -r..\..\..\include\common\3rdparty\wxchart.rc -o 3rdparty\samples\chartart\chartart.dev
C:\gsar -scommon\3rdparty\wxchart.rc:x0d:x0aFolder= -rcommon\3rdparty\wxchart.rc:x0d:x0aFolder=Resources -o 3rdparty\samples\chartart\chartart.dev
C:\gsar -s#pragma:x20interface  -r//#pragma:x20interface  -o 3rdparty\samples\chartart\wxchart.cpp
C:\gsar -s#pragma:x20implementation -r//#pragma:x20implementation -o 3rdparty\samples\chartart\wxchart.cpp

copy Project2.dev samples\checklst\checklst.dev
C:\gsar -sProjectName -rchecklst -o samples\checklst\checklst.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\checklst\checklst.dev
C:\gsar -sSourceFile1 -rchecklst.cpp -o samples\checklst\checklst.dev
C:\gsar -sSourceFile2 -rchecklst.rc -o samples\checklst\checklst.dev

copy Project1.dev samples\combo\combo.dev
C:\gsar -sProjectName -rcombo -o samples\combo\combo.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\combo\combo.dev
C:\gsar -sSourceFile1 -rcombo.cpp -o samples\combo\combo.dev

copy Project2.dev samples\config\conftest.dev
C:\gsar -sProjectName -rconftest -o samples\config\conftest.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\config\conftest.dev
C:\gsar -sSourceFile1 -rconftest.cpp -o samples\config\conftest.dev
C:\gsar -sSourceFile2 -rconftest.rc -o samples\config\conftest.dev

copy Project1.dev samples\console\console.dev
C:\gsar -sProjectName -rconsole -o samples\console\console.dev
C:\gsar -s=-mwindows_@@_ -r= -o samples\console\console.dev
C:\gsar -sWall_@@_ -rWall_@@_-D_CONSOLE _@@_-DwxUSE_GUI=0 _@@_ -o samples\console\console.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\console\console.dev
C:\gsar -sSourceFile1 -rconsole.cpp -o samples\console\console.dev

copy Project2.dev samples\controls\controls.dev
C:\gsar -sProjectName -rcontrols -o samples\controls\controls.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\controls\controls.dev
C:\gsar -sSourceFile1 -rcontrols.cpp -o samples\controls\controls.dev
C:\gsar -sSourceFile2 -rcontrols.rc -o samples\controls\controls.dev

copy Project1.dev samples\dataview\dataview.dev
C:\gsar -sProjectName -rdataview -o samples\dataview\dataview.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\dataview\dataview.dev
C:\gsar -sSourceFile1 -rdataview.cpp -o samples\dataview\dataview.dev

copy Project3.dev samples\db\dbtest.dev
C:\gsar -sProjectName -rdbtest -o samples\db\dbtest.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\db\dbtest.dev
C:\gsar -sSourceFile1 -rdbtest.cpp -o samples\db\dbtest.dev
C:\gsar -sSourceFile2 -rlistdb.cpp -o samples\db\dbtest.dev
C:\gsar -sSourceFile3 -rdbtest.rc -o samples\db\dbtest.dev

copy Project10.dev demos\dbbrowse\dbbrowse.dev
C:\gsar -sProjectName -rdbbrowse -o demos\dbbrowse\dbbrowse.dev
C:\gsar -sExeOutput=output -rExeOutput= -o demos\dbbrowse\dbbrowse.dev
C:\gsar -sSourceFile10 -rdbbrowse.rc -o demos\dbbrowse\dbbrowse.dev
C:\gsar -sSourceFile1 -rbrowsedb.cpp -o demos\dbbrowse\dbbrowse.dev
C:\gsar -sSourceFile2 -rdbbrowse.cpp -o demos\dbbrowse\dbbrowse.dev
C:\gsar -sSourceFile3 -rdbgrid.cpp -o demos\dbbrowse\dbbrowse.dev
C:\gsar -sSourceFile4 -rdbtree.cpp -o demos\dbbrowse\dbbrowse.dev
C:\gsar -sSourceFile5 -rdlguser.cpp -o demos\dbbrowse\dbbrowse.dev
C:\gsar -sSourceFile6 -rdoc.cpp -o demos\dbbrowse\dbbrowse.dev
C:\gsar -sSourceFile7 -rdummy.cpp -o demos\dbbrowse\dbbrowse.dev
C:\gsar -sSourceFile8 -rpgmctrl.cpp -o demos\dbbrowse\dbbrowse.dev
C:\gsar -sSourceFile9 -rtabpgwin.cpp -o demos\dbbrowse\dbbrowse.dev

copy Project1.dev demos\debugrpt\debugrpt.dev
C:\gsar -sProjectName -rdebugrpt -o demos\debugrpt\debugrpt.dev
C:\gsar -sExeOutput=output -rExeOutput= -o demos\debugrpt\debugrpt.dev
C:\gsar -sSourceFile1 -rdebugrpt.cpp -o demos\debugrpt\debugrpt.dev

copy Project2.dev contrib\samples\deprecated\proplist\proplist.dev
C:\gsar -sProjectName -rproplist -o contrib\samples\deprecated\proplist\proplist.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_deprecated_@@_-mwindows -o contrib\samples\deprecated\proplist\proplist.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\deprecated\proplist\proplist.dev
C:\gsar -sSourceFile1 -rproplist.cpp -o contrib\samples\deprecated\proplist\proplist.dev
C:\gsar -sSourceFile2 -rproplist.rc -o contrib\samples\deprecated\proplist\proplist.dev

copy Project2.dev contrib\samples\deprecated\resource\resource.dev
C:\gsar -sProjectName -rresource -o contrib\samples\deprecated\resource\resource.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_deprecated_@@_-mwindows -o contrib\samples\deprecated\resource\resource.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\deprecated\resource\resource.dev
C:\gsar -sSourceFile1 -rresource.cpp -o contrib\samples\deprecated\resource\resource.dev
C:\gsar -sSourceFile2 -rresource.rc -o contrib\samples\deprecated\resource\resource.dev

copy Project2.dev contrib\samples\deprecated\treelay\treelay.dev
C:\gsar -sProjectName -rtreelay -o contrib\samples\deprecated\treelay\treelay.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_deprecated_@@_-mwindows -o contrib\samples\deprecated\treelay\treelay.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\deprecated\treelay\treelay.dev
C:\gsar -sSourceFile1 -rtreelay.cpp -o contrib\samples\deprecated\treelay\treelay.dev
C:\gsar -sSourceFile2 -rtreelay.rc -o contrib\samples\deprecated\treelay\treelay.dev

copy Project6.dev samples\dialogs\dialogs.dev
C:\gsar -sProjectName -rdialogs -o samples\dialogs\dialogs.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\dialogs\dialogs.dev
C:\gsar -sSourceFile1 -rdialogs.cpp -o samples\dialogs\dialogs.dev
C:\gsar -sSourceFile2 -rdialogs.rc -o samples\dialogs\dialogs.dev
C:\gsar -sSourceFile3 -r..\generic\colrdlgg.cpp -o samples\dialogs\dialogs.dev
C:\gsar -sSourceFile4 -r..\generic\dirdlgg.cpp -o samples\dialogs\dialogs.dev
C:\gsar -sSourceFile5 -r..\generic\filedlgg.cpp -o samples\dialogs\dialogs.dev
C:\gsar -sSourceFile6 -r..\generic\fontdlgg.cpp -o samples\dialogs\dialogs.dev

copy Project2.dev samples\dialup\dialup.dev
C:\gsar -sProjectName -rdialup -o samples\dialup\dialup.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\dialup\dialup.dev
C:\gsar -sSourceFile1 -rnettest.cpp -o samples\dialup\dialup.dev
C:\gsar -sSourceFile2 -rnettest.rc -o samples\dialup\dialup.dev

copy Project1.dev samples\display\display.dev
C:\gsar -sProjectName -rdisplay -o samples\display\display.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\display\display.dev
C:\gsar -sSourceFile1 -rdisplay.cpp -o samples\display\display.dev

copy Project2.dev samples\dnd\dnd.dev
C:\gsar -sProjectName -rdnd -o samples\dnd\dnd.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\dnd\dnd.dev
C:\gsar -sSourceFile1 -rdnd.cpp -o samples\dnd\dnd.dev
C:\gsar -sSourceFile2 -rdnd.rc -o samples\dnd\dnd.dev

copy Project4.dev samples\docview\docview.dev
C:\gsar -sProjectName -rdocview -o samples\docview\docview.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\docview\docview.dev
C:\gsar -sSourceFile1 -rdocview.cpp -o samples\docview\docview.dev
C:\gsar -sSourceFile2 -rdoc.cpp -o samples\docview\docview.dev
C:\gsar -sSourceFile3 -rview.cpp -o samples\docview\docview.dev
C:\gsar -sSourceFile4 -rdocview.rc -o samples\docview\docview.dev

copy Project4.dev samples\docvwmdi\docvwmdi.dev
C:\gsar -sProjectName -rdocvwmdi -o samples\docvwmdi\docvwmdi.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\docvwmdi\docvwmdi.dev
C:\gsar -sSourceFile1 -rdocview.cpp -o samples\docvwmdi\docvwmdi.dev
C:\gsar -sSourceFile2 -rdoc.cpp -o samples\docvwmdi\docvwmdi.dev
C:\gsar -sSourceFile3 -rview.cpp -o samples\docvwmdi\docvwmdi.dev
C:\gsar -sSourceFile4 -rdocview.rc -o samples\docvwmdi\docvwmdi.dev

copy Project2.dev samples\dragimag\dragimag.dev
C:\gsar -sProjectName -rdragimag -o samples\dragimag\dragimag.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\dragimag\dragimag.dev
C:\gsar -sSourceFile1 -rdragimag.cpp -o samples\dragimag\dragimag.dev
C:\gsar -sSourceFile2 -rdragimag.rc -o samples\dragimag\dragimag.dev

copy Project2.dev samples\drawing\drawing.dev
C:\gsar -sProjectName -rdrawing -o samples\drawing\drawing.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\drawing\drawing.dev
C:\gsar -sSourceFile1 -rdrawing.cpp -o samples\drawing\drawing.dev
C:\gsar -sSourceFile2 -rdrawing.rc -o samples\drawing\drawing.dev

copy Project2.dev samples\dynamic\dynamic.dev
C:\gsar -sProjectName -rdynamic -o samples\dynamic\dynamic.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\dynamic\dynamic.dev
C:\gsar -sSourceFile1 -rdynamic.cpp -o samples\dynamic\dynamic.dev
C:\gsar -sSourceFile2 -rdynamic.rc -o samples\dynamic\dynamic.dev

copy Project2.dev samples\erase\erase.dev
C:\gsar -sProjectName -rerase -o samples\erase\erase.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\erase\erase.dev
C:\gsar -sSourceFile1 -rerase.cpp -o samples\erase\erase.dev
C:\gsar -sSourceFile2 -rerase.rc -o samples\erase\erase.dev

copy Project2.dev samples\event\event.dev
C:\gsar -sProjectName -revent -o samples\event\event.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\event\event.dev
C:\gsar -sSourceFile1 -revent.cpp -o samples\event\event.dev
C:\gsar -sSourceFile2 -revent.rc -o samples\event\event.dev

copy Project1.dev samples\except\except.dev
C:\gsar -sProjectName -rexcept -o samples\except\except.dev
C:\gsar -s_@@_-fno-exceptions -r_@@_-fexceptions -o samples\except\except.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\except\except.dev
C:\gsar -sSourceFile1 -rexcept.cpp -o samples\except\except.dev

copy Project2.dev samples\exec\exec.dev
C:\gsar -sProjectName -rexec -o samples\exec\exec.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\exec\exec.dev
C:\gsar -sSourceFile1 -rexec.cpp -o samples\exec\exec.dev
C:\gsar -sSourceFile2 -rexec.rc -o samples\exec\exec.dev

copy Project2.dev contrib\samples\fl\fl_demo1.dev
C:\gsar -sProjectName -rfl_demo1 -o contrib\samples\fl\fl_demo1.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_fl_@@_-mwindows -o contrib\samples\fl\fl_demo1.dev
C:\gsar -sWall_@@_ -rWall_@@_-DBMP_DIR=\\\"./bitmaps/\\\"_@@_ -o contrib\samples\fl\fl_demo1.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\fl\fl_demo1.dev
C:\gsar -sSourceFile1 -rfl_demo1.cpp -o contrib\samples\fl\fl_demo1.dev
C:\gsar -sSourceFile2 -rfl_demo1.rc -o contrib\samples\fl\fl_demo1.dev

copy Project2.dev contrib\samples\fl\fl_demo2.dev
C:\gsar -sProjectName -rfl_demo2 -o contrib\samples\fl\fl_demo2.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_fl_@@_-mwindows -o contrib\samples\fl\fl_demo2.dev
C:\gsar -sWall_@@_ -rWall_@@_-DBMP_DIR=\\\"./bitmaps/\\\"_@@_ -o contrib\samples\fl\fl_demo2.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\fl\fl_demo2.dev
C:\gsar -sSourceFile1 -rfl_demo2.cpp -o contrib\samples\fl\fl_demo2.dev
C:\gsar -sSourceFile2 -rfl_demo2.rc -o contrib\samples\fl\fl_demo2.dev
C:\gsar -sICON:x20:x22mondrian -rICON:x20:x22sample -o contrib\samples\fl\fl_demo2.rc
C:\gsar -s/* -r -o contrib\samples\fl\fl_demo2.rc
C:\gsar -s*/ -r -o contrib\samples\fl\fl_demo2.rc

copy Project2.dev contrib\samples\fl\fl_sample1.dev
C:\gsar -sProjectName -rfl_sample1 -o contrib\samples\fl\fl_sample1.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_fl_@@_-mwindows -o contrib\samples\fl\fl_sample1.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\\html\helpview\helpview.dev
C:\gsar -sSourceFile1 -rfl_sample1.cpp -o contrib\samples\fl\fl_sample1.dev
C:\gsar -sSourceFile2 -rfl_sample1.rc -o contrib\samples\fl\fl_sample1.dev

copy Project2.dev contrib\samples\fl\fl_sample2.dev
C:\gsar -sProjectName -rfl_sample2 -o contrib\samples\fl\fl_sample2.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_fl_@@_-mwindows -o contrib\samples\fl\fl_sample2.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\fl\fl_sample2.dev
C:\gsar -sSourceFile1 -rfl_sample2.cpp -o contrib\samples\fl\fl_sample2.dev
C:\gsar -sSourceFile2 -rfl_sample2.rc -o contrib\samples\fl\fl_sample2.dev

copy Project2.dev contrib\samples\fl\fl_sample3.dev
C:\gsar -sProjectName -rfl_sample3 -o contrib\samples\fl\fl_sample3.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_fl_@@_-mwindows -o contrib\samples\fl\fl_sample3.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\fl\fl_sample3.dev
C:\gsar -sSourceFile1 -rfl_sample3.cpp -o contrib\samples\fl\fl_sample3.dev
C:\gsar -sSourceFile2 -rfl_sample3.rc -o contrib\samples\fl\fl_sample3.dev

copy Project2.dev contrib\samples\foldbar\extended\extended.dev
C:\gsar -sProjectName -rextended -o contrib\samples\foldbar\extended\extended.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_foldbar_@@_-mwindows -o contrib\samples\foldbar\extended\extended.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\foldbar\extended\extended.dev
C:\gsar -sSourceFile1 -rextended.cpp -o contrib\samples\foldbar\extended\extended.dev
C:\gsar -sSourceFile2 -rextended.rc -o contrib\samples\foldbar\extended\extended.dev

copy Project5.dev contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev
C:\gsar -sProjectName -rfoldpanelbartest -o contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_foldbar_@@_-mwindows -o contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev
C:\gsar -sSourceFile1 -rfoldpanelbartest.cpp -o contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev
C:\gsar -sSourceFile2 -rfoldtestpanel.cpp -o contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev
C:\gsar -sSourceFile3 -rlayouttest.cpp -o contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev
C:\gsar -sSourceFile4 -rtest.cpp -o contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev
C:\gsar -sSourceFile5 -rfoldpanelbartest.rc -o contrib\samples\foldbar\foldpanelbar\foldpanelbartest.dev

copy Project2.dev samples\font\font.dev
C:\gsar -sProjectName -rfont -o samples\font\font.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\font\font.dev
C:\gsar -sSourceFile1 -rfont.cpp -o samples\font\font.dev
C:\gsar -sSourceFile2 -rfont.rc -o samples\font\font.dev

copy Project9.dev demos\forty\forty.dev
C:\gsar -sProjectName -rforty -o demos\forty\forty.dev
C:\gsar -sExeOutput=output -rExeOutput= -o demos\forty\forty.dev
C:\gsar -sSourceFile1 -rcanvas.cpp -o demos\forty\forty.dev
C:\gsar -sSourceFile2 -rforty.cpp -o demos\forty\forty.dev
C:\gsar -sSourceFile3 -rcard.cpp -o demos\forty\forty.dev
C:\gsar -sSourceFile4 -rgame.cpp -o demos\forty\forty.dev
C:\gsar -sSourceFile5 -rpile.cpp -o demos\forty\forty.dev
C:\gsar -sSourceFile6 -rplayerdg.cpp -o demos\forty\forty.dev
C:\gsar -sSourceFile7 -rscoredg.cpp -o demos\forty\forty.dev
C:\gsar -sSourceFile8 -rscorefil.cpp -o demos\forty\forty.dev
C:\gsar -sSourceFile9 -rforty.rc -o demos\forty\forty.dev

copy Project2.dev demos\fractal\fractal.dev
C:\gsar -sProjectName -rfractal -o demos\fractal\fractal.dev
C:\gsar -sExeOutput=output -rExeOutput= -o demos\fractal\fractal.dev
C:\gsar -sSourceFile1 -rfractal.cpp -o demos\fractal\fractal.dev
C:\gsar -sSourceFile2 -rfractal.rc -o demos\fractal\fractal.dev

copy Project1.dev contrib\samples\gizmos\dynsash\dynsash.dev
C:\gsar -sProjectName -rdynsash -o contrib\samples\gizmos\dynsash\dynsash.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o contrib\samples\gizmos\dynsash\dynsash.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\gizmos\dynsash\dynsash.dev
C:\gsar -sSourceFile1 -rdynsash.cpp -o contrib\samples\gizmos\dynsash\dynsash.dev

copy Project1.dev contrib\samples\gizmos\dynsash_switch\dynsash_switch.dev
C:\gsar -sProjectName -rdynsash_switch -o contrib\samples\gizmos\dynsash_switch\dynsash_switch.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o contrib\samples\gizmos\dynsash_switch\dynsash_switch.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\gizmos\dynsash_switch\dynsash_switch.dev
C:\gsar -sSourceFile1 -rdynsash_switch.cpp -o contrib\samples\gizmos\dynsash_switch\dynsash_switch.dev

copy Project1.dev contrib\samples\gizmos\editlbox\editlbox.dev
C:\gsar -sProjectName -reditlbox -o contrib\samples\gizmos\editlbox\editlbox.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o contrib\samples\gizmos\editlbox\editlbox.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\gizmos\editlbox\editlbox.dev
C:\gsar -sSourceFile1 -rtest.cpp -o contrib\samples\gizmos\editlbox\editlbox.dev

copy Project1.dev contrib\samples\gizmos\led\led.dev
C:\gsar -sProjectName -rled -o contrib\samples\gizmos\led\led.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o contrib\samples\gizmos\led\led.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\gizmos\led\led.dev
C:\gsar -sSourceFile1 -rled.cpp -o contrib\samples\gizmos\led\led.dev

copy Project1.dev contrib\samples\gizmos\multicell\multicell.dev
C:\gsar -sProjectName -rmulticell -o contrib\samples\gizmos\multicell\multicell.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o contrib\samples\gizmos\multicell\multicell.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\gizmos\multicell\multicell.dev
C:\gsar -sSourceFile1 -rmtest.cpp -o contrib\samples\gizmos\multicell\multicell.dev

copy Project1.dev contrib\samples\gizmos\splittree\splittree.dev
C:\gsar -sProjectName -rsplittree -o contrib\samples\gizmos\splittree\splittree.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_gizmos_@@_-mwindows -o contrib\samples\gizmos\splittree\splittree.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\gizmos\splittree\splittree.dev
C:\gsar -sSourceFile1 -rtree.cpp -o contrib\samples\gizmos\splittree\splittree.dev
C:\gsar -sSourceFile1 -rtree.cpp -o contrib\samples\gizmos\splittree\splittree.dev
C:\gsar -swxICON_SMALL_CLOSED_FOLDER -r../../art/folder.xpm -o contrib\samples\gizmos\splittree\splittree.dev
C:\gsar -swxICON_SMALL_FILE -r../../art/fileopen.xpm contrib\samples\gizmos\splittree\splittree.dev

copy Project2.dev samples\grid\grid.dev
C:\gsar -sProjectName -rgrid -o samples\grid\grid.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\grid\grid.dev
C:\gsar -sSourceFile1 -rgriddemo.cpp -o samples\grid\grid.dev
C:\gsar -sSourceFile2 -rgriddemo.rc -o samples\grid\grid.dev

copy Project2.dev samples\help\help.dev
C:\gsar -sProjectName -rhelp -o samples\help\help.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\help\help.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\\html\helpview\helpview.dev
C:\gsar -sSourceFile1 -rdemo.cpp -o samples\help\help.dev
C:\gsar -sSourceFile2 -rdemo.rc -o samples\help\help.dev

copy Project2.dev samples\htlbox\htlbox.dev
C:\gsar -sProjectName -rhtlbox -o samples\htlbox\htlbox.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\help\help.dev
C:\gsar -sSourceFile1 -rhtlbox.cpp -o samples\htlbox\htlbox.dev
C:\gsar -sSourceFile2 -rhtlbox.rc -o samples\htlbox\htlbox.dev

copy Project2.dev samples\html\about\about.dev
C:\gsar -sProjectName -rabout -o samples\html\about\about.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\html\about\about.dev
C:\gsar -sSourceFile1 -rabout.cpp -o samples\html\about\about.dev
C:\gsar -sSourceFile2 -rabout.rc -o samples\html\about\about.dev

copy Project2.dev samples\html\help\help.dev
C:\gsar -sProjectName -rhelp -o samples\html\help\help.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\html\help\help.dev
C:\gsar -sSourceFile1 -rhelp.cpp -o samples\html\help\help.dev
C:\gsar -sSourceFile2 -rhelp.rc -o samples\html\help\help.dev

copy Project2.dev samples\html\helpview\helpview.dev
C:\gsar -sProjectName -rhelpview -o samples\html\helpview\helpview.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\html\helpview\helpview.dev
C:\gsar -sSourceFile1 -rhelpview.cpp -o samples\html\helpview\helpview.dev
C:\gsar -sSourceFile2 -rhelpview.rc -o samples\html\helpview\helpview.dev

copy Project2.dev samples\html\printing\printing.dev
C:\gsar -sProjectName -rprinting -o samples\html\printing\printing.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\html\printing\printing.dev
C:\gsar -sSourceFile1 -rprinting.cpp -o samples\html\printing\printing.dev
C:\gsar -sSourceFile2 -rprinting.rc -o samples\html\printing\printing.dev

copy Project2.dev samples\html\test\test.dev
C:\gsar -sProjectName -rtest -o samples\html\test\test.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\html\test\test.dev
C:\gsar -sSourceFile1 -rtest.cpp -o samples\html\test\test.dev
C:\gsar -sSourceFile2 -rtest.rc -o samples\html\test\test.dev

copy Project2.dev samples\html\virtual\virtual.dev
C:\gsar -sProjectName -rvirtual -o samples\html\virtual\virtual.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\html\virtual\virtual.dev
C:\gsar -sSourceFile1 -rvirtual.cpp -o samples\html\virtual\virtual.dev
C:\gsar -sSourceFile2 -rvirtual.rc -o samples\html\virtual\virtual.dev

copy Project2.dev samples\html\widget\widget.dev
C:\gsar -sProjectName -rwidget -o samples\html\widget\widget.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\html\widget\widget.dev
C:\gsar -sSourceFile1 -rwidget.cpp -o samples\html\widget\widget.dev
C:\gsar -sSourceFile2 -rwidget.rc -o samples\html\widget\widget.dev

copy Project2.dev samples\html\zip\zip.dev
C:\gsar -sProjectName -rzip -o samples\html\zip\zip.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\html\zip\zip.dev
C:\gsar -sSourceFile1 -rzip.cpp -o samples\html\zip\zip.dev
C:\gsar -sSourceFile2 -rzip.rc -o samples\html\zip\zip.dev

copy Project1.dev 3rdparty\samples\ifm\ifm.dev
C:\gsar -sProjectName -rifm -o 3rdparty\samples\ifm\ifm.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_ifm_@@_-mwindows -o 3rdparty\samples\ifm\ifm.dev
C:\gsar -sExeOutput=output -rExeOutput= -o 3rdparty\samples\ifm\ifm.dev
C:\gsar -sSourceFile1 -rmain.cpp -o 3rdparty\samples\ifm\ifm.dev

copy Project2.dev samples\image\image.dev
C:\gsar -sProjectName -rimage -o samples\image\image.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\image\image.dev
C:\gsar -sSourceFile1 -rimage.cpp -o samples\image\image.dev
C:\gsar -sSourceFile2 -rimage.rc -o samples\image\image.dev

copy Project2.dev samples\internat\internat.dev
C:\gsar -sProjectName -rinternat -o samples\internat\internat.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\internat\internat.dev
C:\gsar -sSourceFile1 -rinternat.cpp -o samples\internat\internat.dev
C:\gsar -sSourceFile2 -rinternat.rc -o samples\internat\internat.dev

copy Project2.dev samples\ipc\ipcclient.dev
C:\gsar -sProjectName -rclient -o samples\ipc\ipcclient.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\ipc\ipcclient.dev
C:\gsar -sSourceFile1 -rclient.cpp -o samples\ipc\ipcclient.dev
C:\gsar -sSourceFile2 -rclient.rc -o samples\ipc\ipcclient.dev

copy Project2.dev samples\ipc\ipcserver.dev
C:\gsar -sProjectName -rserver -o samples\ipc\ipcserver.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\ipc\ipcserver.dev
C:\gsar -sSourceFile1 -rserver.cpp -o samples\ipc\ipcserver.dev
C:\gsar -sSourceFile2 -rserver.rc -o samples\ipc\ipcserver.dev

copy Project2.dev samples\joytest\joytest.dev
C:\gsar -sProjectName -rjoytest -o samples\joytest\joytest.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\joytest\joytest.dev
C:\gsar -sSourceFile1 -rjoytest.cpp -o samples\joytest\joytest.dev
C:\gsar -sSourceFile2 -rjoytest.rc -o samples\joytest\joytest.dev

copy Project2.dev samples\keyboard\keyboard.dev
C:\gsar -sProjectName -rkeyboard -o samples\keyboard\keyboard.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\keyboard\keyboard.dev
C:\gsar -sSourceFile1 -rkeyboard.cpp -o samples\keyboard\keyboard.dev
C:\gsar -sSourceFile2 -rkeyboard.rc -o samples\keyboard\keyboard.dev

copy Project3.dev samples\layout\layout.dev
C:\gsar -sProjectName -rlayout -o samples\layout\layout.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\layout\layout.dev
C:\gsar -sSourceFile1 -rlayout.cpp -o samples\layout\layout.dev
C:\gsar -sSourceFile2 -rexpt.cpp -o samples\layout\layout.dev
C:\gsar -sSourceFile3 -rlayout.rc -o samples\layout\layout.dev

copy Project5.dev demos\life\life.dev
C:\gsar -sProjectName -rlife -o demos\life\life.dev
C:\gsar -sExeOutput=output -rExeOutput= -o demos\life\life.dev
C:\gsar -sSourceFile1 -rgame.cpp -o demos\life\life.dev
C:\gsar -sSourceFile2 -rdialogs.cpp -o demos\life\life.dev
C:\gsar -sSourceFile3 -rlife.cpp -o demos\life\life.dev
C:\gsar -sSourceFile4 -rreader.cpp -o demos\life\life.dev
C:\gsar -sSourceFile5 -rlife.rc -o demos\life\life.dev

copy Project1.dev samples\listbox\listbox.dev
C:\gsar -sProjectName -rlistbox -o samples\listbox\listbox.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\listbox\listbox.dev
C:\gsar -sSourceFile1 -rlboxtest.cpp -o samples\listbox\listbox.dev

copy Project2.dev samples\listctrl\listctrl.dev
C:\gsar -sProjectName -rlistctrl -o samples\listctrl\listctrl.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\listctrl\listctrl.dev
C:\gsar -sSourceFile1 -rlisttest.cpp -o samples\listctrl\listctrl.dev
C:\gsar -sSourceFile2 -rlisttest.rc -o samples\listctrl\listctrl.dev

copy Project2.dev samples\mdi\mdi.dev
C:\gsar -sProjectName -rmdi -o samples\mdi\mdi.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\mdi\mdi.dev
C:\gsar -sSourceFile1 -rmdi.cpp -o samples\mdi\mdi.dev
C:\gsar -sSourceFile2 -rmdi.rc -o samples\mdi\mdi.dev

copy Project1.dev samples\mediaplayer\mediaplayer.dev
C:\gsar -sProjectName -rmediaplayer -o samples\mediaplayer\mediaplayer.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\mediaplayer\mediaplayer.dev
C:\gsar -sSourceFile1 -rmediaplayer.cpp -o samples\mediaplayer\mediaplayer.dev

copy Project2.dev samples\memcheck\memcheck.dev
C:\gsar -sProjectName -rmemcheck -o samples\memcheck\memcheck.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\memcheck\memcheck.dev
C:\gsar -sSourceFile1 -rmemcheck.cpp -o samples\memcheck\memcheck.dev
C:\gsar -sSourceFile2 -rmemcheck.rc -o samples\memcheck\memcheck.dev

copy Project2.dev samples\menu\menu.dev
C:\gsar -sProjectName -rmenu -o samples\menu\menu.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\menu\menu.dev
C:\gsar -sSourceFile1 -rmenu.cpp -o samples\menu\menu.dev
C:\gsar -sSourceFile2 -rmenu.rc -o samples\menu\menu.dev

copy Project2.dev samples\mfc\mfctest.dev
C:\gsar -sProjectName -rmfctest -o samples\mfc\mfctest.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\mfc\mfctest.dev
C:\gsar -sSourceFile1 -rmfctest.cpp -o samples\mfc\mfctest.dev
C:\gsar -sSourceFile2 -rmfctest.rc -o samples\mfc\mfctest.dev

copy Project2.dev samples\minifram\minifram.dev
C:\gsar -sProjectName -rminifram -o samples\minifram\minifram.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\minifram\minifram.dev
C:\gsar -sSourceFile1 -rminifram.cpp -o samples\minifram\minifram.dev
C:\gsar -sSourceFile2 -rminifram.rc -o samples\minifram\minifram.dev

copy Project2.dev samples\minimal\minimal.dev
C:\gsar -sProjectName -rminimal -o samples\minimal\minimal.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\minimal\minimal.dev
C:\gsar -sSourceFile1 -rminimal.cpp -o samples\minimal\minimal.dev
C:\gsar -sSourceFile2 -rminimal.rc -o samples\minimal\minimal.dev

copy Project3.dev contrib\samples\mmedia\mmedia.dev
C:\gsar -sProjectName -rmmedia -o contrib\samples\mmedia\mmedia.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_mmedia_@@_-mwindows -o contrib\samples\mmedia\mmedia.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\mmedia\mmedia.dev
C:\gsar -sSourceFile1 -rmmboard.cpp -o contrib\samples\mmedia\mmedia.dev
C:\gsar -sSourceFile2 -rmmbman.cpp -o contrib\samples\mmedia\mmedia.dev
C:\gsar -sSourceFile3 -rmmboard.rc -o contrib\samples\mmedia\mmedia.dev

copy Project1.dev samples\mobile\styles\styles.dev
C:\gsar -sProjectName -rstyles -o samples\mobile\styles\styles.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\mobile\styles\styles.dev
C:\gsar -sSourceFile1 -rstyles.cpp -o samples\mobile\styles\styles.dev

copy Project1.dev samples\multimon\multimon.dev
C:\gsar -sProjectName -rmultimon -o samples\multimon\multimon.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\multimon\multimon.dev
C:\gsar -sSourceFile1 -rmultimon_test.cpp -o samples\multimon\multimon.dev

copy Project1.dev samples\mobile\wxedit\wxedit.dev
C:\gsar -sProjectName -rwxedit -o samples\mobile\wxedit\wxedit.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\mobile\wxedit\wxedit.dev
C:\gsar -sSourceFile1 -rwxedit.cpp -o samples\mobile\wxedit\wxedit.dev

copy Project2.dev samples\nativdlg\nativdlg.dev
C:\gsar -sProjectName -rnativdlg -o samples\nativdlg\nativdlg.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\nativdlg\nativdlg.dev
C:\gsar -sSourceFile1 -rnativdlg.cpp -o samples\nativdlg\nativdlg.dev
C:\gsar -sSourceFile2 -rnativdlg.rc -o samples\nativdlg\nativdlg.dev

copy Project1.dev samples\notebook\notebook.dev
C:\gsar -sProjectName -rnotebook -o samples\notebook\notebook.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\notebook\notebook.dev
C:\gsar -sSourceFile1 -rnotebook.cpp -o samples\notebook\notebook.dev

copy Project5.dev contrib\samples\ogl\ogledit\ogledit.dev
C:\gsar -sProjectName -rogledit -o contrib\samples\ogl\ogledit\ogledit.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_ogl_@@_-mwindows -o contrib\samples\ogl\ogledit\ogledit.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\ogl\ogledit\ogledit.dev
C:\gsar -sSourceFile1 -rogledit.cpp -o contrib\samples\ogl\ogledit\ogledit.dev
C:\gsar -sSourceFile2 -rdoc.cpp -o contrib\samples\ogl\ogledit\ogledit.dev
C:\gsar -sSourceFile3 -rpalette.cpp -o contrib\samples\ogl\ogledit\ogledit.dev
C:\gsar -sSourceFile4 -rview.cpp -o contrib\samples\ogl\ogledit\ogledit.dev
C:\gsar -sSourceFile5 -rogledit.rc -o contrib\samples\ogl\ogledit\ogledit.dev

copy Project11.dev contrib\samples\ogl\studio\studio.dev
C:\gsar -sProjectName -rstudio -o contrib\samples\ogl\studio\studio.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_ogl_@@_-mwindows -o contrib\samples\ogl\studio\studio.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\ogl\studio\studio.dev
C:\gsar -sSourceFile10 -rview.cpp -o contrib\samples\ogl\studio\studio.dev
C:\gsar -sSourceFile11 -rstudio.rc -o contrib\samples\ogl\studio\studio.dev
C:\gsar -sSourceFile1 -rcspalette.cpp -o contrib\samples\ogl\studio\studio.dev
C:\gsar -sSourceFile2 -rcsprint.cpp -o contrib\samples\ogl\studio\studio.dev
C:\gsar -sSourceFile3 -rdialogs.cpp -o contrib\samples\ogl\studio\studio.dev
C:\gsar -sSourceFile4 -rdoc.cpp -o contrib\samples\ogl\studio\studio.dev
C:\gsar -sSourceFile5 -rmainfrm.cpp -o contrib\samples\ogl\studio\studio.dev
C:\gsar -sSourceFile6 -rproject.cpp -o contrib\samples\ogl\studio\studio.dev
C:\gsar -sSourceFile7 -rshapes.cpp -o contrib\samples\ogl\studio\studio.dev
C:\gsar -sSourceFile8 -rstudio.cpp -o contrib\samples\ogl\studio\studio.dev
C:\gsar -sSourceFile9 -rsymbols.cpp -o contrib\samples\ogl\studio\studio.dev

copy Project2.dev samples\oleauto\oleauto.dev
C:\gsar -sProjectName -roleauto -o samples\oleauto\oleauto.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\oleauto\oleauto.dev
C:\gsar -sSourceFile1 -roleauto.cpp -o samples\oleauto\oleauto.dev
C:\gsar -sSourceFile2 -roleauto.rc -o samples\oleauto\oleauto.dev

copy Project2.dev samples\opengl\cube\cube.dev
C:\gsar -sProjectName -rcube -o samples\opengl\cube\cube.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\opengl\cube\cube.dev
C:\gsar -sSourceFile1 -rcube.cpp -o samples\opengl\cube\cube.dev
C:\gsar -sSourceFile2 -rcube.rc -o samples\opengl\cube\cube.dev

copy Project1.dev samples\opengl\isosurf\isosurf.dev
C:\gsar -sProjectName -risosurf -o samples\opengl\isosurf\isosurf.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\opengl\isosurf\isosurf.dev
C:\gsar -sSourceFile1 -risosurf.cpp -o samples\opengl\isosurf\isosurf.dev
C:\gsar -sSourceFile2 -risosurf.rc -o samples\opengl\isosurf\isosurf.dev

copy Project4.dev samples\opengl\penguin\penguin.dev
C:\gsar -sProjectName -rpenguin -o samples\opengl\penguin\penguin.dev
C:\gsar -s-lopengl32_@@_ -r-lopengl32_@@_-lglu32_@@_ -o samples\opengl\penguin\penguin.dev
C:\gsar -sCompiler=-fno-rtti_@@_- -rCompiler=- -o samples\opengl\penguin\penguin.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\opengl\penguin\penguin.dev
C:\gsar -sSourceFile1 -rpenguin.cpp -o samples\opengl\penguin\penguin.dev
C:\gsar -sSourceFile2:x0d:x0aCompileCpp=1 -rtrackball.c:x0d:x0aCompileCpp=0 -o samples\opengl\penguin\penguin.dev
C:\gsar -sSourceFile3 -rdxfrenderer.cpp -o samples\opengl\penguin\penguin.dev
C:\gsar -sSourceFile4 -rpenguin.rc -o samples\opengl\penguin\penguin.dev

copy Project2.dev samples\ownerdrw\ownerdrw.dev
C:\gsar -sProjectName -rownerdrw -o samples\ownerdrw\ownerdrw.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\ownerdrw\ownerdrw.dev
C:\gsar -sSourceFile1 -rownerdrw.cpp -o samples\ownerdrw\ownerdrw.dev
C:\gsar -sSourceFile2 -rownerdrw.rc -o samples\ownerdrw\ownerdrw.dev

copy Project2.dev contrib\samples\plot\plot.dev
C:\gsar -sProjectName -rplot -o contrib\samples\plot\plot.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_plot_@@_-mwindows -o contrib\samples\plot\plot.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\plot\plot.dev
C:\gsar -sSourceFile1 -rplot.cpp -o contrib\samples\plot\plot.dev
C:\gsar -sSourceFile2 -rplot.rc -o contrib\samples\plot\plot.dev

copy Project2.dev 3rdparty\samples\plotctrl\plotctrl.dev
C:\gsar -sProjectName -rplotctrl -o 3rdparty\samples\plotctrl\plotctrl.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_plotctrl_@@_-lwxmsw27_things_@@_-mwindows -o 3rdparty\samples\plotctrl\plotctrl.dev
C:\gsar -sExeOutput=output -rExeOutput= -o 3rdparty\samples\plotctrl\plotctrl.dev
C:\gsar -sSourceFile1 -rwxplotctrl.cpp -o 3rdparty\samples\plotctrl\plotctrl.dev
C:\gsar -sSourceFile2 -rwxplotctrl.rc -o 3rdparty\samples\plotctrl\plotctrl.dev

copy Project2.dev samples\png\png.dev
C:\gsar -sProjectName -rpng -o samples\png\png.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\png\png.dev
C:\gsar -sSourceFile1 -rpngdemo.cpp -o samples\png\png.dev
C:\gsar -sSourceFile2 -rpngdemo.rc -o samples\png\png.dev

copy Project2.dev demos\poem\poem.dev
C:\gsar -sProjectName -rpoem -o demos\poem\poem.dev
C:\gsar -sExeOutput=output -rExeOutput= -o demos\poem\poem.dev
C:\gsar -sSourceFile1 -rwxpoem.cpp -o demos\poem\poem.dev
C:\gsar -sSourceFile2 -rwxpoem.rc -o demos\poem\poem.dev

copy Project1.dev samples\popup\popup.dev
C:\gsar -sProjectName -rpopup -o samples\popup\popup.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\popup\popup.dev
C:\gsar -sSourceFile1 -rpopup.cpp -o samples\popup\popup.dev

copy Project1.dev samples\power\power.dev
C:\gsar -sProjectName -rpower -o samples\power\power.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\power\power.dev
C:\gsar -sSourceFile1 -rpower.cpp -o samples\power\power.dev

copy Project2.dev samples\printing\printing.dev
C:\gsar -sProjectName -rprinting -o samples\printing\printing.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\printing\printing.dev
C:\gsar -sSourceFile1 -rprinting.cpp -o samples\printing\printing.dev
C:\gsar -sSourceFile2 -rprinting.rc -o samples\printing\printing.dev

copy Project2.dev 3rdparty\samples\propgrid\propgrid.dev
C:\gsar -sProjectName -rpropgrid -o 3rdparty\samples\propgrid\propgrid.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_propgrid_@@_-mwindows -o 3rdparty\samples\propgrid\propgrid.dev
C:\gsar -sExeOutput=output -rExeOutput= -o 3rdparty\samples\propgrid\propgrid.dev
C:\gsar -sSourceFile1 -rpropgridsample.cpp -o 3rdparty\samples\propgrid\propgrid.dev
C:\gsar -sSourceFile2 -rsampleprops.cpp -o 3rdparty\samples\propgrid\propgrid.dev

copy Project2.dev samples\propsize\propsize.dev
C:\gsar -sProjectName -rpropsize -o samples\propsize\propsize.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\propsize\propsize.dev
C:\gsar -sSourceFile1 -rpropsize.cpp -o samples\propsize\propsize.dev
C:\gsar -sSourceFile2 -rpropsize.rc -o samples\propsize\propsize.dev

copy Project2.dev samples\regtest\regtest.dev
C:\gsar -sProjectName -rregtest -o samples\regtest\regtest.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\regtest\regtest.dev
C:\gsar -sSourceFile1 -rregtest.cpp -o samples\regtest\regtest.dev
C:\gsar -sSourceFile2 -rregtest.rc -o samples\regtest\regtest.dev

rem copy Project1.dev samples\render\renddll.dev
rem C:\gsar -sProjectName -rrenddll -o samples\render\renddll.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\render\renddll.dev
rem C:\gsar -sSourceFile1 -rrenddll.cpp -o samples\render\renddll.dev

rem copy Project1.dev samples\render\render.dev
rem C:\gsar -sProjectName -rrender -o samples\render\render.dev
rem C:\gsar -sExeOutput=output -rExeOutput= -o samples\render\render.dev
rem C:\gsar -sSourceFile1 -rrender.cpp -o samples\render\render.dev

copy Project1.dev samples\richtext\richtext.dev
C:\gsar -sProjectName -rrichtext -o samples\richtext\richtext.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\richtext\richtext.dev
C:\gsar -sSourceFile1 -rrichtext.cpp -o samples\richtext\richtext.dev

copy Project2.dev samples\rotate\rotate.dev
C:\gsar -sProjectName -rrotate -o samples\rotate\rotate.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\rotate\rotate.dev
C:\gsar -sSourceFile1 -rrotate.cpp -o samples\rotate\rotate.dev
C:\gsar -sSourceFile2 -rrotate.rc -o samples\rotate\rotate.dev

copy Project2.dev samples\sashtest\sashtest.dev
C:\gsar -sProjectName -rsashtest -o samples\sashtest\sashtest.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\sashtest\sashtest.dev
C:\gsar -sSourceFile1 -rsashtest.cpp -o samples\sashtest\sashtest.dev
C:\gsar -sSourceFile2 -rsashtest.rc -o samples\sashtest\sashtest.dev

copy Project4.dev 3rdparty\samples\scintilla\scintilla.dev
C:\gsar -sProjectName -rscintilla -o 3rdparty\samples\scintilla\scintilla.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_scintilla_@@_-mwindows -o 3rdparty\samples\scintilla\scintilla.dev
C:\gsar -sExeOutput=output -rExeOutput= -o 3rdparty\samples\scintilla\scintilla.dev
C:\gsar -sSourceFile1 -redit.cpp -o 3rdparty\samples\scintilla\scintilla.dev
C:\gsar -sSourceFile2 -rprefs.cpp -o 3rdparty\samples\scintilla\scintilla.dev
C:\gsar -sSourceFile3 -rtest.cpp -o 3rdparty\samples\scintilla\scintilla.dev
C:\gsar -sSourceFile4 -rtest.rc -o 3rdparty\samples\scintilla\scintilla.dev

copy Project2.dev samples\scroll\scroll.dev
C:\gsar -sProjectName -rscroll -o samples\scroll\scroll.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\scroll\scroll.dev
C:\gsar -sSourceFile1 -rscroll.cpp -o samples\scroll\scroll.dev
C:\gsar -sSourceFile2 -rscroll.rc -o samples\scroll\scroll.dev

copy Project2.dev samples\scrollsub\scrollsub.dev
C:\gsar -sProjectName -rscrollsub -o samples\scrollsub\scrollsub.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\scrollsub\scrollsub.dev
C:\gsar -sSourceFile1 -rscrollsub.cpp -o samples\scrollsub\scrollsub.dev
C:\gsar -sSourceFile2 -rscrollsub.rc -o samples\scrollsub\scrollsub.dev

copy Project2.dev samples\shaped\shaped.dev
C:\gsar -sProjectName -rshaped -o samples\shaped\shaped.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\shaped\shaped.dev
C:\gsar -sSourceFile1 -rshaped.cpp -o samples\shaped\shaped.dev
C:\gsar -sSourceFile2 -rshaped.rc -o samples\shaped\shaped.dev

copy Project2.dev 3rdparty\samples\sheet\sheetdemo.dev
C:\gsar -sProjectName -rsheetdemo -o 3rdparty\samples\sheet\sheetdemo.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_sheet_@@_-mwindows -o 3rdparty\samples\sheet\sheetdemo.dev
C:\gsar -sExeOutput=output -rExeOutput= -o 3rdparty\samples\sheet\sheetdemo.dev
C:\gsar -sSourceFile1 -rsheetdemo.cpp -o 3rdparty\samples\sheet\sheetdemo.dev
C:\gsar -sSourceFile2 -rsheetdemo.rc -o 3rdparty\samples\sheet\sheetdemo.dev

copy Project2.dev samples\sockets\client.dev
C:\gsar -sProjectName -rclient -o samples\sockets\client.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\sockets\client.dev
C:\gsar -sSourceFile1 -rclient.cpp -o samples\sockets\client.dev
C:\gsar -sSourceFile2 -rclient.rc -o samples\sockets\client.dev

copy Project2.dev samples\sockets\server.dev
C:\gsar -sProjectName -rserver -o samples\sockets\server.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\\html\helpview\helpview.dev
C:\gsar -sSourceFile1 -rserver.cpp -o samples\sockets\server.dev
C:\gsar -sSourceFile2 -rserver.rc -o samples\sockets\server.dev

copy Project2.dev samples\sound\sound.dev
C:\gsar -sProjectName -rsound -o samples\sound\sound.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\sockets\server.dev
C:\gsar -sSourceFile1 -rsound.cpp -o samples\sound\sound.dev
C:\gsar -sSourceFile2 -rsound.rc -o samples\sound\sound.dev

copy Project1.dev samples\splash\splash.dev
C:\gsar -sProjectName -rsplash -o samples\splash\splash.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\splash\splash.dev
C:\gsar -sSourceFile1 -rsplash.cpp -o samples\splash\splash.dev

copy Project2.dev samples\splitter\splitter.dev
C:\gsar -sProjectName -rsplitter -o samples\splitter\splitter.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\splitter\splitter.dev
C:\gsar -sSourceFile1 -rsplitter.cpp -o samples\splitter\splitter.dev
C:\gsar -sSourceFile2 -rsplitter.rc -o samples\splitter\splitter.dev

copy Project2.dev samples\statbar\statbar.dev
C:\gsar -sProjectName -rstatbar -o samples\statbar\statbar.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\statbar\statbar.dev
C:\gsar -sSourceFile1 -rstatbar.cpp -o samples\statbar\statbar.dev
C:\gsar -sSourceFile2 -rstatbar.rc -o samples\statbar\statbar.dev

copy Project4.dev contrib\samples\stc\stc.dev
C:\gsar -sProjectName -rstc -o contrib\samples\stc\stc.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_stc_@@_-mwindows -o contrib\samples\stc\stc.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\stc\stc.dev
C:\gsar -sSourceFile1 -redit.cpp -o contrib\samples\stc\stc.dev
C:\gsar -sSourceFile2 -rprefs.cpp -o contrib\samples\stc\stc.dev
C:\gsar -sSourceFile3 -rstctest.cpp -o contrib\samples\stc\stc.dev
C:\gsar -sSourceFile4 -rstctest.rc -o contrib\samples\stc\stc.dev

copy Project2.dev contrib\samples\svg\svg.dev
C:\gsar -ssvg -rchartart -o contrib\samples\svg\svg.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_svg_@@_-mwindows -o contrib\samples\svg\svg.dev
C:\gsar -sExeOutput=output -rExeOutput= -o contrib\samples\svg\svg.dev
C:\gsar -sSourceFile1 -rsvgtest.cpp -o contrib\samples\svg\svg.dev
C:\gsar -sSourceFile2 -rsvgtest.rc -o contrib\samples\svg\svg.dev

copy Project1.dev samples\taskbar\taskbar.dev
C:\gsar -sProjectName -rtaskbar -o samples\taskbar\taskbar.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\taskbar\taskbar.dev
C:\gsar -sSourceFile1 -rtbtest.cpp -o samples\taskbar\taskbar.dev

copy Project2.dev samples\text\text.dev
C:\gsar -sProjectName -rtext -o samples\text\text.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\text\text.dev
C:\gsar -sSourceFile1 -rtext.cpp -o samples\text\text.dev
C:\gsar -sSourceFile2 -rtext.rc -o samples\text\text.dev

copy Project3.dev 3rdparty\samples\things\filebrws\filebrws.dev
C:\gsar -sProjectName -rfilebrws -o 3rdparty\samples\things\filebrws\filebrws.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_things_@@_-mwindows -o 3rdparty\samples\things\filebrws\filebrws.dev
C:\gsar -sExeOutput=output -rExeOutput= -o 3rdparty\samples\things\filebrws\filebrws.dev
C:\gsar -sSourceFile1 -rwxfilebrowser.cpp -o 3rdparty\samples\things\filebrws\filebrws.dev
C:\gsar -sSourceFile2 -rwxfilebrowser.rc -o 3rdparty\samples\things\filebrws\filebrws.dev
C:\gsar -sSourceFile3 -r..\..\generic\filedlgg.cpp -o 3rdparty\samples\things\filebrws\filebrws.dev

copy Project2.dev 3rdparty\samples\things\things\things.dev
C:\gsar -sProjectName -rthings -o 3rdparty\samples\things\things\things.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_things_@@_-mwindows -o 3rdparty\samples\things\things\things.dev
C:\gsar -sExeOutput=output -rExeOutput= -o 3rdparty\samples\things\things\things.dev
C:\gsar -sSourceFile1 -rthingsdemo.cpp -o 3rdparty\samples\things\things\things.dev
C:\gsar -sSourceFile2 -rthingsdemo.rc -o 3rdparty\samples\things\things\things.dev

copy Project2.dev samples\thread\thread.dev
C:\gsar -sProjectName -rthread -o samples\thread\thread.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\thread\thread.dev
C:\gsar -sSourceFile1 -rthread.cpp -o samples\thread\thread.dev
C:\gsar -sSourceFile2 -rthread.rc -o samples\thread\thread.dev

copy Project2.dev samples\toolbar\toolbar.dev
C:\gsar -sProjectName -rtoolbar -o samples\toolbar\toolbar.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\toolbar\toolbar.dev
C:\gsar -sSourceFile1 -rtoolbar.cpp -o samples\toolbar\toolbar.dev
C:\gsar -sSourceFile2 -rtoolbar.rc -o samples\toolbar\toolbar.dev

copy Project1.dev samples\treectrl\treectrl.dev
C:\gsar -sProjectName -rtreectrl -o samples\treectrl\treectrl.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\treectrl\treectrl.dev
C:\gsar -sSourceFile1 -rtreetest.cpp -o samples\treectrl\treectrl.dev

copy Project2.dev 3rdparty\samples\treelisttest\treelisttest.dev
C:\gsar -sProjectName -rtreelisttest -o 3rdparty\samples\treelisttest\treelisttest.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_treelistctrl_@@_-mwindows -o 3rdparty\samples\treelisttest\treelisttest.dev
C:\gsar -sExeOutput=output -rExeOutput= -o 3rdparty\samples\treelisttest\treelisttest.dev
C:\gsar -sSourceFile1 -rtreelisttest.cpp -o 3rdparty\samples\treelisttest\treelisttest.dev
C:\gsar -sSourceFile2 -rtreelisttest.rc -o 3rdparty\samples\treelisttest\treelisttest.dev
C:\gsar -s#if:x20defined(__WINDOWS__) -r#if:x20defined(__WINDOWS__):x20&&:x20!defined(__GNUWIN32__) -o 3rdparty\samples\treelisttest\treelisttest.cpp 

copy Project2.dev 3rdparty\samples\treemultictrl\treemultictrl.dev
C:\gsar -sProjectName -rtreemultictrl -o 3rdparty\samples\treemultictrl\treemultictrl.dev
C:\gsar -s=-mwindows -r=-lwxmsw27_treemultictrl_@@_-mwindows -o 3rdparty\samples\treemultictrl\treemultictrl.dev
C:\gsar -sExeOutput=output -rExeOutput= -o 3rdparty\samples\treemultictrl\treemultictrl.dev
C:\gsar -sSourceFile1 -rmultictrltest.cpp -o 3rdparty\samples\treemultictrl\treemultictrl.dev
C:\gsar -sSourceFile2 -rmultictrltest.rc -o 3rdparty\samples\treemultictrl\treemultictrl.dev

copy Project2.dev samples\typetest\typetest.dev
C:\gsar -sProjectName -rtypetest -o samples\typetest\typetest.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\typetest\typetest.dev
C:\gsar -sSourceFile1 -rtypetest.cpp -o samples\typetest\typetest.dev
C:\gsar -sSourceFile2 -rtypetest.rc -o samples\typetest\typetest.dev

copy Project1.dev samples\validate\validate.dev
C:\gsar -sProjectName -rvalidate -o samples\validate\validate.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\validate\validate.dev
C:\gsar -sSourceFile1 -rvalidate.cpp -o samples\validate\validate.dev

copy Project1.dev samples\vscroll\vscroll.dev
C:\gsar -sProjectName -rvscroll -o samples\vscroll\vscroll.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\vscroll\vscroll.dev
C:\gsar -sSourceFile1 -rvstest.cpp -o samples\vscroll\vscroll.dev

copy Widgets.dev samples\widgets\widgets.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\widgets\widgets.dev

copy Project2.dev samples\wizard\wizard.dev
C:\gsar -sProjectName -rwizard -o samples\wizard\wizard.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\wizard\wizard.dev
C:\gsar -sSourceFile1 -rwizard.cpp -o samples\wizard\wizard.dev
C:\gsar -sSourceFile2 -rwizard.rc -o samples\wizard\wizard.dev

copy Project5.dev samples\xrc\xrcdemo.dev
C:\gsar -sProjectName -rxrcdemo -o samples\xrc\xrcdemo.dev
C:\gsar -sExeOutput=output -rExeOutput= -o samples\xrc\xrcdemo.dev
C:\gsar -sSourceFile1 -rmyframe.cpp -o samples\xrc\xrcdemo.dev
C:\gsar -sSourceFile2 -rcustclas.cpp -o samples\xrc\xrcdemo.dev
C:\gsar -sSourceFile3 -rderivdlg.cpp -o samples\xrc\xrcdemo.dev
C:\gsar -sSourceFile4 -rxrcdemo.cpp -o samples\xrc\xrcdemo.dev
C:\gsar -sSourceFile5 -rxrcdemo.rc -o samples\xrc\xrcdemo.dev
pause
