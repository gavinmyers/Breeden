docker build . -f Dockerfile -t haskell-webservice-builder
docker run --rm -v $(PWD)/.stack-work/dist/linux/bin:/root/.local/bin --name haskell-webservice-builder haskell-webservice-builder
docker build . -f DockerfileRuntime -t haskell-webservice
docker run --rm -p 3000:3000 --name haskell-webservice haskell-webservice
