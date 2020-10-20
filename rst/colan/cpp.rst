.. _cpp-notes:



###
Cpp
###

.. topic:: Overview

    This page has some cpp notes.


    :Date: |today|
    :Author: **aliwang**


.. contents::
    :depth: 3


Multithread Synchronization
###########################

What
****
Thread synchronization is defined as a mechanism which ensures that two or more concurrent processes or threads do not simultaneously execute some particular program segment known as critical section. Processes’ access to critical section is controlled by using synchronization techniques. When one thread starts executing the critical section (serialized segment of the program) the other thread should wait until the first thread finishes. If proper synchronization techniques are not applied, it may cause a race condition where the values of variables may be unpredictable and vary depending on the timings of context switches of the processes or threads.

Ref
***

1. https://www.geeksforgeeks.org/mutex-lock-for-linux-thread-synchronization/
2. https://blog.csdn.net/s_lisheng/article/details/74278765

Tools
#####

cppcheck
********

`cppcheck homepage <http://cppcheck.sourceforge.net/>`_

Check unused c++ function in visual studio solution
===================================================

In Windows Powershell,

.. code-block:: bash

    cd c:\Users\15113\repo\project_start\hw_codec\windows\dxva2
    cppcheck --project=ffdxva2.sln --enable=style,unusedFunction --output-file=cppcheck-unused-function.txt

The code block above can be saved as a PowerShell Source File, e.g. name it as *cppcheck.ps1*.
Then you can run it from Windows Powershell by first cd to its dir, then type ``.\cppcheck.ps1``
then press *Enter*.


Difference Between C++ and C
############################

Static Keyword
**************

The keyword ``static`` is the major mnechanism in C to enforce information hiding.

C++ enforces information hiding through the namespace language feature and the access control of classes. The use of the keyword static to limit the scope of external variables is deprecated for declaring objects in namespace scope.

const keyword in cxx
####################

const_cast
**********

You are not allowed to const_cast variables that are actually const. This results in undefined behavior.
const_cast is used to remove the const-ness from references and pointers that ultimately refer to something
that is not const.

volatile
**********

const modifier
**************

About function arguments: working with the original data raises the possibility of
inadvertent data corruption.That’s a real problem in **classic C**, but ANSI C and C++’s
``const`` modifier provides a remedy.


`const` in C++ declaration
**************************
`Ref: Why how cpp const <http://duramecho.com/ComputerInformation/WhyHowCppConst.html>`_

`Ref: c-const-correctness-and-pointer-arguments <https://stackoverflow.com/questions/8808167/c-const-correctness-and-pointer-arguments>`_

`Ref: what is the point of const pointer <https://stackoverflow.com/questions/7715371/whats-the-point-of-const-pointer>`_

`Ref: const member functions <https://www.geeksforgeeks.org/const-member-functions-c/>`_

1. `const` applies to whatever is on **its immediate left** (other than if there is *nothing* there in which case it applies to whatever is **its immediate right** ).

2. Of the possible combinations  of pointers and `const`, the constant pointer to a variable is useful for storage that can be changed in value but **not moved in memory** .

3. const functions can be called on any type of object; Non-const functions can only be called by non-const objects.


Top-level cv-qualifier
**********************
In cxx international standard, the notation ``cv`` (or ``cv1``, ``cv2``, etc.)
used in the description of types, represents an arbitrary set of **cv-qualifiers**,
i.e., one of ``const``, ``volatile``, ``{const, volatile}``, or the empty set.

In cxx, a cv-qualifier that applies to the first level of a type is called a top-level
cv-qualifier.

Examples:

#. ``T *const p``, the top-level cv-qualifier is ``const``.

#. ``T const *volatile q``, the top-level cv-qualifier is ``volatile``.

#. ``T const volatile *q``, the top-level cv-qualifier does not exist, and the cv-qualifiers ``const`` and ``volatile`` appear at the second level.

#. ``T *const p``, the top-level cv-qualifier is ``const``.

#. for a type``cv T``, e.g., ``const int``, the top-level cv-qualifiers of that type are those denoted by cv.

#. the type corresponding to the type-id ``const int&`` has NO top-level cv-qualifiers.

#. the type corresponding to the  type-id ``volatile int * const`` has the top-level cv-qualifier const.

#. for a class type C, the type corresponding to the type-id ``void(C::* volatile)(int) const`` has the top-level cv-qualifier volatile.

The signature of a function includes all cv-qualifiers appearing in that
function's parameter types, except for those qualifier appearing at the top-level
of a parameter type:

for example, in ``int f(char const* p);``, the const qualifier is not at the top-level
in the parameter declaration, so it is part of the function's signature.

on the other hand, in ``int f(char * const p);``, the ``const`` is a
top-level cv qualifier, so it is not part of the function's signature.
This function has the same signature as ``int f(char * p);``.

const usage example
*******************

.. code-block:: c++

    const int* const Method3(const int* const&) const;


Rewrite it as the completely equivalent:

.. code-block:: c++

    // ------------------------------------------------
    //
    //  v--#1   v--#2             v--#3   v--#4   v--#5
    int const * const Method3(int const * const&) const;

then read it from right to left:

A ``const`` member function named Method3 that takes a reference to a
``const`` pointer to an ``int const`` (or a ``const int``, if you prefer)
and returns a ``const`` pointer to an ``int const`` (const int).

