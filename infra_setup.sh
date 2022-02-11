#!/bin/bash
chmod +x create_keyfiles.py
terraform init
terraform apply -auto-approve
terraform output -json > data.json
python3 create_keyfiles.py