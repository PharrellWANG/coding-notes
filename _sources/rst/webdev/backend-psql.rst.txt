PostgreSQL
==========

Connecting to postgresql database via Socks Proxy
-------------------------------------------------

https://intellij-support.jetbrains.com/hc/en-us/community/posts/360001007339-Data-Grip-connecting-to-a-remote-DB-via-an-existing-SSH-Proxy-


For macOS
---------
* `Postgresql.app <http://postgresapp.com/>`_ -- The easiest way to get started with PostgreSQL on macOS.

* `postgreSQL guide <http://postgresguide.com>`_ -- A promising new PostgreSQL resource that reads well and introduces advanced topics in a way that’s easy to understand.

Basics
~~~~~~

1. ``psql``: Logs me in with my default username.
2. ``psql -U postgres``: Logs me in as the postgres user.
3. At :numref:`label_of_postgresql_basics_3` you can see the first argument to ``psql`` is the name of database (it gives ``-d`` option by default, original command is ``psql -d postgres``), the user logged in is still the default user. Note that we can use ``select current_user`` and ``select current_database()`` to get current user and database currently being used by postgreSQL interactive shell.

.. _label_of_postgresql_basics_3:
.. figure:: ../../images/postgresql_basics_3.png
   :scale: 50 %
   :alt: postgresql_basics_3

   Login to postgreSQL interactive shell with **default user** and the database named **postgres**.

