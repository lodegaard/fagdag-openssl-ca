# Creating the root CA

Start by filling in the values of `root/rootca.conf`:

For stage 1 you will at least need:
- Ca configuration
- 
- v3 extension configuration

Create a root key:
`openssl genrsa -aes256 -out path/to/key.pem`