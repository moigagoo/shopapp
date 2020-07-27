**************************************
Shop API with Jester, Norm, and Norman
**************************************

This is webapp that demonstrates how to create RESTful webapps with `Jester <https://github.com/dom96/jester/>`_ framework, `Norm <https://moigagoo.github.io/norm/norm.html>`_ ORM, and `Norman <https://moigagoo.github.io/norman/norman.html>`_ migration manager.


Usage
=====

1.  Clone the repo and ``cd`` into the repo dir:

.. code-block::

    $ git clone git@github.com:moigagoo/shop-api.git
    $ cd shop-api

2.  Create ``.env`` from ``.env_example``:

.. code-block::

    $ cp .env_example .env

4.  Install dependencies and build the server:

.. code-block::

    $ nimble build

3.  Apply migrations to set up the DB:

.. code-block::

    $ norman migrate

4.  Run the server:

.. code-block::

    $ ./bin/app

5.  Send requests to it in a separate terminal:

.. code-block::

    $ curl -s http://localhost:5000/api/users/1 | jq
    {
      "email": "user1@example.com",
      "id": 1
    }

    $ curl -s 'http://localhost:5000/api/users/page=3&per_page=2'
    [
      {
        "email": "user5@example.com",
        "id": 5
      },
      {
        "email": "user6@example.com",
        "id": 6
      }
    ]

    $ curl -X DELETE -s http://localhost:5000/api/users/2
    $ curl -X POST --data "email=foo@bar.com" http://localhost:5000/api/users/
    11
