docker build . -f Dockerfile -t clojure-webservice  
docker run --rm -p 3000:3000 --name clojure-webservice clojure-webservice
