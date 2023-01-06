#!/bin/sh
eval $(op signin)
cd packer
op inject -i build.pkrvars.hcl -o build.auto.pkrvars.hcl
packer build -timestamp-ui .
