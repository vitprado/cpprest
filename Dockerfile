FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo

RUN apt-get update -y && apt-get install -y g++ make wget libwebsocketpp-dev libz-dev zlib1g-dev build-essential libboost-all-dev libssl-dev git
RUN wget https://github.com/Kitware/CMake/releases/download/v3.21.2/cmake-3.21.2.tar.gz && tar xvzf cmake-3.21.2.tar.gz && cd cmake-3.21.2 && ./bootstrap && make && make install && cd .. && rm -rf cmake-3.21.2
RUN apt-get install -y libssl-dev
RUN mkdir -p app/libs
ADD libs/build_dependencies.sh app/libs
RUN cd app/libs && ./build_dependencies.sh
ADD . /app
RUN cd /app && ls -la && cmake . && cmake --build .
EXPOSE 8080
ENTRYPOINT ["bash", "-c", "./app/crest 8080"]
