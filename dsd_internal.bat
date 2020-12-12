@echo off

cd "C:\Users\15113\repo\coding-notes"

call conda activate sphinx
@REM where python
@REM python -V

::============================== generate html
pushd %~dp0
REM Command file for Sphinx documentation
if "%SPHINXBUILD%" == "" (
	set SPHINXBUILD=sphinx-build
)
set SOURCEDIR=.
set BUILDDIR=_build
::if "%1" == "" goto help

%SPHINXBUILD% >NUL 2>NUL
if errorlevel 9009 (
	echo.
	echo.The 'sphinx-build' command was not found. Make sure you have Sphinx
	echo.installed, then set the SPHINXBUILD environment variable to point
	echo.to the full path of the 'sphinx-build' executable. Alternatively you
	echo.may add the Sphinx directory to PATH.
	echo.
	echo.If you don't have Sphinx installed, grab it from
	echo.http://sphinx-doc.org/
	rem exit /b 1
)
%SPHINXBUILD% -M html %SOURCEDIR% %BUILDDIR% %SPHINXOPTS% %0%
echo "succeeded, go to end"
goto end

:help
echo "help"
%SPHINXBUILD% -M help %SOURCEDIR% %BUILDDIR% %SPHINXOPTS% %0%

:end
popd
::==============================

@REM ssh -tt devcloud "./get-cgnotes.sh && whoami"
ssh -tt root@devcloud "whoami && pwd && source ~/.bashrc && bash ./get-coding-notes.sh && whoami"

@REM ssh -tt devcloud << EOT
@REM bash ./get-coding-notes-macos.sh
@REM whoami
@REM EOT

pause


