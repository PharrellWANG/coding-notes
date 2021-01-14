.. _git-notes:



###
Git
###

.. topic:: Overview

    This page describes some of my git notes. Git version: ``2.22.0``.


    :Date: |today|
    :Author: **aliwang**


.. contents::
    :depth: 3

Push Repo
#########

Push existing folder:

.. code-block:: bash

    cd existing_folder
    git init
    git remote add origin git@gitlab.com:pharrell/todelete.git
    git add .
    git commit -m "Initial commit"
    git push -u origin master

Push existing git repo:

.. code-block:: bash

    cd existing_repo
    git remote rename origin old-origin
    git remote add origin git@gitlab.com:pharrell/todelete.git
    git push -u origin --all
    git push -u origin --tags

Git Workflow for Feature Branches
#################################

The following is an example workflow for developing on a temporary branch and merging back to the main branch squashing all commits into a single commit.  This assumes you already have a branch named ``branch-xyz`` and have finished the work on that branch.

Step 1: Checkout the feature branch
***********************************

.. code-block:: bash

      git checkout branch-xyz


Step 2: Rebase the branch to the master branch
**********************************************
This will replay all commits on the feature branch on top of the latest code from the master branch.  This makes it look like the feature branch was copied from the master branch and all commits laid on top, even if other commits happened on the master.  This makes merging later on easy.  This assumes that master is up to date with your remote repository.  If not, make sure to do a ``git pull`` on the master branch to bring it up to date.

.. code-block:: bash

      git rebase master

Step 3: Resolve conflicts
*************************
If any conflicts occurred while rebasing, you will need to resolve those conflicts before proceeding.  To resolve the conflicts, open the conflicting files in an editor and update the demarked lines.  You  may need to repeat these steps as necessary until all rebasing has been completed.

.. code-block:: bash

      [update file1 file2 etc]
      git add file1 file2 etc
      git rebase --continue

Step 4: Checkout master
***********************
At this point, the feature branch is up to date with master, so we can checkout master again to get ready to merge.

.. code-block:: bash

      git checkout master

Step 5: Merge the feature branch
********************************
We can now merge the feature branch into master squashing all commits into a single commit.  This allows you to commit early and often on the feature branch and only update the main code base as if only one commit happened keeping a nice and clean history.

.. code-block:: bash

      git merge --squash branch-xyz

Step 6: Commit
**************
At this point you can commit the merged updates.  When you commit, it will give you a prefilled commit message containing all the merged commits.  You can simply delete those lines and create a new line that describes the update or the bug fix.  Optionally, you can choose to push the commits back to the remote repository.

.. code-block:: bash

      git commit
      git push

Step 7: Finish
**************
You are now done.  You can choose to delete the branch, although deleting the branch will remove all the individual logged commits on the branch since they were squashed on the master branch.

Ref
***
`nicholashagen/gist:2855167 <https://gist.github.com/nicholashagen/2855167>`_

Git Submodule
#############

add submodule to main project
*****************************

.. code-block:: bash

         # add to default path, which is the current working dir
         git submodule add <git remote addrress>
         # or if you want it to be added to a different path:
         mkcdir <your-customized-dir> && git submodule add <git remote addrress>


Function `mkcdir <https://unix.stackexchange.com/questions/125385/combined-mkdir-and-cd>`_ will only
work if you have it defined in your ``.bashrc`` or ``.zshrc`` or other scripts
that are functionally equivalent.


``mkcdir`` makes the target directory, cd to that directory after being successfully created.
The definition is:

.. code-block:: bash

      mkcdir ()
      {
         mkdir -p -- "$1" &&
         cd -P -- "$1"
      }


.. tip::

      1. Actions you might want to take after ``git submodule add <...>``:

      After a new submodule has been added, you might want to take a look at the
      **project folder entry** which is essentially the a subdirectory inside
      main project, containing the codebase of the submodule being added.

      .. code-block:: bash

            git status
            # you should see that git takes ``project folder entry`` as
            #     a new ``file`` instead of a ``directory``

            git diff --cached <name-of-project-folder-entry>
            # or if you want a nicer diff output, run below
            git diff --cached --submodule

      2. Actions you might want to take after the previous step:

      .. code-block:: bash

            git commit -am 'Add xxx module'
            # -a means stage deleted and modified files except untracked/new files.
            #     you should see that the mode for ``project folder entry`` is 16000,
            #     which is a special mode in Git that basically means you’re recording
            #     a commit as a directory entry rather than a subdirectory or a file.

            git push origin master
            # finally you push you changes to remote repo.


