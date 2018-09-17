#!/bin/sh -ex

alias unity="/Applications/Unity/Unity.app/Contents/MacOS/Unity"

pushd "${0%/*}"
  pushd ../..
    package_path=`pwd`
  popd
  pushd ../fixtures
    git clean -xdf .
    log_file="$package_path/unity.log"
    project_path="$(pwd)/unity_project"

    unity -nographics -quit -batchmode -logFile $log_file \
      -createProject $project_path

    unity -nographics -quit -batchmode -logFile $log_file \
      -projectPath $project_path \
      -importPackage "$package_path/Bugsnag.unitypackage"

    cp Main.cs unity_project/Assets/Main.cs

    unity -nographics -quit -batchmode -logFile $log_file \
      -projectPath $project_path \
      -executeMethod "Main.CreateScene"

    unity -nographics -quit -batchmode -logFile $log_file \
      -projectPath $project_path \
      -buildOSXUniversalPlayer "$(pwd)/Mazerunner.app"
  popd
popd
