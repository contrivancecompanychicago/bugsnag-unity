#!/bin/sh -ue

brew cask install \
  mono-mdk \
  android-sdk \
  bugsnag/unity/$UNITY_VERSION

export PATH="$PATH:/Library/Frameworks/Mono.framework/Versions/Current/Commands"

yes | sdkmanager "platforms;android-27"
yes | sdkmanager --licenses

curl -o ndk.zip https://dl.google.com/android/repository/android-ndk-r16b-darwin-x86_64.zip
unzip -qq ndk.zip
mv android-ndk-r16b $ANDROID_NDK_HOME
rm ndk.zip

bundle exec rake travis:export_plugin

# copy it to the directory that is being synchronised with S3
cp Bugsnag.unitypackage ~/$TRAVIS_BUILD_NUMBER