list existing submodules
************************

Run ``cat .gitmoduels`` from main project root.

Remove a submodule
******************

Run ``. ./rm-git-submodule.sh <path-to-submodule>``, *rm-git-submodule.sh* is defined as:

.. code-block:: bash

      #!/bin/bash
      # according to ``man bash``,
      # ``#`` is a special character, and it expands to the number of positional parameters in decimal.
      if [ $# -ne 1 ]; then # the number of positional parameters passed does not equal to 1
              echo "======================================================="
              echo "Usage: $0 <path-to-submodule>"
              echo "You can obtain <path-to-submodule> by looking at ``.gitmodules``"
              echo "======================================================="
              return
      fi
      PATH_TO_SUBMODULE=$1

      # Delete the relevant sectino from the .gitmodule file
      git config -f .gitmodules --remove-section submodule.$PATH_TO_SUBMODULE
      # stage the .gitmodules changes
      git add .gitmodules

      # delete relevant section from .git/config
      git config -f .git/config --remove-section submodule.$PATH_TO_SUBMODULE # no trailing slash

      # remove the submodule files from the working tree and index
      git rm --cached $PATH_TO_SUBMODULE

      # remove the submodule's .git directory
      rm -rf .git/modules/$PATH_TO_SUBMODULE
      # commit the changes

      git commit -m "removed submodule $PATH_TO_SUBMODULE"

      # delete the now untracked submodule files if needed
      rm -rf $PATH_TO_SUBMODULE
      git push


Clone a project with submodules
*******************************

.. code-block:: bash

      # method 1
      git clone <project_url> && git submodule init && git submodule update
      # method 2
      git clone <project_url> && git submodule update --init --recursive
      # method 3
      git clone --recurse-submodules <project_url>


.. note::

      1. After adding a submodule, the folder of submodule is regarded as ``project folder entry`` by git. It is essentially a subdirectory containing the files of your submodule, but Git sees it as a ``submodule`` and does not track its contents when you are not in that subdirectory. Instead, Git sees it as a particular commit from that repository.

      2. ``project folder entry`` vs ``subdirectory`` vs ``file``: ``160000`` is a special mode in Git that basically means you’re recording a commit as a directory entry rather than a subdirectory or a file.



Working on a project with submodules
************************************

Mode #1 Simply consuming submodules
===================================
The simplest model of using submodules in a project would be if you were
simply consuming a subproject and wanted to get updates from it from time
to time but were not actually modifying anything in your checkout.

Pulling in upstream changes from the submodule remote
-----------------------------------------------------

Method #1: manually fetch and merge in the subdirectory

.. code-block:: bash

         # step 1:
         $ cd <submodule-dir>

         # step 2:
         $ git fetch
         From https://github.com/chaconinc/DbConnector
            c3f01dc..d0354fc  master     -> origin/master

         # step 3:
         # you might want to modify ``origin/master`` to the correct remote name
         $ git merge origin/master
         Updating c3f01dc..d0354fc
         Fast-forward
          scripts/connect.sh | 1 +
          src/db.c           | 1 +
          2 files changed, 2 insertions(+)

         # step 4:
         $ git diff --submodule  # view diff

         # step 5:
         $ git commit -am 'updated <submodule-name>' && git push
         # note that if you commit and push at this point, you will lock the
         #        submodule into having hte new code when other people update

Method #2: an easier way to update the submodule when compared with Method #1.

.. code-block:: bash

         git submodule update --remote <submodule-path> # update only the specified submodule
         # this will by default assume that you want to update the
         #              checkout to the master branch of the submodule repo.

         # if you want to use other branch, e.g. stable branch, do this:
         git config -f .gitmodules submodule.<submodule-name>.branch stable
         git submodule update --remote  # git will try to update all of your submodules with this command.


pulling upstream changes from the project remote
------------------------------------------------

.. code-block:: bash

         git pull && git submodule update --init --recursive

.. todo::

      1. take notes about how to automate the updating process above;

      2. take notes about a special situation that can happen when puling superproject updates.

      refer to https://git-scm.com/book/en/v2/Git-Tools-Submodules


Mode #2 Working on submodules
=============================

.. todo:: add notes for this part


Show Tracked files that are ignored
###################################

.. code-block:: bash

    git config --global alias.showtrackedignored "ls-files -i --exclude-standard"
    git showtrackedignored

ref: https://stackoverflow.com/questions/9320218/how-to-list-files-ignored-by-git-that-are-currently-staged-or-committed


Toggle proxy for git clone
##########################
ref: https://stackoverflow.com/questions/19523903/how-to-temporarily-disable-git-http-proxy

Squash multiple commits into one
################################

https://www.freecodecamp.org/forum/t/how-to-squash-multiple-commits-into-one-with-git-squash/13231

Change Commit Message
#####################

https://gist.github.com/nepsilon/156387acf9e1e72d48fa35c4fabef0b4

Removing the last commit
########################

To remove the last commit from git, you can simply run ``git reset --hard HEAD^``.
If you are removing multiple commits from the top, you can run ``git reset --hard HEAD~2`` to 
remove the last two commits. You can increase the number to remove even more commits.

If you want to "uncommit" the commits, but keep the changes around for reworking, 
remove the "--hard": ``git reset HEAD^`` which will evict the commits from the branch
and from the index, but leave the working tree around.

If you want to save the commits on a new branch name, then 
run ``git branch newbranchname`` before doing the ``git reset``.

Ref: `On undoing, fixing, or removing commits in git <http://sethrobertson.github.io/GitFixUm/fixup.html>`_

Human-Readable git diff
#######################

.. code-block:: bash
   :linenos:

    # installation
    brew install diff-so-fancy

    # configure git to use diff-so-fancy for all diff output
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

    # with two lines below, you can make the diff view scroll with trackpad and page up/down.
    git config --global pager.diff "diff-so-fancy | less --tabs=1,5 -RF"
    git config --global pager.show "diff-so-fancy | less --tabs=1,5 -RF"


**References**

1. `diff-so-fancy github homepage <https://github.com/so-fancy/diff-so-fancy>`_

2. `enabling trackpad scrolling and page up/down when viewing diff <https://github.com/so-fancy/diff-so-fancy/issues/26>`_



git log
#######

.. code-block:: bash

    git log -S"ant -f build.xml" --pretty=format:'%h %an %ad %s'  # search for source code, doesn’t work well
    Git log # show log of commits
    Git log -- file_path # show log of a file

git blame
#########

See https://git-scm.com/docs/git-blame.

.. code-block:: bash

    git blame file-path  # Show what revision and author last modified each line of a file

gitk
####


.. code-block:: bash

    gitk  # view git log of the whole repo
    gitk file-path  # view git log of a single file


Git reset
#########

git reset a single file: ``git checkout -- filename``

git reset all: ``git reset --hard``

View the change history of a file
#################################

.. code-block:: bash

    # view the commit history of the file
    git log -- <file-name.ext>
    # 
    gitk <file-name.ext>


Delete All the Untracted Files
##############################

`SO: How do you delete untracked local files from your current working tree? <https://stackoverflow.com/questions/61212/how-to-remove-local-untracked-files-from-the-current-git-working-tree>`_

In short: 

.. code-block:: bash

    # step 1: show the list of files which will be removed (dry run)
    git clean -n
    # step 2: delete the files from the repo, as well as the untracked directories.
    git clean -df

View diff between two branches
##############################

``git diff branch1..branch2``


Host key verification failed
############################

SO: `Git error: “Host Key Verification Failed” when connecting to remote repository <https://stackoverflow.com/questions/13363553/git-error-host-key-verification-failed-when-connecting-to-remote-repository>`_

``ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts``

You may replace ``github.com`` with your own git server domain name.


Typical git workflow
####################

Use command line to add your project to remote repo
***************************************************

ref: https://help.github.com/articles/adding-an-existing-project-to-github-using-the-command-line/

.. code-block:: bash

        $ git init
        $ git add .
        # Adds the files in the local repository and stages them for commit.
        # To unstage a file, use `git reset HEAD YOUR-FILE`.

        $ git commit -m "First commit"
        # Commits the tracked changes and prepares them to be
        # pushed to a remote repository. To remove this commit and
        # modify the file, use `git reset --soft HEAD~1\` and
        # commit and add the file again.

        # copy remote repository URL https://www.example.com/git/my-project

        $ git remote add origin https://www.example.com/git/my-project
        # Sets the new remote

        $ git remote -v
        # Verifies the new remote URL

        $ git push -u origin master
        # Pushes the changes in your local repository up
        # to the remote repository you specified as origin

        # `-u` here is the simplified version of `--set-upstream`
        # only use it when the first time you push a new branch to remote repo.

After you have added your project to remote repo
************************************************

.. code-block:: bash

    $ git status
    $ git add path/to/file/that/has/been/modified
    # or add all that have been modified
    $ git add .
    $ git commit -m 'file been modified'
    $ git push
    $ git status
    $ git pull

    $ git stash
    $ git stash show
    $ git stash list
    $ git stash apply


Rename branch
#############
1. if you are on the branch you want to rename: ``git branch -m new-name``, if you are on a different branch: `` git branch -m old-name new-name``
2. Delete the old-name remote branch and push the new-name local branch, ``git push origin :old-name new-name``
3. Reset the upstream branch for the new-name local branch. Switch to the branch and then: ``git push origin -u new-name``


Remote's URL
############

1. List remote's URL: ``git remote -v``

2. Change remote's URL:

.. code-block:: bash

    # use https
    $ git remote set-url origin https://github.com/USERNAME/REPOSITORY.git

    # use ssh
    $ git remote set-url origin git@github.com:USERNAME/REPOSITORY.git

Difference between `git add -A` and `git add .`
###############################################

1. ``git add -A`` stages **all**, including modified, new (i.e. untracked), deleted, in other words, all files in the entire working tree are updated.
2. ``git add .`` stages new (i.e. untracked), modified, without **deleted**
3. ``git add -a`` stages modified and deleted, without **new (i.e. untracked)**

The important point about ``git add .`` is that it looks at the working tree and adds all those paths to the staged changes if they are either changed or are new and not ignored, it does not stage any 'rm' actions.

``git add -u`` looks at all the already tracked files and stages the changes to those files if they are different or if they have been removed. It does not add any new file, it only stages changes to already tracked files.

git add -A is a handy shortcut for doing both of those.

You can test the differences out with something like this (note that for Git version 2.x your output for git add . git status will be different):

.. code-block:: bash

    git init
    echo Change me > change-me
    echo Delete me > delete-me
    git add change-me delete-me
    git commit -m initial

    echo OK >> change-me
    rm delete-me
    echo Add me > add-me

    git status
    # Changed but not updated:
    #   modified:   change-me
    #   deleted:    delete-me
    # Untracked files:
    #   add-me

    git add .
    git status

    # Changes to be committed:
    #   new file:   add-me
    #   modified:   change-me
    # Changed but not updated:
    #   deleted:    delete-me

    git reset

    git add -u
    git status

    # Changes to be committed:
    #   modified:   change-me
    #   deleted:    delete-me
    # Untracked files:
    #   add-me

    git reset

    git add -A
    git status

    # Changes to be committed:
    #   new file:   add-me
    #   modified:   change-me
    #   deleted:    delete-me


How to ignore all present untracked files
#########################################

Q: Is there a handy way to ignore all untracked files and folders in a git repository?

A: If you want to permanently ignore these files, a simple way to add them to .gitignore is

``git ls-files --others --exclude-standard >> .gitignore``

How to remove a folder from git tracking
########################################

Remove a folder from git repo without deleting it from my local machine:
``step1`` Add the folder path to your repo's root ``.gitignore`` file

.. code-block:: bash

    path_to_your_folder/

``step2`` Remove the folder from your local git tracking, but keep it on your disk. (``.gitignore`` will prevent untracked files from being added (without an add -f) to the set of files tracked by git, however git will continue to track any files that are already being tracked.) To stop tracking a file you need to remove it from the index. This can be achieved with this command.

.. code-block:: bash

    $ git rm -rf --cached path_to_your_folder/or_path_to_your_file

``step3`` Push your changes to your git repo.

.. code-block:: bash

    $ git commit -m "remove xyz file"


.. note:: The folder will be considered "deleted" from Git's point of view(i.e. they are in the past history, but not in the latest commit, and people pulling from this repo will get the files removed from their trees), but stay on your working directory because you've used --cached.



How to merge dev branch with master
###################################

switching branches to merge
***************************

.. code-block:: bash

    # (on ``dev`` branch)
    $ git merge master
    # (resolve any conflicts if there are any)
    $ git checkout master
    $ git merge dev
    # (there won't be any conflicts now)

.. tip:: If you want to keep track of who did the merge and when, you can use ``--no-ff`` flag while merging to do so. ``$ git merge --no-ff dev-branch-001``

[Preferred] no branch switching
*******************************

.. code-block:: bash

    $ git fetch origin master
    $ git merge master
    $ git push origin dev:master
    # `dev` is the name of current branch

How to create a tag
###################

Annotated Tags
**************

.. code-block:: bash

    $ git tag -a v1.0.3 -m 'my version v1.0.3'
    # notice that do not use double quota here, otherwise it will have error of too many params
    $ git tag
    v1.0.1
    v1.0.2
    v1.0.3
    $ git show v1.0.3



Lightweight Tags
****************

.. code-block:: bash

    $ git tag v1.0.3


How to show tag info
####################

.. code-block:: bash

    $ git show v1.0.3

How to list all tags
####################

1. local: ``git tag``

2. remote: ``git ls-remote --tags origin``

How to push tag
###############

1. push particular tag: ``git push v1.0.3``

2. push all tags: ``git push --tags``

How to delete tag
#################

1. delete remote tag: ``git push --delete origin tagname``

2. delete local tag: ``git tag --delete tagname``


How to checkout a tag
#####################

``git clone`` will give you the whole repository.

After clone you can list the tags with ``$ git tag -l`` and then checkout a specific tag:

.. code-block:: bash

    $ git checkout tags/<tag_name>

Even better, checkout and create a branch (otherwise you will be on a branch named after the revision number of tag):

.. code-block:: bash

    $ git checkout tags/<tag_name> -b <branch_name>



Other useful directives
#######################

.. code-block:: bash

    $ git ls-files
    $ git fetch
    $ git pull
    $ git stash
    $ git stash drop
    $ git stash apply

How to do the initial commit
############################

.. code-block:: bash

    $ rm -rf .git
    # optional
    $ git init
    $ git add . && git commit -m 'init'

How to resolve git conflicts
############################

Reference: `How to resolve a merge conflict using the command line <https://help.github.com/articles/resolving-a-merge-conflict-using-the-command-line/>`_.

About git config files
######################
Reference:

1. `git-scm.com/docs/git-config#FILES <https://git-scm.com/docs/git-config#FILES>`_.
2. `XDG Base Directory Specification <https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html>`_.

.. note:: About ``echo $XDG_CONFIG_HOME``.

        1. Basics: There is a single base directory relative to which user-specific
        configuration files should be written. This directory is defined by
        the environment variable ``$XDG_CONFIG_HOME``.

        2. Environment variables: ``$XDG_CONFIG_HOME`` defines the base
        directory relative to which user specific configuration files
        should be stored. If ``$XDG_CONFIG_HOME`` is either not set or
        empty, a default equal to ``$HOME/.config`` should be used.


Typically four git config files:

1. ``$/etc/gitconfig`` system-wide configuration file

2. ``$XDG_CONFIG_HOME/git/config`` second user-specific configuration file. If ``$XDG_CONFIG_HOME`` is not set or empty, ``$HOME/.config/git/config`` will be used. Any single-valued variable set in this file will be overwritten by whatever is in ``~/.gitconfig``. t is a good idea not to create this file if you sometimes use older versions of Git, as support for this file was added fairly recently.

3. ``~/.gitconfig`` User-specific configuration file. Also called **global** configuration file.

4. ``$GIT_DIR/config`` Repository specific configuration file.

The files are read in the order given above, with last value found
taking precedence over values read earlier.


you can also find/edit those configuration files running the commands:

.. code-block:: bash

    $ git config --global -e
    $ git config --system -e
    $ git config --local -e

Setup username and email:

.. code-block:: bash

    $ git config --global user.name "Pharrell_zx"
    $ git config --global user.email wzxnuaa@gmail.com


ssh-add
#######

`Could not open a connection to your authentication agent <https://stackoverflow.com/questions/17846529/could-not-open-a-connection-to-your-authentication-agent>`_

If you cannot successfully perform ``ssh-add``, you can do this:

.. code-block:: bash

    $ eval `ssh-agent -s`
    $ ssh-add

You can add below scripts to the end of ``/root/.bashrc`` file to
automatically load ``ssh-agent``:

.. code-block:: bash

    eval $(ssh-agent) > /tmp/tmp.txt
    echo ======== for bitbucket pull/push without password =========
    ssh-add /root/.ssh/zwap_prod_root_2 > /tmp/tmp1.txt
    echo ======== for bitbucket pull/push without password =========


Detached HEAD
#############

Reference: https://www.git-tower.com/learn/git/faq/detached-head-when-checkout-commit

Understand how checkout works
#############################

Normally, you use a branch name to communicate with "git checkout":

.. code-block:: bash

        $ git checkout development

However, you can also provide the SHA1 hash of a specific commit instead:

.. code-block:: bash

        $ git checkout 56a4e5c08
        Note: checking out `56a4e5c08`.

        You are in 'detached HEAD' state...

This exact state - when a specific commit is checked out
instead of a branch - is what's called a "detached HEAD".

The problem with detached HEAD
##############################

The **HEAD** pointer in Git determines your current working revision
(and thereby the files that are placed in your project's working directory).

.. note:: Normally, when checking out a proper branch name, Git automatically moves the HEAD pointer along when you create a new commit. You are automatically on the newest commit of the chosen branch.
        When you instead choose to check out a commit hash, Git won't do this for you. The consequence is that when you make changes and commit them, these changes do NOT belong to any branch.
        This means they can easily get lost once you check out a different revision or branch: not being recorded in the context of a branch, you lack the possibility to access that state easily (unless you have a brilliant memory and can remember the commit hash of that new commit...).

If you want to go back in time to try out an older version of your project
##########################################################################
Remember how simple and cheap the whole concept of branching is in Git:
you can simply create a (temporary) branch and delete it once you're done.

.. code-block:: bash

        $ git checkout -b test-branch 56a4e5c08

        ...do your thing...

        $ git checkout master
        $ git branch -d test-branch


Part of the References:

:git-cheat-sheet: https://github.com/arslanbilal/git-cheat-sheet/blob/master/README.md
:git forget a file: https://stackoverflow.com/questions/1274057/how-to-make-git-forget-about-a-file-that-was-tracked-but-is-now-in-gitignore


Delete branch
#############

local
*****

To delete the local branch using one of the following:

.. code-block:: bash

        $ git branch -d branch_name
        $ git branch -D branch_name

.. note:: The ``-d`` option is an alias for ``--delete``, which only deletes
        the branch if it has already been fully merged in its upstream branch.
        You could also use ``-D``, which is an alias for ``--delete --force``,
        which deletes the branch "irrespective of its merged status".
        [Source: ``man git-branch``]

remote
******

To delete a remote branch using

.. code-block:: bash

        $ git push <remote-name> --delete <branch-name>

which might be easier to remember than

.. code-block:: bash

        $ git push <remote-name> :<branch-name>

which was added in `Git v1.5.0 <https://github.com/gitster/git/blob/master/Documentation/RelNotes/1.5.0.txt>`_ "to delete a remote branch or a tag".

Starting from `Git v2.8.0 <https://github.com/git/git/blob/master/Documentation/RelNotes/2.8.0.txt>`_ you can use ``git push`` with the ``-d`` option as an alias for ``--delete``.

Therefore, the version of git you  have installed will dictate whether you need to use the easier or harder syntax.

.. tip:: Use ``$ git --version`` to checkout your git version.
        Most of the time, ``<remote-name>`` would be ``origin``.

One last step
*************

After all the deleting actions, you should
execute ``$ git fetch --all --prune`` on otbher machines to propagate changes.


git checkout
############

``git checkout [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]``

For details see git docs: https://git-scm.com/docs/git-checkout



A few things to note:

start_point
***********

``<start_point>``: the name of a commit at which to start the new branch. Defaults to HEAD.

orphan
******
``--orphan <new_branch>``: create a new *orphan* branch,
named <new_branch>, started from <start_point>, which
defaults to HEAD and switch to it. The first commit made on this new
branch will have no parents and it will be the root of a new
history totally disconnected from all the other branches and commits.

If you want to start a disconnected history that records a set of
paths that is totally different from the one of <start_point>, then
you should clear the index and the working tree right after creating the
orphan branch by running ``git rm -rf .`` from the top level of the working
tree. Afterwards you will be ready to prepare your new files, repopulating
the working tree, by copying them from elsewhere, extracting a tarball, etc.

