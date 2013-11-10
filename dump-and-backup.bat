
set REPO_DRIVE=D:
set REPO_DIR=D:\Data\repos
set DUMP_DIR=D:\Data\repos-dump
set EXEC_DRIVE=D:
set EXEC_DIR=D:\DATA


%REPO_DRIVE%
cd %REPO_DIR%

echo Create dumps
for /d %%r in ( * ) do (
  svn dump --quiet --deltas %%r > %DUMP_DIR%\%%r
)


%EXEC_DRIVE%
cd %EXEC_DIR%
rdiff-backup 



