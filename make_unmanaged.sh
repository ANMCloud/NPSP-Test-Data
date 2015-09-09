#!/bin/bash
rm -rf "Test Data Deployment Unmanaged"/*
cd "Test Data Deployment Unmanaged"

mkdir Delete
cd Delete
for file in ../../'Test Data Deployment'/Delete/*.k*; do
    filename=`basename "$file"`
    echo "Writing Delete/$filename"
    sed -e "s/npsp__//g" "$file" > "$filename"
done
cd ..

for file in ../'Test Data Deployment'/*.k*; do
    filename=`basename "$file"`
    echo "Writing $filename"
    sed -e "s/npsp__//g" "$file" > "$filename"
done
cd ..