1. the last const (v-#5) means, this is a const member function of a class,
instead of a freestanding function. And the const member function is not allowed
to modify the object on which it is called. e.g., ``obj.getNum()``, if ``getNum()``
is a const member function, ``obj`` will not be modified when ``getNum`` is called.
const member functions can be called by const object or non-const object, however,
non-const member functions can only be called by non-const object, because they could
modify the object on which they are called. It is recommended to make as many member
functions as const as possible.

2. v--#4 says that the pointer to the left is const (it can not be changed to point
to a different address.)

3. v--#3 says that the int to the left is const (it can not be changed to have a different value)

4. v--#2 says that the pointer to the left is const.

5. v--#1 says that the int to the left is const.

v--#2 const is superfluous, because top-level cv-qualifier on return types of non class
type are ignored.



References
**********

1. https://stackoverflow.com/questions/24676824/where-is-the-definition-of-top-level-cv-qualifiers-in-the-c11-standard

2. http://eel.is/c++draft/basic.type.qualifier

The mutable Keyword
###################

The ``mutable`` keyword is C++ only. It is a storage class specifier, used only on a class data member to make it modifiable even though the member is part of an object declared as const.

About size_t and ptrdiff_t
**************************

1. `A.4 Important Data Types <https://www.gnu.org/software/libc/manual/html_node/Important-Data-Types.html>`_

2. `About size_t and ptrdiff_t <https://www.viva64.com/en/a/0050/>`_

3. `Why do you need a "ptrdiff_t" type, why isn't "size_t" sufficient? <https://news.ycombinator.com/item?id=10080165>`_

std::move and std::forward

Pass vars via ref
*****************
Passing variables via reference was a C Plus Plus addition to C.
`Reference: why how cpp const <http://duramecho.com/ComputerInformation/WhyHowCppConst.html>`_

E.G., the `Subroutine1` function below accepts the parameter passed to it in the default
C & C++ way, which is a copy. Therefore the subroutine can read the value of the variable
passed to it but not alter it because any alterations it makes are only made to the copy and
are lost when the subroutine ends.

.. code-block:: c++

        void Subroutine1(int iParameter1)
        {
            iParameter1 = 96;
        }


The `Subroutine2` function introduces the addition of an `&` to the parameter name in C++,
causes the actual variable itself, rather than a copy, to be used as the parameter in the
subroutine and therefore can be written to thereby passing data back out the subroutine.

.. code-block:: c++

        void Subroutine2(int &iParameter2)
        {
            iParameter2 = 96;
        }

Play with strings
*****************

C uses **array of chars** to represent string while Cpp has a **dedicated String class** for manipulating strings.

Meanwhile, the C-style string method is also available in C++.

Function prototyping
********************

1. In C and ANSI C, function prototyping is optional, while in C++ function prototyping is mandatory.
2. For ``void say_hi()``, in C++, leaving the parentheses empty is the same as using the keyword ``void`` within the parentheses. It means the function has no arguments. While in ANSI C, leaving the parentheses empty means that you are declining to state what the arguments are. That is, it means you're forgoing prototyping the argument list. The C++ equivalent for not identifying the argument list is to use an ellipsis: ``void say_bye(...); // C++ abdication of responsibility``. Normally this use of an ellipsis is needed only for interfacing with C functions having a variable number of arguments, such as ``printf()``.



Review
######

Multithread Synchronization
***************************

refs

1. https://www.geeksforgeeks.org/mutex-lock-for-linux-thread-synchronization/
2. https://blog.csdn.net/s_lisheng/article/details/74278765

What is it

Thread synchronization is defined as a mechanism which ensures that two or more concurrent processes or threads do not simultaneously execute some particular program segment known as critical section. Processes’ access to critical section is controlled by using synchronization techniques. When one thread starts executing the critical section (serialized segment of the program) the other thread should wait until the first thread finishes. If proper synchronization techniques are not applied, it may cause a race condition where the values of variables may be unpredictable and vary depending on the timings of context switches of the processes or threads.

在程序中使用多线程时，一般很少有多个线程能在其生命期内进行完全独立的操作。更多的情况是一些线程进行某些处理操作，而其他的线程必须对其处理结果进行了解。正常情况下对这种处理结果的了解应当在其处理任务完成后进行。如果不采取适当的措施，其他线程往往会在线程处理任务结束前就去访问处理结果，这就很有可能得到有关处理结果的错误了解。例如，多个线程同时访问同一个全局变量，如果都是读取操作，则不会出现问题。如果一个线程负责改变此变量的值，而其他线程负责同时读取变量内容，则不能保证读取到的数据是经过写线程修改后的。为了确保读线程读取到的是经过修改的变量，就必须在向变量写入数据时禁止其他线程对其的任何访问，直至赋值过程结束后再解除对其他线程的访问限制。这种保证线程能了解其他线程任务处理结束后的处理结果而采取的保护措施即为线程同步。
————————————————
版权声明：本文为CSDN博主「让我思考一下」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/s_lisheng/article/details/74278765

Weak Reference
**************

Intent: Maintain a non-owning reference to a shared dynamically allocated object to break circular dependencies.

Description:

The std::weak_ptr type represents a non-owning reference to dynamically allocated object with shared ownership (std::shared_ptr). As they do not contribute to the reference count of the managed object they refer to, the object can be destroyed at any time when all std::shared_ptrs give up ownership. However, a std::weak_ptr can be converted to a std::shared_ptr to provide temporary ownership and safe access to the object.

