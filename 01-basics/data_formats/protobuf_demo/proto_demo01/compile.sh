#!/usr/bin/env bash

protoc -I=./ --cpp_out=./ addressbook.proto

g++ reader.cc addressbook.pb.cc -std=c++11  -lprotobuf -pthread -L/usr/local/lib
