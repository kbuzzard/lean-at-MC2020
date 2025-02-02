#!/usr/bin/env bash
set -e
if [ "$#" -ne 2 ]; then
    echo "Usage example: $0 jalex-stark lean_at_mc2020"
    exit 1
fi

# Build
make clean html examples latexpdf

# 3. Deploy
rm -rf deploy
git clone git@github.com:$1/$2 deploy
cd deploy
rm -rf * .gitignore
cp -Lr ../to-be-deployed/./ .
git add .
git commit -m "Update `date`"
git push

git checkout gh-pages
rm -rf * .gitignore .buildinfo .nojekyll
cp -r ../build/html/./ .
cp ../build/latex/lean_at_MC2020.pdf .
git add .
git commit -m "Update `date`"
git push

cd ..
rm -rf deploy