In the example code, we have two classes: foo on lines 5–14, and bar on lines 16–30. A foo object has shared ownership of a bar (line 13), and bar requires some form of reference back to the foo that owns it. If this back reference were a std::shared_ptr<foo>, it would introduce a circular dependency, making it impossible for either object to be destroyed. If it were a normal reference type (foo&), it risks refering to a deleted object when it attempts to use it, as the lifetime of foo is independent of bar.

The solution is to use a std::weak_ptr<foo>, as on line 33. When bar needs to use foo, it checks if bar still exists by calling lock on the std::weak_ptr to take temporary shared ownership (line 26). If the returned std::shared_ptr is not empty, bar can safely use it to access the foo object (lines 27–29).

.. code-block:: c++

        #include <memory>

        class bar;

        class foo
        {
        public:
          foo(const std::shared_ptr<bar>& b)
            : forward_reference{b}
          { }
        private:
          std::shared_ptr<bar> forward_reference;
        };

        class bar
        {
        public:
          void set_back_reference(const std::weak_ptr<foo>& f)
          {
            this->back_reference = f;
          }
          void do_something()
          {
            std::shared_ptr<foo> shared_back_reference = this->back_reference.lock();
            if (shared_back_reference) {
              // Use *shared_back_reference
            }
          }
        private:
          std::weak_ptr<foo> back_reference;
        };


Diff between vector reserve and resize
**************************************
ref: https://stackoverflow.com/questions/7397768/choice-between-vectorresize-and-vectorreserve

The two functions do vastly different things!

The resize() method (and passing argument to constructor is equivalent to that) will insert or delete appropriate number of elements to the vector to make it given size (it has optional second argument to specify their value). It will affect the size(), iteration will go over all those elements, push_back will insert after them and you can directly access them using the operator[].

The reserve() method only allocates memory, but leaves it uninitialized. It only affects capacity(), but size() will be unchanged. There is no value for the objects, because nothing is added to the vector. If you then insert the elements, no reallocation will happen, because it was done in advance, but that's the only effect.

So it depends on what you want. If you want an array of 1000 default items, use resize(). If you want an array to which you expect to insert 1000 items and want to avoid a couple of allocations, use  reserve().

EDIT: Blastfurnace's comment made me read the question again and realize, that in your case the correct answer is don't preallocate manually. Just keep inserting the elements at the end as you need. The vector will automatically reallocate as needed and will do it more efficiently than the manual way mentioned. The only case where reserve() makes sense is when you have reasonably precise estimate of the total size you'll need easily available in advance.

EDIT2: Ad question edit: If you have initial estimate, then reserve() that estimate. If it turns out to be not enough, just let the vector do it's thing.

Compare C++ Strings
*******************

.. code-block:: c++

        std::string s1, s2;

1. s1 < s2 : A string s1 is smaller than s2 string, if either, length of s1 is shorter than s2 or first mismatched character is smaller.

2. s1 > s2 : A string s1 is greater than s2 string, if either, length of s1 is longer than s2 or first mismatched character is larger.

3. <= and >= have almost same implementation with additional feature of being equal as well.

4. If after comparing lexicographically, both strings are found same, then they are said to be equal.

5. If any of the points from 1 to 3 follows up then, strings are said to be unequal.

End of File Function
********************

``eof()`` is a special function provided by C++. It returns **non-zero**
(meaning ``true``) when there are no more data to be read from anm input
file stream, and zero (meaning ``false``) otherwise.

Rules for using ``eof()``: Always test for the end-of-file condition before
processing data read from an input file stream.

Type size_t
***********

1. An **alias** of one of the fundamental **unsigned integral types**. Or, we can say, ``size_t`` is an unsigned integral type.

2. It is a type able to represent the size of **any** object in **bytes**.

3. ``size_t`` is the type returned by the ``sizeof`` operator and is widely used in
the standard library to represent sizes and counts.

4. It is also used as the return type for ``strcspn``, ``strlen``, ``strspn``
and ``strxfrm`` to return sizes and lengths.

See `Cpp type system <https://en.cppreference.com/w/cpp/language/type>`_ for details about all the types in Cpp.
See also `Fundamental Types <https://docs.microsoft.com/en-us/cpp/cpp/fundamental-types-cpp>`_

.. note::

    **Integral types** are capable of handling whole numbers. **Floating point types** are capable of specifying values that may have fractional parts.

`strcspn <http://www.cplusplus.com/reference/cstring/strcspn/>`_

`strlen <http://www.cplusplus.com/reference/cstring/strlen/>`_

`strspn <http://www.cplusplus.com/reference/cstring/strspn/>`_

`strxfrm <http://www.cplusplus.com/reference/cstring/strxfrm/>`_

ASCII table
***********

https://www.cs.cmu.edu/~pattis/15-1XX/common/handouts/ascii.html

Abs of the max negative integer
*******************************
`Reference absolute value of the max negative integer <https://stackoverflow.com/questions/11243014/why-the-absolute-value-of-the-max-negative-integer-2147483648-is-still-2147483>`_

.. code-block:: c++

    printf("abs(-2147483648): %d\n", abs(-2147483648));
    //output: abs(-2147483648): -2147483648

.. note:: The `abs`, `labs`, and `llabs` functions compute the absolute value of an integer j. If the result cannot be represented, the behavior is undefined.

And the result indeed cannot be represented because the 2's complement representation of signed integers isn't symmetric.
Since 2147483648 is greater than INT_MAX on implementation, then abs(-2147483648) is undefined.

