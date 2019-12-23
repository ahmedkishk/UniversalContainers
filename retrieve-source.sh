#!/bin/bash

TARGET_ORG=$1

if [ $TARGET_ORG == "" ]; then
    echo Please specify a target username
    echo For a list of available usernames use: sfdx force:org:list
    exit 1
fi

rm -rf temp
mkdir temp
cd temp

# package.xml
echo '<?xml version="1.0" encoding="UTF-8"?>' > package.xml
echo '<Package xmlns="http://soap.sforce.com/2006/04/metadata">' >> package.xml

# Profiles
sfdx force:mdapi:listmetadata -m Profile -u $TARGET_ORG -f Profiles.json
echo "<types>" > Profiles.txt
cat Profiles.json | jq '[.[].fullName] | sort | .[] | "<members>" + . + "</members>"' -r >> Profiles.txt
echo "<name>Profile</name></types>" >> Profiles.txt
cat Profiles.txt >> package.xml

# PermissionSet
sfdx force:mdapi:listmetadata -m PermissionSet -u $TARGET_ORG -f PermissionSets.json
echo "<types>" > PermissionSets.txt
cat PermissionSets.json | jq '[.[].fullName] | sort | .[] | "<members>" + . + "</members>"' -r >> PermissionSets.txt
echo "<name>PermissionSet</name></types>" >> PermissionSets.txt
cat PermissionSets.txt >> package.xml

# Custom Objects
sfdx force:mdapi:listmetadata -m CustomObject -u $TARGET_ORG -f CustomObjects.json
echo "<types>" > CustomObjects.txt
cat CustomObjects.json | jq '[.[].fullName] | sort | .[] | "<members>" + . + "</members>"' -r >> CustomObjects.txt
echo "<name>CustomObject</name></types>" >> CustomObjects.txt
cat CustomObjects.txt >> package.xml

# APEX Classes
sfdx force:mdapi:listmetadata -m ApexClass -u $TARGET_ORG -f Classes.json
echo "<types>" > Classes.txt
cat Classes.json | jq '[.[].fullName] | sort | .[] | "<members>" + . + "</members>"' -r >> Classes.txt
echo "<name>ApexClass</name></types>" >> Classes.txt
cat Classes.txt >> package.xml

# Page Layouts
sfdx force:mdapi:listmetadata -m Layout -u $TARGET_ORG -f Layouts.json
echo "<types>" > Layouts.txt
cat Layouts.json | jq '[.[].fullName] | sort | .[] | "<members>" + . + "</members>"' -r >> Layouts.txt
echo "<name>Layout</name></types>" >> Layouts.txt
cat Layouts.txt >> package.xml

echo '<version>45.0</version>' >> package.xml
echo '</Package>' >> package.xml

cd ..
# retrieve metadata
sfdx force:source:retrieve -x ./temp/package.xml -u $TARGET_ORG

rm -rf temp