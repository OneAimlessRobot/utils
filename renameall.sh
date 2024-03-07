#!/bin/bash

for i in $(bash get_entries_no_extension.sh)
do
mv "$i.html" "$i.css"
done