`exit` function
***************
`Reference exit function <https://docs.microsoft.com/en-us/cpp/cpp/exit-function>`_

The `exit` function, declared in the standard include file STDLIB.H, terminates a C++ program.

The value supplied as an argument to exit is returned to the operating system as
the program's return code or exit code. By convention, a return code of zero means
that the program completed successfully.

>You can use the constants `EXIT_FAILURE` and `EXIT_SUCCESS`,
>defined in STDLIB.H, to indicate success or failure of your program.

Issuing a `return` statement from the main function is equivalent to
calling the `exit` function with the return value as its argument.

To destroy an automatic object before you call `exit`, `_Exit`, or `_exit`,
explicitly call the destructor for the object, as shown here:

.. code-block:: c++

        void last_fn() {
            struct SomeClass {} myInstance{};
            // ...
            myInstance.~SomeClass(); // explicit destructor call
            exit(0);
        }

`static` in C++
***************

`Reference static keyword <https://www.cprogramming.com/tutorial/statickeyword.html>`_

The keyword static can be used in three major contexts:

1. inside a function,
    - Meaning: The use of static inside a function is the simplest. It simply means that once the variable has been initialized, it remains in memory until the end of the program.
    - Usage: We can use static variable inside a loop to prevent reinitialization to count how many times this function has been called.

2. inside a class definition, and
    - static **data members** in a class.
        - While most variables declared inside a class occur on an instance-by-instance basis (which is to say that for each instance of a class, the variable can have a different value), a static member variable has the same value in any instance of the class and does not even require an instance of the class to exist.
        - An important detail to keep in mind when implementing a program using a static class data member is that you cannot initialize the static class data member inside of the class. In fact, if you decide to put your code in a header file, you cannot even initialize the static variable inside of the header file; do it in a `.cpp` file which is the counterpart of the `.h` file instead (see `TLibPlayground/MatrixInCpp.h` and `TLibPlayground/MatrixInCpp.cpp` for an example). Moreover, you are required to initialize the static class member or it will not be in scope. (The syntax is a bit weird: "type class_name::static_variable = value".)
        - Importantly, it is good syntax to refer to static member functions through the use of a class name (class_name::x; rather than instance_of_class.x;). Doing so helps to remind the programmer that static member variables do not belong to a single instance of the class and that you don't need to have a single instance of a class to use a static member variable.
    - Static **member functions** of a class.
        - Static member functions are functions that do not require an instance of the class, and are called the same way you access static member variables -- with the class name rather than a variable name. (E.g. a_class::static_function(); rather than an_instance.function();)
        - Static member functions can only operate on static members (as they do not belong to specific instances of a class).

