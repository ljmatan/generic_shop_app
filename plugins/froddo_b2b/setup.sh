#!/bin/bash

# Clones the plugin repository to the local file directory.

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

cd $SCRIPT_DIR

git clone https://github.com/ljmatan/generic_shop_app_froddo_b2b

mv generic_shop_app_froddo_b2b/* generic_shop_app_froddo_b2b/.* .

rm -rf generic_shop_app_froddo_b2b