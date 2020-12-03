#!/bin/bash
# PY_PATH_STR="$(which python)"
# echo "${OUTPUT}"
# check if ``venv`` keyword is in string, if yes the virtualenv is activated already, else activate it
# if [[ ${PY_PATH_STR} == *"/venv/"* ]]; then
#     echo "yes, venv activated already"
# else
#     echo "no, activate venv now"
#     source ./venv/bin/activate
#     echo "venv activated"
# fi &&
MSG=$1 &&
if [[ $MSG ]]; then
    echo "Commit message is $MSG"
    git add -A && git commit -m $MSG
else
    echo "No commit message provided, default to ``updates``"
    git add -A && git commit -m 'updates'
fi
