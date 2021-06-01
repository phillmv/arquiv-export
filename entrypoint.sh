#!/bin/bash

set -xeo pipefail
cd /arquivo
git pull
echo "\n\n\n#########\nimporting\n-------------"
STATIC_PLS=true NOTEBOOK_PATH=$GITHUB_WORKSPACE bundle exec rails static:import
STATIC_PLS=true bundle exec rails s -d
echo "\n\n\n#########\nbuilding\n-------------"
STATIC_PLS=true bundle exec rails static:generate
cd /arquivo/out
echo "\n\n\n#########\npublishing\n-------------"
if [ ! -z ${INPUT_CNAME} ]; then
  echo ${INPUT_CNAME} > CNAME
fi


#
# echo 'Installing bundles...'
# cd ${INPUT_SITE_LOCATION}
# gem install bundler
# bundle install
# bundle list | grep "middleman ("
#
# echo 'Building site...'
# cd /middleman
# bundle exec middleman build --verbose
#
# echo 'Publishing site...'
# cd /middleman/build
# if [ ! -z ${INPUT_CNAME} ]; then
#   echo ${INPUT_CNAME} > CNAME
# fi
# # cd ${INPUT_BUILD_LOCATION}
remote_repo="https://${INPUT_GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${INPUT_GITHUB_REPOSITORY}.git" && \
remote_branch=${INPUT_REMOTE_BRANCH}
git init
git config user.name "${INPUT_GITHUB_ACTOR}"
git config user.email "${INPUT_GITHUB_ACTOR}@users.noreply.github.com"
git add .
echo -n 'Files to Commit:'
ls -l | wc -l
# echo 'Committing files...'
git commit -m'Arquivo build.' > /dev/null 2>&1
# echo "Pushing... to $remote_repo master:$remote_branch"
git push --force $remote_repo master:$remote_branch > /dev/null 2>&1
# echo "Removing git..."
rm -fr .git
# cd -
echo 'Done'
