# Secure testing

Some docker images containing tools for testing and dotnet runtime to securly manage password read from secret in k8s cluster. 

> Code in this repo is a POC. Secret should not be pass into query string, or simply store as base64 string. Normally, the secret would be encrypted and the c# program should decrypt the password. The secret value can be for example the password of the OIDC client that use client credential flow.

## Build the images

```
docker build -t securetesting/artillery -f Artillery.dockerfile .
docker build -t securetesting/k6 -f k6.dockerfile .
docker build -t securetesting/newman -f Newman.dockerfile .
```
or
```
.\build-images.ps1
```

## Execute the image in interactive mode

```
docker run -it --rm --entrypoint /bin/sh securetesting/artillery
docker run -it --rm --entrypoint /bin/sh securetesting/k6
docker run -it --rm --entrypoint /bin/sh securetesting/newman
```

### Images sizes

- Artillery: 282.36 MB
- k6: 106.13 MB
- Newman: 283.12 MB

## Running example from a local machine

```
cd example
artillery run .\artyllery.yml -v '{\"arg1\": \"test\"}'
k6 run -e Arg1=test ./k6.js
newman run .\newman.postman_collection.json --env-var arg1=test
```

## Deploy the example in a k8s cluster

```
.\deploy-example.ps1
```

### Without cluster on local machine

If you don't have any k8s cluster but you have access to a the kubectl cli, you can deploy a AKS cluster three line

> You may want to change the default cluster name and few argument of the azure-aks-cluster-deployment.ps1 script.

```
git clone https://github.com/freddycoder/AzureAKS-TLS.git
cd AzureAKS-TLS
.\azure-aks-cluster-deployment.ps1
```

There is few question to answer in the process. In about 10 minutes you will have a cluster ready to be used.