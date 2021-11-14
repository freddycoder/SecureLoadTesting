# Secure testing

Somes docker images containing tool for load testing and dotnet runtime to securly manage password read from secret in k8s cluster

## Build the images

```
docker build -t securetesting\artillery -f Artillery.dockerfile .
docker build -t securetesting\k6 -f k6.dockerfile .
docker build -t securetesting\newman -f Newman.dockerfile .
```

## Execute the image in interactive mode

```
docker run -it --rm --entrypoint /bin/sh securetesting\artillery
docker run -it --rm --entrypoint /bin/sh securetesting\k6
docker run -it --rm --entrypoint /bin/sh securetesting\newman
```

### Images sizes

Artillery: 	282.36 MB
k6: 106.13 MB
Newman: 283.12 MB