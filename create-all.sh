#!/bin/bash

# Check content: openssl x509 -noout -text -in <file>

set -eE

mkdir -p out/certs
touch out/index.txt

echo "Creating root key"
openssl req \
    -new \
    -noenc \
    -config root.conf \
    -newkey rsa:4096 \
    -keyout out/root.key \
    -out out/root.csr

echo -e "\nSelfsign root CA certificate"
openssl ca \
    -batch \
    -selfsign \
    -config root.conf \
    -in out/root.csr \
    -out out/root.crt


echo -e "\nCreating intermediate key"
openssl req \
    -new \
    -noenc \
    -config intermediate.conf \
    -newkey rsa:4096 \
    -keyout out/intermediate.key \
    -out out/intermediate.csr

echo -e "\nSign intermediat CA certificate"
openssl ca \
    -batch \
    -config root.conf \
    -extensions sub_ca_ext \
    -in out/intermediate.csr \
    -out out/intermediate.crt

echo -e "\nCreate user key"
openssl req \
    -new \
    -noenc \
    -config user.conf \
    -newkey rsa:2048 \
    -keyout out/user.key \
    -out out/user.csr


echo -e "\nSign user certificate"
openssl ca \
    -batch \
    -config intermediate.conf \
    -extensions cert_ext \
    -in out/user.csr \
    -out out/user.crt

echo -e "\nCreate chain file"
cat out/intermediate.crt out/root.crt > out/chain.crt
chmod 444 out/chain.crt