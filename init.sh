#!/bin/bash
#
# init.sh
#
# Automate these steps to get yourself up and running with Codelab:
# * Create boilerplate for Codelab
# * Configure a nodemon watch command to rebuild your codelab on save
# - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + -

cd `dirname $0`

# validate that a codelab name was included as an argument
if [ "$#" -ne 1 ]; then
	echo "USAGE: $0 <CODELAB_NAME>"
	echo ""
	exit 1
fi

# env variables
CODELAB_NAME=$1
AUTHOR_NAME=`git config user.name`

# local variables
codelab_markdown_filename="markdown/$CODELAB_NAME/$CODELAB_NAME.md"
codelab_package_json_filename="markdown/$CODELAB_NAME/package.json"
markdown_template="markdown/template/markdown.template"
package_json_template="markdown/template/package.json"

# Note: we might not need this if its already included in the makrdown/template dir
# validate that markdown template and package.json exist
if [ ! -f "$markdown_template" ] || [ ! -f "$package_json_template" ]; then
  msg "ERROR!"
  echo "Could not find one of the following files:"
  echo "  - $markdown_template"
  echo "  - $package_json_template"
  echo ""
  echo "Why'd you go and delete one of these files :("
  exit 0
fi

# Create a new directory for the codelba 
mkdir markdown/$CODELAB_NAME
cp -r markdown/template/* markdown/$CODELAB_NAME/

# rename markdown template file 
mv markdown/$CODELAB_NAME/markdown.template $codelab_markdown_filename

# replace placeholder codelab id in markdown template file with name provided by command line argument 
sed -i \
  -e "s/CODELAB_NAME.*/$CODELAB_NAME/g" \
  $codelab_markdown_filename

# replace placeholder authorname with git username=
sed -i \
  -e "s/AUTHOR_NAME.*/$AUTHOR_NAME/g" \
  $codelab_markdown_filename

# replace placeholder codelab name in the watch command with name provided in command line argument
sed -i \
  -e "s/CODELAB_NAME/$CODELAB_NAME/g" \
  $codelab_package_json_filename