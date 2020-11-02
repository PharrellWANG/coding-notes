Windows
=======

change priority order of network adapters
-----------------------------------------

.. code-block:: bash

    # print all adapters and their corresponding priorities
    Get-NetIPInterface

    # change priority
    Set-NetIPInterface -InterfaceIndex 21 -InterfaceMetric 10  # lower metric value means higher priority

    # reset to use autometric
    Set-NetIPInterface -InterfaceIndex 21 -AutomaticMetric enabled


ref: https://www.windowscentral.com/how-change-priority-order-network-adapters-windows-10


dumpbin
-------

.. figure:: ../../images/dumpbin.png
    :scale: 60%
    :align: center
    :alt: alternate text
    :figclass: align-center

    dumpbin example output

1. dumpbin is a tool provided by visual studio, it can be used to display information about binary files. ``dumpbin /EXPORTS *.dll`` can display all the exported symbols inside dll.

2. ILT: incremental link table.

ref: https://docs.microsoft.com/en-us/cpp/build/reference/dumpbin-reference?view=vs-2019


How to check SHA256
-------------------

.. code-block:: bash
        
        # syntax
        Get-FileHash <path to file> | Format-List
        # below command will check the sha256 of that exe.
        # e.g. Get-FileHash C:\cygwin64\home\aliwang\downloads\gpg4win-3.1.10.exe | Format-List

Ref: `microsoft docs <https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-filehash?view=powershell-6>`_

Visual Studio Customization
---------------------------

ref: https://stackoverflow.com/questions/22380594/hiding-platform-toolset-in-solution-explorer-for-c-projects

Search a file called ``Microsoft.Cpp.Default.props`` in the computer and open the right one.

For example, in visual studio 2019, it locates at

.. code-block:: bash
    
    C:\Program Files (x86)\Mircosoft Visual Studio\2019\Profesional\MSBuild\Microsoft\VC\v150
    C:\Program Files (x86)\Mircosoft Visual Studio\2019\Profesional\MSBuild\Microsoft\VC\v160

Do modifications as you need:

.. code-block:: bash

    <_PlatformToolsetShortNameFor_v140_xp Condition="'$(_PlatformToolsetShortNameFor_v140_xp)' == 'customized by aliwang at tencent'">Visual Studio 2015 - Windows XP</_PlatformToolsetShortNameFor_v140_xp>
    <!-- <_PlatformToolsetShortNameFor_v140_xp Condition="'$(_PlatformToolsetShortNameFor_v140_xp)' == ''">hahha i added these hah Visual Studio 2015 - Windows XP</_PlatformToolsetShortNameFor_v140_xp> -->

Copy folder recursively and exclude certain files
-------------------------------------------------

``robocopy E:\pharrell\enc\ E:\pharrell\enc-copy\ /E /Z /R:5 /W:5 /TBD /NP /V /XF "rec.yuv" "str.bin"``

Tail equivalent on Windows
--------------------------
To get the last 20 lines, open *Windows PowerShell*:

``Get-Content E:\pharrell\enc\hm\hi\Cactus\encoder_lowdelay_P_main\22\console_output.txt -Wait -Tail 20``

Visual Studio
-------------

`Breakpoints will not currently be hit in visual studio <https://www.codeproject.com/Questions/260627/Breakpoint-will-not-currently-be-hit-No-symbols-lo>`_

Solution: clean solution and build from scratch.

Reverse mouse wheel scroll
--------------------------
`How to reverse mouse wheel scrolling <https://www.windowscentral.com/how-reverse-scrolling-direction-windows-10>`_

How to let Visual Studio Code use cygwin bash in Terminal
---------------------------------------------------------

Add below contents to *settings.json*

    .. code-block:: text
    
        {
            // ref1: https://code.visualstudio.com/docs/editor/integrated-terminal#_configuration
            // ref2: https://stackoverflow.com/questions/46061894/vs-code-cygwin-as-integrated-terminal
            // start bash, not the mintty, or you'll get a new window
            "terminal.integrated.shell.windows": "C:\\cygwin64\\bin\\bash.exe",
            // Use this to keep bash from doing a 'cd ${HOME}'
            "terminal.integrated.env.windows": {
                "CHERE_INVOKING": "1"
            },
            // Make it a login shell
            "terminal.integrated.shellArgs.windows": [
                "-l"
            ],
        }

.. note:: Normally you cannot use comments in json, the json should be all data. But in vscode seems the comment is allowed. 
        The json block above is set to type ``text`` instead of ``json`` in rst source code to avoid sphinx issue a warning 
        of ``WARNING: Could not lex literal_block as "json". Highlighting skipped.``.

Don't know why this would appear when launching cygwin from cmd: ``ANOMALY: meaningless REX prefix used``. 
It also will appear when using cygwin as the default shell in vscode. Seems we can just ignore.


Let cygwin use english
----------------------

https://askubuntu.com/questions/625613/how-can-i-change-the-language-preference-in-bashrc-file


Python on Windows
-----------------

ref: https://stackoverflow.com/questions/647515/how-can-i-find-where-python-is-installed-on-windows

Add python to path, then ``python -m pip --proxy http://127.0.0.1:12639 install doc8`` use this command to install pkgs on pc behind proxy.

Newer versions of Python come with py, the Python Launcher, which is always in the PATH.

Here is how to invoke pip via py:

    .. code-block:: bash

        py -m pip install <packagename>
        # py allows having several versions of Python on the same machine.
        # As an example, here is how to invoke the pip from Python 2.7:
        py -2.7 -m pip install <packagename>

Remove Pylint in VSCode
-----------------------

`Ref from SO: remove pylint for conf.py when using vscode to edit docs using sphinx <https://stackoverflow.com/questions/40626429/visual-studio-code-removing-pylint>`_
