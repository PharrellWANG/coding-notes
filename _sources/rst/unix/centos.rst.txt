CentOS
======

Check CentOS version
--------------------

``cat /etc/*elease``

Install GCC 10.2
----------------

.. code-block:: bash

    cd /install && curl https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.gz -O
    tar zxvf gcc-10.2*
    
    echo "Installing dependencies..."
    yum -y install gmp-devel mpfr-devel libmpc-devel gcc-c++
    
    build_dir=gcc-10.2.0-build
    mkdir $build_dir && cd $build_dir
    ../gcc-5.4.0/configure --enable-languages=c,c++ --disable-multilib
    make -j$(nproc) && make install