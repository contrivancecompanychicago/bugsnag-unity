#!/bin/sh -ue

return_unity_license () {
  # return the Unity license as we can only have two simultaneous activations of each license
  /Applications/Unity/Unity.app/Contents/MacOS/Unity -quit -batchmode -returnlicense -logFile unity.log
  # usage suggests that sometimes this can take longer than the command so wait for the above command to take effect
  sleep 10
}

handle_failure () {
  exit_code=${1:-}
  if [[ $exit_code -ne 0 ]]; then
    return_unity_license
    exit $exit_code
  fi
}

brew tap caskroom/cask

brew install mono
brew cask install android-sdk bugsnag/unity/unity-2017-4-1f1

yes | sdkmanager "platforms;android-27"
yes | sdkmanager --licenses

# activate Unity
/Applications/Unity/Unity.app/Contents/MacOS/Unity -quit -batchmode -serial $UNITY_SERIAL -username $UNITY_USERNAME -password $UNITY_PASSWORD -logFile unity.log
# usage suggests that sometimes this can take longer than the command so wait for the above command to take effect
sleep 10

# turn off errexit here as we need to return the unity license even if these commands fail
set +e

# build the plugin
bundle exec rake plugin:export || handle_failure $?

# copy it to the directory that is being synchronised with S3
cp Bugsnag.unitypackage ~/$TRAVIS_BUILD_NUMBER || handle_failure $?

set -e

return_unity_license
