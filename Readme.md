# Secure load testing

A docker image containing tool for load testing and dotnet runtime to securly manage password read from secret in k8s cluster

## Build the image

```
docker build -t secureloadtesting .
```

## Execute the image in interactive mode

```
docker run -it --rm --entrypoint /bin/sh secureloadtesting
```

### Initial build

The initial build as a size of 952 Mb