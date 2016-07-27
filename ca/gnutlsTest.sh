#!/bin/bash
gnutls-cli localhost -p 3000 --x509cafile ../ca.crt --x509certfile gnuclient.crt --x509keyfile gnuclient.key
