import json
import subprocess
import os

#export certificate and private key to data.json - Linux
#os.system('terraform output -json > data.json')

#export certificate and private key to data.json - Windows
#subprocess.Popen('powershell.exe [cd /fleet_test_terraform]', capture_output=True)

#writing the certificate.pem.crt and private.pem.key files
with open('data.json','rb') as json_file:
    data = json.loads(json_file.read())
    print(data)
    f= open("private.pem.key", "w")
    f.write(data["iot_certificate_key"]["value"])
    f.close()

    g= open("certificate.pem.crt.txt", "w")
    g.write(data["iot_certificate_pem"]["value"])
    g.close()
    