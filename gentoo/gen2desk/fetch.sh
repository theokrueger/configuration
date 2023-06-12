#!/bin/bash

# remove previous items
read -p "would you like to remove previous items? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -r sets package.use package.accept_keywords make.conf repos.conf world world_sets sets
fi

pdir=/etc/portage
cp $pdir/make.conf ./
cp -r $pdir/package.accept_keywords ./
cp -r $pdir/package.use ./
cp -r $pdir/repos.conf ./
cp -r $pdir/sets ./

vdir=/var/lib/portage
cp $vdir/world ./
cp $vdir/world_sets ./
