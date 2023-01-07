#!/bin/bash
#
# private Keys Generator
# Coded by RV 
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


# your country
C=IN

# state
ST=Telangana

# Location
L=Hyderabad

# Your Email
emailAddress=



openssl genrsa -3 -out temp.pem 2048
openssl req -new -x509 -key temp.pem -out releasekey.x509.pem -days 10000 -subj "/C=$C/ST=$ST/L=$L View/O=Android/OU=Android/CN=Android/emailAddress=$emailAddress"
openssl pkcs8 -in temp.pem -topk8 -outform DER -out releasekey.pk8 -nocrypt
shred --remove temp.pem

openssl genrsa -3 -out temp.pem 2048
openssl req -new -x509 -key temp.pem -out media.x509.pem -days 10000 -subj "/C=$C/ST=$ST/L=$L View/O=Android/OU=Android/CN=Android/emailAddress=$emailAddress"
openssl pkcs8 -in temp.pem -topk8 -outform DER -out media.pk8 -nocrypt
shred --remove temp.pem

openssl genrsa -3 -out temp.pem 2048
openssl req -new -x509 -key temp.pem -out platform.x509.pem -days 10000 -subj "/C=$C/ST=$ST/L=$L View/O=Android/OU=Android/CN=Android/emailAddress=$emailAddress"
openssl pkcs8 -in temp.pem -topk8 -outform DER -out platform.pk8 -nocrypt
shred --remove temp.pem

openssl genrsa -3 -out temp.pem 2048
openssl req -new -x509 -key temp.pem -out shared.x509.pem -days 10000 -subj "/C=$C/ST=$ST/L=$L View/O=Android/OU=Android/CN=Android/emailAddress=$emailAddress"
openssl pkcs8 -in temp.pem -topk8 -outform DER -out shared.pk8 -nocrypt
shred --remove temp.pem

openssl genrsa -3 -out temp.pem 2048
openssl req -new -x509 -key temp.pem -out testkey.x509.pem -days 10000 -subj "/C=$C/ST=$ST/L=$L View/O=Android/OU=Android/CN=Android/emailAddress=$emailAddress"
openssl pkcs8 -in temp.pem -topk8 -outform DER -out testkey.pk8 -nocrypt
shred --remove temp.pem

openssl genrsa -3 -out temp.pem 2048
openssl req -new -x509 -key temp.pem -out verity.x509.pem -days 10000 -subj "/C=$C/ST=$ST/L=$L View/O=Android/OU=Android/CN=Android/emailAddress=$emailAddress"
openssl pkcs8 -in temp.pem -topk8 -outform DER -out verity.pk8 -nocrypt
shred --remove temp.pem

openssl genrsa -3 -out temp.pem 2048
openssl req -new -x509 -key temp.pem -out networkstack.x509.pem -days 10000 -subj "/C=$C/ST=$ST/L=$L View/O=Android/OU=Android/CN=Android/emailAddress=$emailAddress"
openssl pkcs8 -in temp.pem -topk8 -outform DER -out networkstack.pk8 -nocrypt
shred --remove temp.pem

openssl genrsa -3 -out temp.pem 2048
openssl req -new -x509 -key temp.pem -out sdk_sandbox.x509.pem -days 10000 -subj "/C=$C/ST=$ST/L=$L View/O=Android/OU=Android/CN=Android/emailAddress=$emailAddress"
openssl pkcs8 -in temp.pem -topk8 -outform DER -out sdk_sandbox.pk8 -nocrypt
shred --remove temp.pem
