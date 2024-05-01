# Create a PKI certifacte chain for testing

## Intro

The goal is to create a certificate chain with a root CA, an intermediate CA and a client or server certificate. Like this:

       +-----------+   
       |  Root CA  |   
       +-----+-----+   
             | Signs   
    +--------v--------+
    | Intermediate CA |
    +--------+--------+
             | Signs   
       +-----v-----+   
       |  Client   |   
       +-----------+   

You need to have openssl installed, since we will be using it to do all the work.

There is overlap in almost all functions of the openssl commands. We will for the most par use `req` and `ca` to do everything.

The man pages for the openssl options contains most of the info.
- openssl-ca
- openssl-req
- openssl-x509
- x509v3_config

## Step 1 - Create the root CA key and signed certificate
Fill in the required values in `root.conf`.

Most of the options are described in the man pages for the openssl commands. We will at least need:
- Some paths: where to find stuff and where to put stuff
- A policy
- Request extensions for different request types

Since we will use the signed certificate of the CA to sign other CAs and potentially certificates it's important that we allow this when configuring the CA certificate.


## Step 2 - Create the intermediate key and signed certificate
Fill in the required values in `intermediate.conf`

This is almost the same as the root CA configuration, but with no default request extensions.

The signing policy can also be different if we want to be more or less strict on what to match.


## Step 3 - Create a client or server key and signed certificate
Fill in the required values in `user.conf`

This is a lot simpler, since it is only used to create signing request.

We need information here about what to sign, such as a DNS name or an IP address.