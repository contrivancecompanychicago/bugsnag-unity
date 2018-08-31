#!/bin/sh -ue

# copy the package to the root
cp ~/$TRAVIS_BUILD_NUMBER/Bugsnag.unitypackage ./

if [[ -z "${ANDROID_TARGET}" ]]; then
  yes | sdkmanager "platforms;$ANDROID_TARGET"
  android list targets
  jdk_switcher use oraclejdk8
  echo no | android create avd --force -n nexus -t $ANDROID_TARGET --abi $ANDROID_ABI
  bundle exec rake travis:mazerunner\[android\]
else
  bundle exec rake travis:mazerunner\[macos\]
fi
