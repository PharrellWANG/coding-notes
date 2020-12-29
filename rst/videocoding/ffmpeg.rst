.. _ffmpeg-notes:



######
FFMPEG
######

.. topic:: Overview

    This page describes some of my ffmpeg notes.


    :Date: |today|
    :Author: **aliwang**


.. contents::
    :depth: 3

Transcoding
###########

Transcode mpeg2 to h264.

.. code-block:: bash

    timeit "ffmpeg -vcodec hevc -i C:\Users\15113\Downloads\7a490124-0-output001.ts -acodec copy -vcodec libx264 C:\Users\15113\Downloads\7a490124-0-output001.h264"``

    start /affinity AA timeit "ffmpeg -vcodec hevc -threads 1 -i input.ts -acodec copy -vcodec libx264 -threads 24 C:\Users\15113\Downloads\out.h264"
    # 1. use cpu core num: 1, 3, 5, 7 ( 0xAA-> 1010 1010 ).
    # 2. dec thread 1, enc thread 24
    # 3. measure elapsed time with timeit.bat in sh.git repo.

webp to jpg
###########

``ffmpeg -i some.webp some.jpg``

NV12 to I420
############
Convert NV12 to yuv420p.

.. code-block:: bash

    ffmpeg -pix_fmt yuv420p -s 176x144 -i carphone_qcif.yuv -pix_fmt nv12 carphone_qcif_nv12.yuv
    # "C:\Program Files\ffmpeg\bin\ffmpeg.exe" -s 1280x720 -pix_fmt nv12 -i "C:\SEQUENCES\witchhunter3\1800frames\nv12_witchhunter3_720p_30fps_8_yuv420p_BusyCanteenWalk.yuv" -pix_fmt yuv420p "C:\SEQUENCES\witchhunter3\1800frames\nv12_witchhunter3_720p_30fps_8_yuv420p_BusyCanteenWalk_i420.yuv"

Convert MP4 to M4A
##################


.. code-block:: bash

        ffmpeg -i input.mp4 -vn -c:a copy output.m4a


Decode Bitstream
################

.. code-block:: bash

    ffmpeg -i bistream.h265 dec.yuv


Merge Audio and Video
#####################

.. code-block:: bash

    e.g.
    ffmpeg -i video.mp4 -i audio.wav -c:v copy -c:a aac -strict experimental output1.mp4
    ffmpeg -i video.mp4 -i audio.mp4 -c:v copy -c:a aac -strict experimental output2.mp4

ref: https://superuser.com/questions/277642/how-to-merge-audio-and-video-file-in-ffmpeg

Record Raw YUV Video using Webcam
#################################

Example Commands
****************

.. code-block:: bash
    
    # Example commands for video recording using webcam from fairyxiao
    # for mac
    ffmpeg -f avfoundation -i 1 -s 3840x2160 -pix_fmt yuv420p -r 30 -t 20 facebook_3840x2160.yuv
    # for windows
    ffmpeg -rtbufsize 1.5G -f dshow -i video="Logitech BRIO" -s 3840x2160 -r 30 -t 20 -pix_fmt yuv420p fairy3_3840x2160_30fps.yuv

Record Video in Ubuntu 18.04LTS
*******************************

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
##########

#. `FFmpeg Wiki: Capture with Webcam <https://trac.ffmpeg.org/wiki/Capture/Webcam>`_
