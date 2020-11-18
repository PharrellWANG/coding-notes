#!/usr/bin/env bash
source ~/Repos/coding-notes/venv/bin/activate && \
rm -rf _build && make html && \
ssh -tt devcloud << EOT
bash ./get-coding-notes-macos.sh
whoami
EOT

# ssh devcloud /bin/bash << EOT
# echo "These commands will be run on: $( uname -a )\n"
# echo "They are executed by: $( whoami )\n"
# . ./get-cpp-macos.sh
# EOT