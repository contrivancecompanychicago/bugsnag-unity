When("I run the MacOS application") do
  `features/fixtures/mazerunner.app/Contents/MacOS/mazerunner -batchmode -nographics`
end

When("I run the Android application") do
  emu = AndroidEmulator.new("nexus")
  emu.run_application "features/fixtures/mazerunner.apk",
    "com.bugsnag.mazerunner",
    "com.unity3d.player.UnityPlayerActivity"
end
