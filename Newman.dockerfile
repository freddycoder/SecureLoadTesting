# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS dotnet-build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY ReadPassword/*.csproj ./ReadPassword/
RUN dotnet restore ./ReadPassword/ReadPassword.csproj

# Copy everything else and build
COPY ReadPassword/. ./ReadPassword/
RUN dotnet publish ./ReadPassword/ReadPassword.csproj -c Release -o out

# Create the runtime image
FROM node:12-alpine
WORKDIR /dotnet-runtime

# Install dotnet on linux alpine
# https://docs.microsoft.com/en-us/dotnet/core/install/linux-alpine
RUN apk add bash icu-libs krb5-libs libgcc libintl libssl1.1 libstdc++ zlib

# Download the .net6.0 runtime
RUN wget https://download.visualstudio.microsoft.com/download/pr/95352809-7f41-40f3-974d-8d530321a8e4/0024d7bf0c872f176ceba7a63a34915b/dotnet-runtime-6.0.0-linux-musl-x64.tar.gz -O ./dotnet-runtime.tar.gz

# Install the .net6.0 runtime
RUN DOTNET_FILE=dotnet-runtime.tar.gz && export DOTNET_ROOT=$(pwd)/dotnet && mkdir -p "$DOTNET_ROOT" && tar zxf "$DOTNET_FILE" -C "$DOTNET_ROOT"

ENV DOTNET_ROOT="/dotnet-runtime/dotnet"
ENV PATH="${PATH}:${DOTNET_ROOT}"

# Copy the password app to the runtime image
WORKDIR /app
COPY --from=dotnet-build-env /app/out ./

# Install the latest version of newman
RUN npm install -g newman

# Create a new user (newman) and new group (testtools)
RUN adduser -D newman && addgroup testtools

# then switch into that user’s context
USER newman:testtools
