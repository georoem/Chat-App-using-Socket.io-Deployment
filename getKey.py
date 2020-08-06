import json, os, sys

print ("Excecuting script: " + sys.argv[0])

if(len(sys.argv) <= 1 ):
   raise Exception("Oops!  That was no file to read...")

terraform_path = "infra/terraform.tfstate"
key_rsa_path = "key_rsa"
output = ''

print("Reading file " + sys.argv[1] + "...")
with open(terraform_path) as json_file:
    data = json.load(json_file)
    for p in data['resources']:
        if p['type'] == "tls_private_key" and p['name'] == "deployer":
            output = p['instances'][0]['attributes']['private_key_pem']

f = open(key_rsa_path, "w")
f.write(output)
f.close()
print("private key extracted!")

os.chmod(key_rsa_path, 0600)
print("permissions changed")

 