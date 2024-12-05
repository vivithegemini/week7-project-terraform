# Generate an RSO key pair for utc app
resource "tls_private_key" "tls" {
  algorithm = "RSA"
  rsa_bits = 2048
}
#create an aws key pair using the public key
resource "aws_key_pair" "utc-key" {
  key_name = "utc-key"
  public_key = tls_private_key.tls.public_key_openssh
}
#save the private key locally for ssh access
resource "local_file" "key1" {
  filename = "utc-key.pem"
  content = tls_private_key.tls.private_key_pem
}

#output the private key file path (Optional)
output "tls_private_key" {
  value = local_file.key1.utc-key.pem
}