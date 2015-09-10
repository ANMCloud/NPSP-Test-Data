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
for file in *.kjb; do
    filename=`basename "$file"`.new
    echo "Writing Delete/$filename"
    sed -e "s/x2f;Test Data Deployment/x2f;Test Data Deployment Unmanaged/g" "$file" > "$filename"
    mv "$filename" "$file"
done
cd ..

for file in ../'Test Data Deployment'/*.k*; do
    filename=`basename "$file"`
    echo "Writing $filename"
    sed -e "s/npsp__//g" "$file" > "$filename"
done
for file in *.kjb; do
    filename=`basename "$file"`.new
    echo "Writing Delete/$filename"
    sed -e "s/x2f;Test Data Deployment/x2f;Test Data Deployment Unmanaged/g" "$file" > "$filename"
    mv "$filename" "$file"
done
cd ..
