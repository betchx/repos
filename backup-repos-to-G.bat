@echo off
rem ���͂��܂������Ȃ��\��������D
rem rdiff-backup --print-statistics -v 6  d:/DATA/repos t:/back/repos

rem ���L�̕����ŃR�s�[���쐬���āC�o�b�N�A�b�v���邱�Ƃ�ToroiseSVN�̃y�[�W�Ő�������Ă���D
rem svnadmin hotcopy ���|�W�g�� �R�s�[�� --clean-logs
rem �Q�lURL "http://tortoisesvn.net/docs/nightly/TortoiseSVN_ja/tsvn-repository-backup.html"

rem �ʂ̎Q�l�y�[�W  "http://www.asahi-net.or.jp/~iu9m-tcym/svndoc/svn_backup.html"
rem ������ł́C��L�̕��@�ȊO���ԗ��I�Ɏ�����Ă���D

rem �ЂƂ܂��R�s�[���T�[�o�[�ɂ��̂܂܍쐬���Ă݂邱�ƂƂ����D ==> �L�����Z��

rem for /D %%i in (d:\DATA\repos\*.*) do (
rem   echo svnadmin hotcopy %%i t:\back\repos\%%~ni --clean-logs
rem        svnadmin hotcopy %%i t:\back\repos\%%~ni --clean-logs
rem )

rem ��̓I�ȍ�Ƃ�Rakefile�Ɉړ��������̂ŁCrake���N�����邾���ƂȂ����D
rem �Ȃ��C�R�}���h�v�����v�g�����rake.bat���o�R����̂ŁCcall ���Ȃ��Ɛ��䂪�A���Ă��Ȃ��D
call rake -f Gdrive.rake

pause
