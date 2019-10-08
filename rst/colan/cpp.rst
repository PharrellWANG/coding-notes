Cpp
===

This section has some C++ memos.

Multithread Synchronization
---------------------------

refs
^^^^


1. https://www.geeksforgeeks.org/mutex-lock-for-linux-thread-synchronization/
2. https://blog.csdn.net/s_lisheng/article/details/74278765

What is it
^^^^^^^^^^

Thread synchronization is defined as a mechanism which ensures that two or more concurrent processes or threads do not simultaneously execute some particular program segment known as critical section. Processes’ access to critical section is controlled by using synchronization techniques. When one thread starts executing the critical section (serialized segment of the program) the other thread should wait until the first thread finishes. If proper synchronization techniques are not applied, it may cause a race condition where the values of variables may be unpredictable and vary depending on the timings of context switches of the processes or threads.

在程序中使用多线程时，一般很少有多个线程能在其生命期内进行完全独立的操作。更多的情况是一些线程进行某些处理操作，而其他的线程必须对其处理结果进行了解。正常情况下对这种处理结果的了解应当在其处理任务完成后进行。如果不采取适当的措施，其他线程往往会在线程处理任务结束前就去访问处理结果，这就很有可能得到有关处理结果的错误了解。例如，多个线程同时访问同一个全局变量，如果都是读取操作，则不会出现问题。如果一个线程负责改变此变量的值，而其他线程负责同时读取变量内容，则不能保证读取到的数据是经过写线程修改后的。为了确保读线程读取到的是经过修改的变量，就必须在向变量写入数据时禁止其他线程对其的任何访问，直至赋值过程结束后再解除对其他线程的访问限制。这种保证线程能了解其他线程任务处理结束后的处理结果而采取的保护措施即为线程同步。
————————————————
版权声明：本文为CSDN博主「让我思考一下」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/s_lisheng/article/details/74278765
