#!/bin/bash
echo "Installing..."
for p in $(ls | grep -v "install.sh" | grep -v "README.md"); do
    stow $p;
done;
echo "Done!"
exit 1
