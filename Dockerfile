FROM nimlang/nim:1.4.0

WORKDIR /usr/src/app

COPY . /usr/src/app

RUN apt-get update && apt-get install -y postgresql-client
RUN nimble build -y
RUN nimble frontend
RUN ~/.nimble/bin/norman migrate

CMD ./bin/app