3. in front of a global variable inside a file making up a multi-file program.
    - In this case, the use of static indicates that source code in other files that are part of the project cannot access the variable. Only code inside the single file can see the variable. (It's scope -- or visibility -- is limited to the file.) This technique can be used to simulate object oriented code because it limits visibility of a variable and thus helps avoid naming conflicts. This use of static is a holdover from C.
    - Static is a keyword with many meanings, and in this particular case, it means not global (paraphrasing)

      It means that each `.cpp` file has its own copy of the variable. Thus, when you initialize in `main.cpp`, it is initialized **ONLY** in `main.cpp`. The other files have it still **uninitialized**.

Data types in C++
*****************

1. 1 Byte == 8 Bits
2. Bit shift

``<< x`` <=> ``* 2^x`` (multiply with 2^x

``>> x`` <=> ``/ 2^x`` (divided by 2^x)

3. The expression `sizeof(type)` yields **the storage size of the object or type in bytes**.
4. The powers of integer 2

==================== =========================
shift expression     value
==================== =========================
1 << 8 (1 byte)      256
1 << 16 (2 bytes)    65536
1 << 32  (4 bytes)   4,294,967,296
==================== =========================

5. Integer types `Reference c data types <https://www.tutorialspoint.com/cprogramming/c_data_types.htm>`_

================= ========================================== ==========================================================================================================
Type              Storage size                               Value range
================= ========================================== ==========================================================================================================
(signed) char     1 byte                                     [-128, 127] \|\| [-(1<<7), (1<<7)-1]
unsigned char     1 byte                                     [0, 255] \|\| [0, (1 << 8) -1]
(signed) int      2 bytes (32-bit PC), 4 bytes (64-bit PC)   [-32,768, 32,767], [-2,147,483,648, 2,147,483,647] \|\| [-(1<<15), (1<<15)-1], [-(2<<31), (2<<31)-1]
unsigned int      2 bytes (32-bit PC), 4 bytes (64-bit PC)   [0, 65535], [0, 4,294, 967, 295]\|\|[0, (1<<16)-1], [0, (1<<32)-1]
short             2 bytes                                    [-32,768, 32,767] \|\| [-(1<<15), (1<<15)-1]
unsigned short    2 bytes                                    [0, 65535]\|\|[0, (1<<16)-1],
long              4 bytes                                    [-2,147,483,648, 2,147,483,647] \|\|  [-(2<<31), (2<<31)-1]
unsigned long     4 bytes                                    [0, 4,294, 967, 295] \|\| [0, (1<<32) -1]
================= ========================================== ==========================================================================================================

.. code-block:: bash

        short            -> signed short
        signed short
        unsigned short
        int              -> signed int
        signed int
        unsigned int
        signed           -> signed int
        unsigned         -> unsigned int
        long             -> signed long
        signed long
        unsigned long

        char  # (is signed or unsigned depending on the implmentation)
        signed char
        unsigned char


6. Floating-point types `Reference c data types _ <https://www.tutorialspoint.com/cprogramming/c_data_types.htm>`_

=============== ==============  ====================
Type            Storage size    Precision
=============== ==============  ====================
float           4 bytes         6 decimal places
double          8 bytes         15 decimal places
long double     10 bytes        19 decimal places
=============== ==============  ====================

7. Type `long long`

================ ===============
Specifier(s)     Type
================ ===============
long long int    long long int
long long        long long int
long int         long int
long             long int
================ ===============

`long` at least 32 bits （4 Bytes）;
`long long` at least 64 bits (8 Bytes).

Uniform distribution
********************

 `Reference from Wikipedia <https://en.wikipedia.org/wiki/Uniform_distribution_(continuous)>`_

 **PDF**, Probability Density Function

 **CDF**, Cumulative Distribution Function

 In probability theory and statistics, the continuous uniform distribution or rectangular distribution is
 a family of symmetric probability distributions such that for each member of the family, all intervals of
 the same length on the distribution's support are **equally probable**. The support is defined by the two
 parameters, a and b, which are its minimum and maximum values. The distribution is often abbreviated U(a,b).

Seed for random functions
*************************

Keywords: 1. Pseudo-random 2. True-random 3. Seed

`Reference random <www.random.org>`_

Perhaps you have wondered how predictable machines like computers can generate randomness. In reality, most random numbers used in computer programs are *pseudo-random*, which means they are generated in a predictable fashion using a mathematical formula. This is fine for many purposes, but it may not be random in the way you expect if you're used to dice rolls and lottery drawings.

`RANDOM.ORG <www.random.org>` offers *true* random numbers to anyone on the Internet. The randomness comes from atmospheric noise, which for many purposes is better than the pseudo-random number algorithms typically used in computer programs. People use RANDOM.ORG for holding drawings, lotteries and sweepstakes, to drive online games, for scientific applications and for art and music.

`Reference what does seed mean <https://stackoverflow.com/questions/1619627/what-does-seeding-mean>`_

Most random functions that are common on personal computers aren't random, but deterministic to a degree. The 'seed' for these psuedo-random functions are the starting point upon which future values are based. This is useful for debugging purposes: if you keep the seed the same from execution to execution you'll get the same numbers.

To get numbers that are **more** random **a different seed** is often used from execution to execution. This method is completely different than generating a 'true' random number based on some sort of physical property in the world around us (like www.random.org is using randomness comes from atmospheric noise).

Hence we often say that: *You better seed for random functions*.

A more human-readable explanation about **seed**:

1. It means: pick a place to start.

2. Think of a pseudo random number generator as just a really long list of numbers. This list is circular, it eventually repeats.

3. To use it, you need to pick a starting place. This is called a "seed".

Non-deterministic randomness
****************************

`Reference nondeterministic algorithm <https://en.m.wikipedia.org/wiki/Nondeterministic_algorithm>`_

In `computer science <https://en.m.wikipedia.org/wiki/Computer_science>`_, a **nondeterministic algorithm** is an `algorithm <https://en.m.wikipedia.org/wiki/Algorithm>`_ that, even for the same input, can exhibit different behaviors on different runs, as opposed to a `deterministic algorithm <https://en.m.wikipedia.org/wiki/Deterministic_algorithm>`_.

`std::random_device <http://en.cppreference.com/w/cpp/numeric/random/random_device>`_ is a **non-deterministic uniform random number generator**, although implementations are allowed to implement `std::random_device <http://en.cppreference.com/w/cpp/numeric/random/random_device>`_ using a pseudo-random number engine if there is no support for non-deterministic random number generation. (It is usually **just used to seed a pseudo-random generator**, since the underlying device wil usually run out of entropy quickly.)

`random_device` is non-deterministic random number generator using **hardware entropy source**. (Recall that the true randomness generators usually generates a true random number based on some sort of physical property in the world around us.)

Usage example:

.. code-block:: c++

    /// A mordern appoach in C++ to generate pseudo randomness which
    /// is `more like` true randomness.
    #include <iostream>
    #include <random>
    int main()
    {
    	// define the name of a function to obtain a true random number from entropy pool
    	std::random_device rd;
    	// seed the pseudo random generator to make it more like true random
        std::mt19937 eng(rd());
        // define the range
        std::uniform_int_distribution<> distr(25, 63);

        for(int n=0; n<40; ++n)
            // generate numbers
            std::cout << distr(eng) << ' ';
    }


About **hardware entropy source**:

The **entropy source**, a.k.a **randomness source**, is the randomness stored in **entropy pool** in your computer.

Pseudo random numbers are actually predictable by definition. To serve real ramdom numbers, the computer system first gathers true random numbers from outside world, e.g., the gaps between your keypresses and the network activity, and feeds those randomness to a place termed **entropy pool**, which can be deemed as the store of randomness which gets built up by the outside phsical activities and drained by the generation of true random numbers.

`std::mt19937` is **a fast pseudo-random number generator** using the `Mersenne Twister engine <https://dx.doi.org/10.1145%2F272991.272995>`_ which, according to the original authors' paper title, is also **uniform**. This generates fully random 32-bit or 64-bit unsigned integers. Since `std::random_device` is only used to seed this generator, it does not have to be uniform itself (e.g., you often seed the generator using a current time stamp, which is definitely not uniformly distributed).

Typically, you use a generator such as `std::mt19937` to feed a particular *distribution*, e.g. a `std::uniform_int_distribution <http://en.cppreference.com/w/cpp/numeric/random/uniform_int_distribution>`_ or `std::normal_distribution <http://en.cppreference.com/w/cpp/numeric/random/normal_distribution>`_ which then take the desired distribution shape.

Usage example:

.. code-block:: c++

        #include <iostream>
        #include <string>
        #include <map>
        #include <random>

        int main()
        {
          std::random_device rd;
          std::mt19937 mt(rd());
          std::map<int, int> hist;
          std::uniform_int_distribution<int> dist(0, 9);
          for (int n = 0; n < 2000; ++n) {
            int x = dist(mt);
            std::cout << "======> 1: " << x << std::endl;
            std::cout << "======> 2: " << ++hist[x] << std::endl;
            ++hist[dist(rd)]; // note: demo only: the performance of many
            // implementations of random_device degrades sharply
            // once the entropy pool is exhausted. For practical use
            // random_device is generally only used to seed
            // a PRNG such as mt19937
          }
          for (auto p : hist) {
            std::cout << p.first << " : " << std::string(p.second/100, '*') << '\n';
          }
        }

Possible output:

.. code-block:: bash

        0 : ********************
        1 : *******************
        2 : ********************
        3 : ********************
        4 : ********************
        5 : *******************
        6 : ********************
        7 : ********************
        8 : *******************
        9 : ********************



`std::shuffle <http://en.cppreference.com/w/cpp/algorithm/random_shuffle>`_, according to the documentation, reorders the elements in the given range [first, last) such that each possible permutation of those elements has equal probability of appearance.

Usage example:

.. code-block:: c++

        #include <random>
        #include <algorithm>
        #include <iterator>
        #include <iostream>

        int main()
        {
            std::vector<int> v = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

            std::random_device rd;
            std::mt19937 g(rd());

            std::shuffle(v.begin(), v.end(), g);

            std::copy(v.begin(), v.end(), std::ostream_iterator<int>(std::cout, " "));
            std::cout << "\n";
        }

Possible output:

.. code-block:: bash

        8 6 10 4 2 3 7 1 9 5

Hash
****

`Reference java hashset class <https://www.tutorialspoint.com/java/java_hashset_class.html>`_

A hash table stores information by using a mechanism called **hashing**. In hashing, the informational content of a key is used to determine a **unique** value, called its hash code.

Sequence containers in C++
**************************

Keywords: classes of `vector`,` deque`, `list`

Those sequence containers are also known as **data structures**.

`A good benchmark article about vector, deque and list <https://baptiste-wicht.com/posts/2012/12/cpp-benchmark-vector-list-deque.html>`_ (Pay attention to the conclusion section in this article if you prefer a quick read)

`STL Containers - diffrence between vector, list and deque <https://stackoverflow.com/questions/9650254/stl-containers-diffrence-between-vector-list-and-deque>`_

Call constructor without any args
*********************************

When the parser sees ``MyClass myObj();``, it thinks you are trying to declare a function called ``myObj`` that has no parameters and returns a ``MyClass``.

The **correct** way is: ``MyClass myObj`` where parentheses do not occur.

Big O
*****
It costs `O(logn)` time for a binary search on `n` numbers,

Function pointer and typedef
****************************

Function pointer
****************
`ref from learncpp.com <https://www.learncpp.com/cpp-tutorial/78-function-pointers/>`_

A pointer is a variable that holds the address of another variable. Function pointers are similar,
except that instead of pointing to variables, they point to functions.

In C, there's no such thing as a function being const or otherwise, so a pointer to a const function
is meaningless (shouldn't compile, though I haven't checked with any particular compiler).

Note that although it's different, you can have a const pointer to a function, a pointer to function
returning const, etc. Essentially everything but the function itself can be const.
Consider a few examples:

.. code-block:: c++

        // normal pointer to function
        int (*func)(int);

        // pointer to const function -- not allowed
        //  int (const *func)(int);

        // const pointer to function. Allowed, must be initialized.
        int (*const func1)(int) = nullptr;

        // put const before int will indicate the function being pointed to would return a const int.
        const int (*func11)(int);

        // Bonus: pointer to function returning pointer to const
        void const *(*func2)(int);

        // triple bonus: const pointer to function returning pointer to const.
        void const *(*const func3)(int) = nullptr;


Initialize function pointer
***************************

Initialize function pointer with function name, without braces.

.. code-block:: c++

        int foo(){return 5;}
        int goo(){return 6;}

        int main() {
            int (*ptr)() = foo; // ptr points to function foo
            ptr = goo;          // ptr points to function goo
        }

One common mistake is ``ptr = goo()``. This would actually assign values from a call to
function ``goo()`` to ptr, which is not what we want.

The type (parameters and return type) of the function pointer must match the type of the function.

Call a function with function pointer
=====================================
.. code-block:: c++

        int (*ptr)(int) = foo;
        ptr(5);     // call function foo(5) via implicit dereferencing.
        (*ptr)(5);  // call function foo via explicit dereferencing.

Unlike fundamental types, C++ will implicitly convert a function into a function pointer if needed (so you don’t need to use the address-of operator (&) to get the function’s address). However, it will not implicitly convert function pointers to void pointers, or vice-versa.

The implicit dereference method looks just like a normal function call -- which is what you’d expect, since normal function names are pointers to functions anyway! However, some older compilers do not support the implicit dereference method, but all modern compilers should.

Default parameters won’t work for functions called through function pointers. Default parameters are resolved at compile-time (that is, if you don’t supply an argument for a defaulted parameter, the compiler substitutes one in for you when the code is compiled). However, function pointers are resolved at run-time. Consequently, default parameters can not be resolved when making a function call with a function pointer. You’ll explicitly have to pass in values for any defaulted parameters in this case.

Passing functions as arguments to other function
------------------------------------------------

One of the most useful things to do with function pointers is pass a function as an argument to another function.
Functions used as arguments to another function are sometimes called **callback functions**.

Make function pointers prettier with typedef or type aliases
------------------------------------------------------------

.. code-block:: c++

        // Let’s face it -- the syntax for pointers to functions is ugly.
        // However, typedefs can be used to make pointers to functions
        // look more like regular variables:
        typedef bool (*validateFcn)(int, int);
        // Or equivalently, you can use type alias:
        using validateFcn = bool(*)(int, int); // type alias

        // Now instead of doing this:
        bool validate(int x, int y, bool (*fcnPtr)(int, int)); // ugly
        // you can do this:
        bool validate(int x, int y, validateFcn pfcn) // clean

        // Or in C++11, you can use std::function
        // Introduced in C++11, an alternate method of defining and storing function pointers
        // is to use std::function, which is part of the standard library <functional> header.
        // To define a function pointer using this method, declare a std::function object like so:
        #include <functional>
        bool validate(int x, int y, std::function<bool(int, int)> fcn); // std::function method that returns a bool and takes two int parameters
        // As you see, both the return type and parameters go inside angled brackets, with the
        // parameters inside parenthesis. If there are no parameters, the parentheses can be left
        // empty. Although this reads a little more verbosely, it’s also more explicit, as it makes
        // it clear what the return type and parameters expected are (whereas the typedef method
        // obscures them).

        // example:
        #include <functional>
        #include <iostream>

        int foo()
        {
            return 5;
        }

        int goo()
        {
            return 6;
        }

        int main()
        {
            std::function<int()> fcnPtr; // declare function pointer that returns an int and takes no parameters
            fcnPtr = goo; // fcnPtr now points to function goo
            std::cout << fcnPtr(); // call the function just like normal

            return 0;
        }

`when-should-i-use-typedef-in-c <https://stackoverflow.com/questions/516237/when-should-i-use-typedef-in-c>`_

Hide function pointer with a ``typedef``.

.. code-block:: c++

    // this declares an array of 10 elements, with each element as a function pointer,
    // that function takes another function pointer as the arg, returns void.
    void ( *p[10] ) ( void(*)() );

``p`` is an *array of 10 pointers, with each pointer pointing to a function
returning void and taking a pointer to another function that returns void and takes no
arguments*. The cumbersome syntax is nearly indecipherable. However,
you can simplify it considerably by using `typedef` declarations. First,
declare a `typedef` for *pointer to a function returning void and taking no arguments*
as follows:

.. code-block:: c++

    typedef void (*pfv)();

Next, decalre another typedef for *pointer to a function returning void and taking a pfv* based
on the `typedef` we previously declared:

.. code-block:: c++

    typedef void (*pf_taking_pfv) (pfv);

Now that we have created the pf_taking_pfv typedef as a synonym for the unwieldy
*pointer to a function returning void and taking a pfv*,
declaring an array of 10 such pointers is a breeze:

.. code-block:: c++

    pf_taking_pfv p[10]

Conclusion for function pointer
===============================
Function pointers are useful primarily
1. when you want to store functions in an array (or other structure),
2. or when you need to pass a function to another function.

Because the native syntax to declare function pointers is ugly and error prone, we recommend you
use typedefs (or in C++11, std::function).

Forward declaration
*******************
"In computer programming, a forward declaration is a declaration of an identifier (denoting an entity such as a type, a variable, or a function) for which the programmer has not yet given a complete definition."

Forward declarations are often used in C++ to deal with circular relationships. For example:

.. code-block:: c++

    class B; // Forward declaration

    class A
    {
        B* b;
    };

    class B
    {
        A* a;
    };

Difference between class and struct
***********************************
* `ref from quora <https://www.quora.com/What-is-the-difference-between-class-and-structure-in-C++>`_
* `ref from IBM <https://www.ibm.com/support/knowledgecenter/en/SSLTBW_2.3.0/com.ibm.zos.v2r3.cbclx01/cplr054.htm>`_
* `ref from geeksforgeeks <https://www.geeksforgeeks.org/g-fact-76/>`_
* `ref from fluent c++ blog <https://www.fluentcpp.com/2017/06/13/the-real-difference-between-struct-class/>`_

Multiple public/private keyword in class definition
***************************************************

.. code-block:: c++

        class myClass {

            // initializers etc
            public:
                myClass();
                ~myClass();

            // signal processing
            public:
                void modifyClass();
            private:
                float signalValue;

            // other class responsibilities
            public:
                void doWork();
            private:
                void workHelper();
        };

It's a good way to show the different capabilities of a class.

public protected private
************************

.. code-block:: c++

        class A
        {
        public:
            int x;
        protected:
            int y;
        private:
            int z;
        };

        class B : public A
        {
            // x is public
            // y is protected
            // z is not accessible from B
        };

        class C : protected A
        {
            // x is protected
            // y is protected
            // z is not accessible from C
        };

        class D : private A    // 'private' is default for classes
        {
            // x is private
            // y is private
            // z is not accessible from D
        };

https://stackoverflow.com/questions/860339/difference-between-private-public-and-protected-inheritance

virtual
*******


Virtual keyword in the derived class is not needed: an overrider of a member
function that is virtual in a base class is always virtual whether you use the
keyword or not.

If your compiler isn't outdated, what you should do is use the override keyword
(standardized in 2011), as it would prevent you from the common error of hiding a
base instead of overriding it due to a small signature mismatch.

Runtime Polymorphism: We define a base class that exports several
function marked as ``virtual``. In our program, we pass around pointers
to objects of this base class, which may in fact be pointing to a base
class object or to some derived class. Whenever we make member function
calls to the virtual functions of the base class, c++ figures out at runtime
what type of object is being pointed at and calls its implementation of
the virtual function.

So when should I declare a destructor virtual? Whenever the class has at least one virtual function.

ref:
1. https://www.quora.com/When-overriding-virtual-method-in-derived-class-should-I-put-virtual-keyword-in-the-derived-class-method-declaration
2. stanford cs 106L c++ full course reader.
3. http://www.stroustrup.com/bs_faq2.html#virtual-dtor

Heap vs Stack
*************
`what-and-where-are-the-stack-and-heap <https://stackoverflow.com/questions/79923/what-and-where-are-the-stack-and-heap>`_

Various Casts
*************

`when should static_cast dynamic_cast const_cast reinterpret_cast be used <https://stackoverflow.com/questions/332030/when-should-static-cast-dynamic-cast-const-cast-and-reinterpret-cast-be-used>`_


Some concepts for better articulate your ideas in cpp with others
*****************************************************************

1. one definition rule: it also helps to prevent violations of the one fefinition rule, the requirement that all templates, types, functrions and objects have no more than one definition in your code.

2. include guard idiom: it has an effect similar to the include guard idiom, which uses preprocessor macro definitions to prevent multiple inclusions of the contents of the file.

3. multiple-include optimization: the use of ``#pragma once`` can reduce build times, as the compiler wont open and read the file again after the first #include of the file in the translation unit. it is called the multiple-include optimization

4. translation unit: A translation unit consists of an implementation file and all the headers that it includes directly or indirectly. Each translation units will be compiled individually by the compiler, after that each compiled translation units are merged into a single program by linker.


Ampersands
**********

`how to use ampersands in cpp <https://dev.to/sandordargo/how-to-use-ampersands-in-c-3kga>`_

Linkage
*******

#. The concept of linkage does not apply to variables declared within class definitions or function bodies.

#. The concept of linkage apply to global variables, which are defined at global or namespace scope.

#. A free function is a function that is defined at global or namespace scope.

#. Free functions and non-const global variables by default have **external linkage**. They are visible from any translation unit in the program. Therefore, no other global object can have that name.

#. A symbol with internal linkage or no linkage is visible only within the translation unit in which it is declared. When a name has internal linkage, the same name may exist in another translation unit.

#. You can force a global name to have internal linkage by explicitly declaring it as static. This limits its visibility to the same translation unit in which it is declared.

#. The following objects (which are not within function or class scope) have internal linkage by default:

    * const objects
    * constexpr objects
    * typedefs
    * static objects in namespace scope

#. To give a const object external linkage, declare it as extern and assign it a value: ``extern const int value = 42;``

#. ``extern`` keyword is ignored in variable definition, e.g. ``extern int i = 32; // extern is ignored.``

    * In a non-const global variable declaration, extern specifies that the variable or function is defined in another translation unit. The extern must be applied in all files except the one where the variable is defined.
    * In a const variable declaration, it specifies that the variable has external linkage. The extern must be applied to all declarations in all files. (Global const variables have internal linkage by default.)
    * extern "C" specifies that the function is defined elsewhere and uses the C-language calling convention. The extern "C" modifier may also be applied to multiple function declarations in a block.
    * In a template declaration, extern specifies that the template has already been instantiated elsewhere. extern tells the compiler it can reuse the other instantiation, rather than create a new one at the current location. For more information about this use of extern, see Explicit instantiation.


References

#. https://docs.microsoft.com/en-us/cpp/cpp/program-and-linkage-cpp?view=vs-2019
#. https://docs.microsoft.com/en-us/cpp/cpp/extern-cpp?view=vs-2019


Links
#####

* `Bjarne Stroustrup's homepage <http://www.stroustrup.com>`_
* `Bjarne Stroustrup's recommendation: Cpp Core Guidelines <https://github.com/isocpp/CppCoreGuidelines>`_
* `Bjarne Stroustrup's C++ Glossary <http://www.stroustrup.com/glossary.html>`_
* `Bjarne Stroustrup's explanation about exception <http://www.stroustrup.com/bs_faq2.html#exceptions-why>`_
* `Bjarne Stroustrup: What is so great about classes? <http://www.stroustrup.com/bs_faq.html#class>`_
* `What is OOP <http://duramecho.com/ComputerInformation/WhatIsObjectOrientedProgramming.html>`_
* `String: Cpp String Examples <http://anaturb.net/C/string_exapm.htm>`_
* `String: More about C strings (including downsides of C strings) <https://www.cs.fsu.edu/~myers/cop3330/notes/strings.html>`_
* `Why do you use double pointers <https://stackoverflow.com/questions/5580761/why-use-double-pointer-or-why-use-pointers-to-pointers>`_
* `google c++ style guide <https://google.github.io/styleguide/cppguide.html>`_
