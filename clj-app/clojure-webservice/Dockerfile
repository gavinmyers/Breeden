FROM clojure
EXPOSE 3000
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY project.clj /usr/src/app/
RUN lein deps
RUN lein with-profile docker deps
COPY . /usr/src/app
CMD ["lein", "ring", "server-headless"]
