#!/bin/bash

mkdir -p sim syn

cd ./sim
source /eda/scripts/init_questa_core_prime &> /dev/null #setmentor
vlib -p work

cd ../syn
cp /home/repository/ms/setup/.synopsys_dc.setup .
source /eda/scripts/init_design_vision &> /dev/null #setsynopsys
mkdir -p work

echo "Everything is ready to start!"
