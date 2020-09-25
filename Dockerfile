FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt install -y cmake make openjdk-8-jdk patch bison diffutils flex gzip python binutils gcc g++ libperl-dev # protobuf-compiler
RUN update-alternatives --set c++ /usr/bin/g++
RUN update-alternatives --set cc /usr/bin/gcc
