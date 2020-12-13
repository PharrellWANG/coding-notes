@ECHO OFF

pushd %~dp0

call conda activate sphinx

start cmd /k sphinx-autobuild -p 9993 -H localhost . _build_html

popd