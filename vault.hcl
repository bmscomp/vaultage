listener "tcp" {
  address          = "0.0.0.0:8200"
  tls_disable      = 0
  tls_cert_file    = "cserts/vault-cert.pem"
  tls_key_file     = "cserts/vault-key.pem"
}

ui = true
disable_mlock = true
cluster_addr  = "https://0.0.0.0:8201"
api_addr      = "https://0.0.0.0:8200"

storage "file" {
  path = ".data"
}
