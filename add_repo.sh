#!/bin/bash

repo_name=$1
repo_path=$2

if [[ "$1" == "" || "$2" == "" ]]; then
    echo "Usage: $0 <repo_name> <repo_path>"
    exit 1
fi

if [[ ! -d "$repo_path" ]]; then
    echo "$repo_path is not a valid directory"
    exit 1
fi

encoded_path=`echo $repo_path | sed -e 's/\//\&#x2f;/g'`

echo "Encoded Path: $encoded_path"

# Make ~/.kettle if it doesn't exist
if [[ ! -d ~/.kettle ]]; then
    mkdir ~/.kettle
fi
# Make ~/.kettle/repositories if it doesn't exist
if [[ ! -f ~/.kettle/repositories.xml ]]; then
    cat > ~/.kettle/repositories.xml << EOF
<?xml version="1.0" encoding="UTF-8"?>
<repositories>
</repositories>
EOF
fi

existing1=`grep "<name>$repo_name</name>" ~/.kettle/repositories.xml`
existing2=`grep "<base_directory>$encoded_path</base_directory>" ~/.kettle/repositories.xml`
echo "existing1 = $existing1"
echo "existing2 = $existing2"
if [[ ! -z "$existing1" && ! -z "$existing2" ]]; then
    echo "Repository entry already exists, nothing to do"
    exit 0
fi

echo "Adding repository entry for $repo_path"

sed -e 's/<\/repositories>//' ~/.kettle/repositories.xml > ~/.kettle/repositories.xml.new
cat >> ~/.kettle/repositories.xml.new << EOF
  <repository>
    <id>KettleFileRepository</id>
    <name>${repo_name}</name>
    <description>${repo_name}</description>
    <base_directory>${encoded_path}</base_directory>
    <read_only>N</read_only>
    <hides_hidden_files>Y</hides_hidden_files>
  </repository>
</repositories>
EOF

mv ~/.kettle/repositories.xml.new ~/.kettle/repositories.xml
