@echo off
rem 次はうまくいかない可能性がある．
rem rdiff-backup --print-statistics -v 6  d:/DATA/repos t:/back/repos

rem 下記の方式でコピーを作成して，バックアップすることがToroiseSVNのページで推奨されている．
rem svnadmin hotcopy レポジトリ コピー先 --clean-logs
rem 参考URL "http://tortoisesvn.net/docs/nightly/TortoiseSVN_ja/tsvn-repository-backup.html"

rem 別の参考ページ  "http://www.asahi-net.or.jp/~iu9m-tcym/svndoc/svn_backup.html"
rem こちらでは，上記の方法以外が網羅的に示されている．

rem ひとまずコピーをサーバーにそのまま作成してみることとした． ==> キャンセル

rem for /D %%i in (d:\DATA\repos\*.*) do (
rem   echo svnadmin hotcopy %%i t:\back\repos\%%~ni --clean-logs
rem        svnadmin hotcopy %%i t:\back\repos\%%~ni --clean-logs
rem )

rem 具体的な作業はRakefileに移動させたので，rakeを起動するだけとなった．
rem なお，コマンドプロンプトからはrake.batを経由するので，call しないと制御が帰ってこない．
call rake -f Gdrive.rake

pause
