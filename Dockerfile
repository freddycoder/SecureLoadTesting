# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY ReadPassword/*.csproj ./ReadPassword/
RUN dotnet restore ./ReadPassword/ReadPassword.csproj

# Copy everything else and build
COPY ReadPassword/. ./ReadPassword/
RUN dotnet publish ./ReadPassword/ReadPassword.csproj -c Release -o out

# Copy the program to the runtime image
FROM mcr.microsoft.com/dotnet/runtime:6.0
WORKDIR /app
COPY --from=build-env /app/out ./

# Install nodejs
RUN apt-get update -yq && apt-get install curl gnupg -yq && curl -sL https://deb.nodesource.com/setup_10.x | bash && apt-get install nodejs -yq

# Install the latest version of artillery
RUN apt-get install npm -yq && npm install -g artillery

# Install the latest version of k6
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
RUN echo "deb https://dl.k6.io/deb stable main" | tee /etc/apt/sources.list.d/k6.list
RUN apt-get update -yq && apt-get install k6 -yq