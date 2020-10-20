@ECHO OFF

pushd %~dp0

sphinx-autobuild -p 9993 -H localhost . _build_html

popd