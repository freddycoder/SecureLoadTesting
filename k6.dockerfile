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
FROM loadimpact/k6:latest AS k6official
FROM mcr.microsoft.com/dotnet/runtime:6.0-alpine

# Copy the password app to the runtime image
WORKDIR /app
COPY --from=dotnet-build-env /app/out ./

# Install the latest version of k6
COPY --from=k6official /usr/bin/k6 /usr/bin/k6
