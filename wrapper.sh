#!/bin/sh

outputdir=/output

if [ ! -d $outputdir ] ; then
	echo "You need to use the docker -v switch to pass in a /output directory."
	exit 1
fi

echo "Generating an SSH key for use with this deployment.."
ssh-keygen

# make sure they didn't change the filename- hax
if [ ! -e ~/.ssh/id_rsa ] ; then
	echo "Ehh, can you just let it use id_rsa?  You can rename it later.."
	echo "Exiting, try again."
	exit 1
fi

echo "Adding the key to the ssh agent, please type the same password again.."
ssh-add ~/.ssh/id_rsa

cd streisand
./streisand

# look for generated-docs to determine success
if [ ! -d ./generated-docs ]; then
	echo "I don't see the generated-docs dir, did the deployment fail?"
	echo "If it timed out, it is usually due to network hiccups.  Usually you can"
	echo "just try again.."
	exit 1
fi

echo "Looks like things worked out.  Copying ssh key and docs to $outputdir.."
cp ~/.ssh/id_rsa* $outputdir/
cp ./generated-docs/* $outputdir/


