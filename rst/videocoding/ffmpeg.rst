ffmpeg
======

Decode Bitstream
----------------

.. code-block:: bash

    ffmpeg -i bistream.h265 dec.yuv


Merge Audio and Video
---------------------

.. code-block:: bash

    e.g.
    ffmpeg -i video.mp4 -i audio.wav -c:v copy -c:a aac -strict experimental output1.mp4
    ffmpeg -i video.mp4 -i audio.mp4 -c:v copy -c:a aac -strict experimental output2.mp4

ref: https://superuser.com/questions/277642/how-to-merge-audio-and-video-file-in-ffmpeg

Record Raw YUV Video using Webcam
---------------------------------

Example Commands
^^^^^^^^^^^^^^^^

.. code-block:: bash
    
    # Example commands for video recording using webcam from fairyxiao
    # for mac
    ffmpeg -f avfoundation -i 1 -s 3840x2160 -pix_fmt yuv420p -r 30 -t 20 facebook_3840x2160.yuv
    # for windows
    ffmpeg -rtbufsize 1.5G -f dshow -i video="Logitech BRIO" -s 3840x2160 -r 30 -t 20 -pix_fmt yuv420p fairy3_3840x2160_30fps.yuv

Record Video in Ubuntu 18.04LTS
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

    # installation of necessary pkg ``video4linux2``, or simply ``v4l2``
    sudo apt install v4l-utils

    # list supported, connected devices
    v4l2-ctl --list-devices

    # list available formats (supported pixel formats, video formats, and frame sizes) for a particular input device:
    v4l2-ctl --list-formats-ext

    # record raw videos
    ffmpeg -f v4l2 -framerate 30 -video_size 1920x1080 -pix_fmt yuyv422 -i /dev/video0 -t 20 aliwang_1920x1080_yuyv422_30fps.yuv
    # note: 
    # 1. here the fps is set to 30, but if it is not supported in availble formats, 
    #       the driver will change it to available one, such as 5 fps. 
    # 2. and you might need to use ffmpeg to transcode yuyv422 to yuv420. 
    # 3. if yuv420 is not supported by your webcam, specifying yuv420 when recoding 
    #       video will make the recorded video problematic.)

    

References
^^^^^^^^^^

#. `FFmpeg Wiki: Capture with Webcam <https://trac.ffmpeg.org/wiki/Capture/Webcam>`_
