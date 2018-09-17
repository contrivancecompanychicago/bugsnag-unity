#!/bin/sh -ue

brew tap caskroom/cask

brew cask install \
  bugsnag/unity/$UNITY_VERSION

# put the package where the mazerunner tests expect them to be
cp ~/$TRAVIS_BUILD_NUMBER/Bugsnag.unitypackage ~/

# this will need to specify the platform tests to run at some point
bundle exec rake travis:maze_runner
