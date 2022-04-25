FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \ 
    git curl nano wget dpkg gnupg gnupg2 gnupg1

# Locate
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Dotnet install
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y apt-transport-https \
    && apt-get update \
    && apt-get install -y dotnet-sdk-6.0

# Dart SDK install
RUN wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/dart.gpg \
 && echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' \ 
 | tee /etc/apt/sources.list.d/dart_stable.list \
 && apt-get update \
 && apt-get install -y dart \
 && export PATH="$PATH:/usr/lib/dart/bin"


ENV DEBIAN_FRONTEND     noninteractive

# Python install
RUN apt-get update && apt-get install -y python3.10

WORKDIR /home

# Initial dotnet run
RUN mkdir -p csharp-test \
    && cd csharp-test \
    && dotnet new console \
    && dotnet run csharp-test.csproj \
    && cd .. && rm -r csharp-test

# Initial dart run
RUN dart create simple-console \
    && cd simple-console \
    && dart run \
    && cd .. && rm -r simple-console

RUN apt-get clean --dry-run

RUN echo "git clone https://github.com/ghostmatem/continue-examples.git" > clone.sh