4. There is a database named "postgres" in every default installation. (by ``initdb`` command, which is used to create the first database, it doesn't have your username as any database name. It has a database named ``postgres``. -- `The first database is always created by the initdb command when the data storage area is initialized. This database is called postgres. <https://www.postgresql.org/docs/9.3/static/manage-ag-createdb.html>`_.)
5. By ``psql --help``, when you didn't set options for database name (without ``-d`` option) it would be your username, if you didn't do ``-U``, the database username would be your username too, etc. This is why when you simply use ``psql``, you will be logged in as the user ``pharrell`` and the database ``pharrell``. See :numref:`label_of_postgresql_basics_5`

.. _label_of_postgresql_basics_5:
.. figure:: ../../images/postgresql_basics_5.png
   :scale: 50 %
   :alt: postgresql_basics_5

   Login to postgreSQL interactive shell with **default user** and **default database**.

6. See :numref:`label_of_postgresql_basics_6` usage of ``psql -d <dbname> -U <username>``

.. _label_of_postgresql_basics_6:
.. figure:: ../../images/postgresql_basics_6.png
   :scale: 50 %
   :alt: postgresql_basics_6

   Login to postgreSQL interactive shell with specified username and specified database name.

7. To list the databases,  type ``\list`` or ``\l`` in postgreSQL interactive shell. (Owner of the database always has all privileges. And afterwards we can add more privileges on the database to other users/groups. Those are listed with the ``\l`` command.)

8. To list all tables in the current database, type ``\dt`` in postgreSQL interactive shell.

8. To list users and their privileges for a database: type ``\du`` in postgreSQL interactive shell. The `docs <https://www.postgresql.org/docs/current/static/sql-grant.html>`_ give an explanation of how to interpret this output. For specific privilages an a table of the current DB, use ``\z YOURTABLE``.

9. To drop a user: ``drop user if exists <username>;``

10. To create user: http://postgresguide.com/setup/users.html

11. To alter user password: ``ALTER USER yourusername WITH PASSWORD 'yournewpass';``


Create database
~~~~~~~~~~~~~~~

There are two ways to create database.

Create from zsh shell
^^^^^^^^^^^^^^^^^^^^^
To create a database, use the same command as you will do in Ubuntu,
but you don't need to ``sudo su - postgres``, you just need to
type in the ``zsh`` shell:


.. code-block:: bash

    $ createdb -h localhost -p 5432 -U Pharrell_WANG drftutorial

.. note:: ``drftutorial`` is the name of the database. And ``Pharrell_WANG`` is the name of the user. You may change them accordingly.

Create from PostgreSQL interactive terminal
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

    $ psql
    <default_username># create database <database_name>;
    <default_username># GRANT ALL PRIVILEGES ON DATABASE <database_name> to <username>;



Drop database
~~~~~~~~~~~~~


To drop the database in ``postgresql`` is quite different and troublesome than doing so in ``mysql``.

If you simply type ``dropdb name_of_TARGET_DB`` in the **zsh** shell,
you will get error ``There is 1 other session using the database.``.

Here is the solution:

.. note:: Lower case letters also work for the query language. No need to use capital letters.

**step 1**: enter the psql shell

.. code-block:: bash

    $ psql

**step 2**: prevent future connections

.. code-block:: sql

    Pharrell_WANG=# REVOKE CONNECT ON DATABASE name_of_TARGET_DB FROM public;

**step 3**: terminate all connections to this db except your own

.. code-block:: sql

    Pharrell_WANG=# SELECT pg_terminate_backend(pg_stat_activity.pid)
    Pharrell_WANG=# FROM pg_stat_activity
    Pharrell_WANG=# WHERE pg_stat_activity.datname = 'name_of_TARGET_DB';

**step 4**: get back to **zsh** shell and type:

.. code-block:: bash

    $ dropdb name_of_TARGET_DB

How to dump and restore
~~~~~~~~~~~~~~~~~~~~~~~

If the OS is *Ubuntu*, use ``$ sudo su - postgres`` to switch to the user of postgres first.
If the OS is *macOS*, directly type below commands in terminal.

**Dump**: ``pg_dump -U postgres -p 5432 crimemap -f /tmp/crimemap_psqldumpfile.sql``.
**Restore**: ``psql -d liveability -f /tmp/lala.sql``


Migrate from scratch again
~~~~~~~~~~~~~~~~~~~~~~~~~~


Normally, after you have dropped the database, you want to create
the db with the same name again. And you want to do the
migrations again. Here is the solution.

.. code-block:: bash

    $ rm -rf APP_LABEL/migrations
    $ python manage.py makemigrations APP_LABEL
    $ python manage.py migrate

How to Backup
~~~~~~~~~~~~~


:Official: https://www.postgresql.org/docs/current/static/app-pgdump.html

:Auto backup bash script: https://gist.github.com/PharrellWANG/0d0e533e5a28fd489d34cc94ee3904f9



How to connect
~~~~~~~~~~~~~~


**Django**


In your settings.py, add an entry to your DATABASES setting:

.. code-block:: python

    DATABASES = {
        "default": {
            "ENGINE": "django.db.backends.postgresql_psycopg2",
            "NAME": "[YOUR_DATABASE_NAME]",
            "USER": "[YOUR_USER_NAME]",
            "PASSWORD": "",
            "HOST": "localhost",
            "PORT": "",
        }
    }


For Ubuntu
----------

Installation
~~~~~~~~~~~~
There are two ways to install postgreSQL on Ubuntu.

First Way
^^^^^^^^^

1: Find the linux distribution release ``lsb_release -a`` (could be **Debian** or **Ubuntu**, carefully chose it).

2: Choose the Codename of your linux distribution from terminal output, e.g., ``xenial``.

3: ``sudo apt-get install libreadline6 libreadline6-dev``

4: ``sudo apt-get install libpq-dev``

5: ``pip install psycopg2``

6: Click `here <https://www.postgresql.org/download/linux/ubuntu/>`_ for reference if **Ubuntu**, click `this <https://www.postgresql.org/download/linux/debian/>`_ for reference if **Debian**

7: According to the guide in step 6: ``sudo nano /etc/apt/sources.list.d/pgdg.list``,

8: According to the guide in step 6: <insert this line into file ... >

9: According to the guide in step 6: <wget ... >

10: According to the guide in step 6: <sudo apt-get update ... >

Second Way
^^^^^^^^^^
``sudo apt-get install postgresql-9.6 postgresql-contrib``

.. note:: You can change the version number in the command above to the most recent stable release.

Server version: ``pg_config --version``

Client version: ``psql --version``

Enable remote access
~~~~~~~~~~~~~~~~~~~~

1: ``sudo nano /etc/postgresql/9.6/main/postgresql.conf``, modify contents shown in :numref:`enable-remote-access-1`.

.. _enable-remote-access-1:
.. figure:: ../../images/remote-access-1.png
   :scale: 50 %
   :alt: remote-access-1

   Contents to modify in step 1

2: ``sudo nano /etc/postgresql/9.6/main/pg_hba.conf``, modify contents shown in :numref:`enable-remote-access-2`.

.. _enable-remote-access-2:
.. figure:: ../../images/remote-access-2.png
   :scale: 50 %
   :alt: remote-access-2

   Contents to modify in step 2

3: Restart postgreSQL, MUST use ``sudo``.

**stop**:

.. code-block:: bash

    $ sudo /etc/init.d/postgresql stop 9.6
    [ ok ] Stopping postgresql (via systemctl): postgresql.service.

**start**:

.. code-block:: bash

    $ sudo /etc/init.d/postgresql start 9.6
    [ ok ] Starting postgresql (via systemctl): postgresql.service.

**restart**:

.. code-block:: bash

    $ sudo /etc/init.d/postgresql restart 9.6
    [ ok ] Restarting postgresql (via systemctl): postgresql.service.

Change password
~~~~~~~~~~~~~~~

Type in postgreSQL interactive shell: ``alter user postgres password 'ubuntu';``

Enter psql from ubuntu@ubuntu
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. ``$ sudo su - postgres``

2. After this you are in ``postgres@ubuntu``. Type ``psql`` to enter postgreSQL interactive shell.

Create database from postgres@ubuntu
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

    createdb -h localhost -p 5432 -U <username> <database-name>
    Password: <your-password>


Exit
~~~~

Type ``\q`` or hit *ctrl* + *z*, or *ctrl* + *d*

For CentOS
----------

Installation
~~~~~~~~~~~~
1. Go to `Postgresql Database server 13 pgdg download page <https://yum.postgresql.org/13/redhat/rhel-7-x86_64/repoview/postgresqldbserver13.group.html>`_, use wget to download all required rpm and yum install missing packages.

2. run below commands.

.. code-block:: bash
    
    sudo /usr/pgsql-13/bin/postgresql-13-setup initdb
    sudo systemctl start postgresql-13
    sudo systemctl enable postgresql-13
    sudo -i -u postgres  # switch to postgres user
    psql # enter console