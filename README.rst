*********************************************
Shop App with Karax, Jester, Norm, and Norman
*********************************************

This is a proof-of-concept for a webapp created with Karax for frontend, Jester for API server, Norm for ORM, and Norman for migration management.


Usage
=====

1.  Clone the repo and ``cd`` into the repo dir:

.. code-block::

    $ git clone git@github.com:moigagoo/shop-api.git
    $ cd shop-api

2.  Create ``.env`` from ``.env_example``:

.. code-block::

    $ cp .env_example .env

3.  Build the image:

.. code-block::

    $ docker-compose build

4.  Start ``web`` service and enter the container:

.. code-block::

    $ docker-compose run --rm --service-ports web bash

5.  Apply the migrations:

.. code-block::

    $ norman migrate

6.  Run the app:

.. code-block::

    $ nimble run

7.  Open your browser at ``localhost:5000`` and play around.

8.  Send requests to it in a separate terminal:

.. code-block::

    $ curl -s http://localhost:5000/api/customers/1 | jq
    {
      "auth": {
        "email": "user1@example.com",
        "googleToken": "",
        "id": 1
      },
      "name": "Alice 1",
      "age": 21,
      "id": 1
    }

    $ curl -s 'http://localhost:5000/api/customers/?page=3&per_page=2' | jq
    [
      {
        "auth": {
          "email": "user5@example.com",
          "googleToken": "",
          "id": 5
        },
        "name": "Alice 5",
        "age": 25,
        "id": 5
      },
      {
        "auth": {
          "email": "user6@example.com",
          "googleToken": "",
          "id": 6
        },
        "name": "Alice 6",
        "age": 26,
        "id": 6
      }
    ]

    $ curl -X DELETE -s http://localhost:5000/api/customers/2
    $ curl -X POST --data 'email=foo@bar.com&token=AbC123' http://localhost:5000/api/customers/
    11
