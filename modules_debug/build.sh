#!/bin/bash

echo "[1/2] Clean up old build."
rm -rf date.o
rm -rf redis_date_module.so

echo "[2/2] Bulding new module."
make all -j 4;
echo "[2/2] DONE."
