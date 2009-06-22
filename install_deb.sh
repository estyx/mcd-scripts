#!/bin/sh

echo "Unpacking.."
ar p $1 data.tar.gz | tar pzx -C /
echo "Done!"
