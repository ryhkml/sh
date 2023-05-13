##  Simple Shell Script for Automating the Build and Deployment

### Usage
  1. Clone the repo
  2. Change directory deployment and run `chmod +x run.sh`

### Deploy with Cosign
Cosign aims to make signatures invisible infrastructure. Add your password for private key into `.key` file.
  1. installation for [Linux and macOS binaries](https://github.com/sigstore/cosign/releases/latest)
  2. `cd deploy-with-cosign`
  3. `cosign generate-key-pair`

This is what docker images looks like in the Artifact Registry

![Sample Docker Images](./Screenshot%202023-05-13%20at%2010-13-10%20Digests%20for%20tools%20%E2%80%93%20Artifact%20Registry%20%E2%80%93%20Personal%20%E2%80%93%20Google%20Cloud%20console.png)

tag `1.0.0` is your app
tag `.sig` is a signature. This means, the cosign claims were validated and the signature were verified against the specified public key
  
For more information, you can visit [Container Signing Github](https://github.com/sigstore/cosign)