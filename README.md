

openssl req -newkey rsa:2048 -nodes -keyout vault.key -x509 -days 365 -out vault.crt

== Run the vault using 

vault server -config=vault.hcl


Initial root token
hvs.jEYAnVjJRMHBY7sfyCzWJqn4


Key 1
j8CENS9ZHMZ3ZcQFzH2RT4lxYa4lRxPpA4s8JUmlipo=


Let's try to call an endpoint

curl --cert vault.crt --key vault.key/path/to/client.key --pass "password" https://127.0.0.1:8200/v1/sys/internal/ui/mounts/secret/example

===

vault login -method=cert -client-cert=cert.pem -client-key=key.pem name=concourse


openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365
openssl req -x509 -newkey rsa:4096 -keyout vault-key.pem -out vault-cert.pem -days 365

Try this solution 

openssl req -x509 -newkey rsa:4096 -keyout vault-key.pem -out vault-cert.pem -days 365 -nodes




=== 


# Generate CA key
openssl genpkey -algorithm RSA -out ca-key.pem -aes256

# Generate CA certificate
openssl req -new -x509 -key ca-key.pem -out ca-cert.pem -days 365


# Generate server key and CSR
openssl genpkey -algorithm RSA -out vault-key.pem -aes256
openssl req -new -key vault-key.pem -out vault-csr.pem

# Sign the CSR with CA to create the server certificate
openssl x509 -req -in vault-csr.pem -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out vault-cert.pem -days 365

# Generate client key and CSR
openssl genpkey -algorithm RSA -out client-key.pem -aes256
openssl req -new -key client-key.pem -out client-csr.pem

# Sign the CSR with CA to create the client certificate
openssl x509 -req -in client-csr.pem -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out client-cert.pem -days 365

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_cert_file = "/path/to/vault-cert.pem"
  tls_key_file  = "/path/to/vault-key.pem"
}

vault login -method=cert
