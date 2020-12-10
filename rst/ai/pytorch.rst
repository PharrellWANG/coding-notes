Pytorch
=======

Environment
-----------

Windows
~~~~~~~

check cuda version and cudnn version:

.. code-block:: bat

    :: in windows cmd
    nvidia-smi
    :: you can first use ``find everthing`` to locate cudnn.h 
    type "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v10.0\include\cudnn.h" | findstr CUDNN_MAJOR
    type "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v10.1\include\cudnn.h" | findstr CUDNN_MAJOR
    
    conda config --show channels
    conda config --remove channels xxxxxxx