# Poo Timer

This app was built to reduce time-wasting while using the bathroom. Inspired by the gag gift below, it is designed for folx that are susceptible to being drawn into distractions and forgetting about the business at hand. All that the user has to do is to select a target timer duration via the Settings screen, then tap the Start Timer button to begin the countdown. The user can see the timer counting down to 0:00 or background the app and do whatever they wish. A few minutes later, the user gets an alert (audible if the app is active/notification with custom audio if the app is backgrounded) when the target time has elapsed.

<p align="center">
  <img src="https://i.imgur.com/fOgitO9.jpeg" alt="Home Screen" width="300"/>
</p>
<p align="center">The gag gift that is the inspiration for this app.</p>

Look out for more updates to come!

## App Structure
To be added.

## Screenshots
<p align="center">
  <img src="https://i.imgur.com/2vdwPW4.png" alt="Home Screen" width="200"/>
  &nbsp
  <img src="https://i.imgur.com/jXgeDxx.png" alt="Home Screen" width="200"/>
  &nbsp
  <img src="https://i.imgur.com/jeH6Vh2.png" alt="Home Screen" width="200"/>
</p>
<p align="center">From left to right: Home Screen, Settings Screen, Timer Screen.</p>

## Learnings
One wish for this app was to play an audio file at the end of the user's timer, even while the app was backgrounded. I learned that although it is possible to continue an audio session into a background state (I implemented this for the starting audio file), it is not possible to start an audio session from a backgrounded state without user/server intervention or a hacked solution. These solutions include:

> [!NOTE]
> The simulator will play delayed audio, although a real device will not.

| Solution | Description |
| -------- | ----------- |
| Silent Push Notification | Send a push notification to the app silently, and use it to trigger a new audio session. Silent Push Notifications can only be sent by a server, which is out of the scope of this project. |
| Background Fetch         | Can be used to start up a background task, however the trigger timing may not be precise and it may not occur at all, if system resources are limited. |
| Continuous silent audio  | A continuously playing silent audio file for the duration of the timer. This solution is "hacky" and not recommended: it may impact audio from other applications and it will impact phone battery life. |

I discovered that I can use a `UILocalNotification` to trigger a local push notification, including custom audio. I implemented this solution.

## Future Work
1. Update "Back" button title to "Home" on Timer screen.
1. Allow initial timer arc to show a small white section at the top.
1. Settings additions:
    1. Manually start timer on Timer screen.
    1. Add different filling Timer screen image options (e.g. Roses, Children to school, "2", monarch on a throne)
1. Make duration selection a pickerwheel, including seconds? This would require an overhaul of the numbers being passed around.
1. Add loading view, for any delay (this is unlikely to ever show, unless we add server interactions).
1. Set the initial value throughout the app at one source, instead of using hardcoded "3" minutes or "180" seconds in various places.
1. Extract custom font sizes into separate files.
1. Reactive sizing:
    1. Home screen emoji font size, e.g. minimum of screen width or height plus padding.
    1. Remaining time on Timer screen.
    1. Including max and min values for images and text—including consideration for iPad screens.
1. Change Timer value to text after time has expired.
1. Notification permissions:
    1. If user declines after the first request, let them know the consequence, and how to turn on Notifications in Settings. Add a link to Settings, if possible.
    1. Pop up permission alert if the user previously declined to receive notifications (not desirable unless a user can select not to be asked again).
1. Periodic alerts/sounds to remind the user about their business.
1. Different timers/themes. e.g. Kitchen/cooking, task completion.
1. Add launch screen file.
1. Handle settings load/save errors.
1. Restore iPad to supported destinations, when sizing is updated.

### Unknown questions to answer
1. Research whether navigating from my app to another via the "Back to [App]" button in the top left, or via a push notif, will impact the behavior of my scene change code. It isn't expected as I only check whether I am in the `.active` state.
1. If I background the app during a timer, then I kill the app from the background state, do I still receive a push notification?

## Known Issues/Bugs
1. After changing device orientation on the Timer screen, the space between the two main elements is reduced.

## Special Thanks
Thanks to the following for your contributions to the production of this application.

1. Vince Romani, Lydia McLaughlin and Allyson Vakhovskaya&mdash;former colleagues that provided feedback throughout the development process.
1. [Sound Jay](https://www.soundjay.com/index.html)&mdash;the source of all sound effects in the application, used in accordance with their [Terms of Service](https://www.soundjay.com/tos.html).
