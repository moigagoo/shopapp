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

3.  Build the images:

.. code-block::

    $ docker-compose build

4.  Enter the ``web`` service:

.. code-block::

    $ docker-compose run --service-ports web bash

5.  Inside the container, apply the DB migrations:

.. code-block::

    $ norman migrate --compile

4.  Run the app server:

.. code-block::

    $ ./bin/app

5.  Send requests to it in a separate terminal:

.. code-block::

    $ curl -s http://localhost:5000/api/customers/1 | jq
    {
      "auth": {
        "email": "user1@example.com",
        "id": 1
      },
      "name": "Alice 1",
      "age": 21,
      "id": 1
    }

    $ curl -s 'http://localhost:5000/api/customers/page=3&per_page=2'
    [
      {
        "auth": {
          "email": "user5@example.com",
          "id": 5
        },
        "name": "Alice 5",
        "age": 25,
        "id": 5
      },
      {
        "auth": {
          "email": "user6@example.com",
          "id": 6
        },
        "name": "Alice 6",
        "age": 26,
        "id": 6
      }
    ]

    $ curl -X DELETE -s http://localhost:5000/api/customers/2
    $ curl -X POST --data "email=foo@bar.com" http://localhost:5000/api/customers/
    11
