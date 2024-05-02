# Useful commands

## Creating a new key
> openssl genrsa -aes256 -out file.key 4096

## Creating a signing request and key
> openssl req -x509 -sha256 -days 1000 -noenc -newkey rsa:2048 -subj "/CN=<>/C=<>/L=<>" -keyout something.key -out request.crt

or 

> openssl req -new -noenc -config config.conf -newkey rsa:2048 -keyout something.key -out request.csr

## Signing a certificate
> openssl ca -batch -config config.conf -extensions <> -in request.csr -out certificate.crt

## Check the content
> openssl x509 -noout -text -in file.pem

## Verify a chain
> openssl verify -CAfile ca.crt certificate.crt

## Checking connections
Server
> openssl s_server -key key.pem -cert cert.pem -accept 44330 -www

Client
> openssl s_client -cert-chain chain.pem -connect localhost:44330
