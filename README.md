# Poo Timer

Simple Timer app to reduce time-wasting while using the bathroom.

Look out for more updates to come!

Note: Pragma marks (`// MARK:`) have been added to `PooTimerView.swift` and `CountdownView.swift` to indicate where audio is prevented from playing by default. Uncomment lines of the form `// ____Player.play()` to turn on locally. These will be turned off by default in later iterations, with user Settings to turn them on.

## Screenshots
<p align="center">
  <img src="https://i.imgur.com/3brmglz.png" alt="Home Screen" width="200"/>
  &nbsp
  <img src="https://i.imgur.com/auu9eYL.png" alt="Home Screen" width="200"/>
  &nbsp
  <img src="https://i.imgur.com/nzYVmd1.png" alt="Home Screen" width="200"/>
</p>
<p style="text-align: center;">From left to right: Home Screen, Settings Screen, Timer Screen.</p>


## Future Work
1. Update "Back" button title to "Home" on Timer screen.
1. Add AppIcon(s).
1. Add slowly filling image for duration of timer.
1. Allow initial timer arc to show a small white section at the top.
1. Settings additions:
  1. Manually start timer on Timer screen.
  1. Turn sound on/off (default: off).
  1. Add different filling Timer screen image options (Roses, Children to school, "2", monarch on a throne)
1. Make duration selection a pickerwheel, including seconds? This would require an overhaul of the numbers being passed around.
1. Store audio filenames in enum, rather than as hardcoded strings.
1. Add loading view, for any delay.
1. Set the initial value throughout the app at one source, instead of using hardcoded "3" minutes or "180" seconds in various places.
1. Extract custom font sizes into separate files.

### Known Issues
1. Colors aren't the same in dark mode.
1. Audio does not play in background.
1. Audio does not play in silent mode.
