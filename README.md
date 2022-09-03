# Unlimited Word Guesser (Wordle)
A SwiftUI-based recreation of the popular game [Wordle](https://www.nytimes.com/games/wordle/index.html), featuring different word sizes, user profile, and stats. 

My parents absolutely love Wordle and have played it everyday since it went viral, with one downside: "one word per day". As a result, I decided to recreate the popular website for iOS 16 with [SwiftUI](https://developer.apple.com/documentation/swiftui/) and add in a few fun features for them.

As my first published project on GitHub, any feedback/advice is very much appreciated!

## Overview & Functionality
 
- Classic Wordle Structure: An n-length word randomly chosen from a word bank with n+1 guesses allowed
- Flagging of word correctness by color 
- 4 different game modes: 5-Letter, 6-Letter, 7-Letter, 8-Letter
- Unlimited rounds! Cycle through all 5000+ words if you have the time!

<p float="left">
<img src="https://user-images.githubusercontent.com/108420692/188286237-82f1dfbf-3396-42e5-aa19-1ecbfe3ab3eb.PNG" width=20% height=20%>
<img src="https://user-images.githubusercontent.com/108420692/188286219-3f3f6314-feeb-4af9-b574-887deb8dd3ca.PNG" width=20% height=20%>
<img src="https://user-images.githubusercontent.com/108420692/188286243-b84d7c74-6c85-4b9c-84f6-d556e3c29212.PNG" width=20% height=20%>
<img src="https://user-images.githubusercontent.com/108420692/188286246-50afd961-c72a-4649-b67b-a9a396a9f805.PNG" width=20% height=20%>
</p>


- User Profile:
   - App only requests name and no other personal information.
   - Individual statistics for each game mode 
   - Aggregated statistics for all game modes
   - Delete all data and progress on demand

 
## Data Modeling
- After several iterations, I decided on utilizing a singleton Class to contain app state management, game objects, theming, and profile information. Classes and Structs were used accordingly for modeling lower-level objects. Several Enum properties, when updated, manage view states and initiate functions. 

  A quick breakdown:
  - *App Manager*: Container for all lower objects.
    - *GameManager*: Primary object application functions interact with. Contains logic for initiating new rounds.
      - *Round*: Instances of new words to be guessed. 
        - *Guess*: - Model for user input.
          - *GuessLetter*: Model for each letter of user's guess.
- *Check Spelling* & *CheckWord* functions: The bread and butter of the app! 
  - *Check Spelling* validates whether a user's guess is a real word or not. If validation returns true, *CheckWord* then processes the user's guess and compares it to the actual word solution by comparing individual characters. 
  - *CheckWord*, in descending order, scans for a full word match, a correct letter with placement, a correct letter with correct placement, and incorrect letters, and updates associated enums accordingly. Currently, these functions reside in the *EnterButton* view, and should be broken down/moved out of the view.

## Technologies & Design

**Swift & SwiftUI 4, targeted for iOS 16.0**
  - Composing views is very efficient in SwiftUI and becoming increasingly popular. I wanted to familiarize myself with SwiftUI design patterns as well as demonstrate a working app. A best practice I learned was to make view components as small and light as possible and group them within parent views. 
  - [NavigationStack](https://developer.apple.com/documentation/swiftui/navigationstack) (trivial implementation, as navigation was pushed with .sheet modifiers and navigationLinks)
  - [ShareLink](https://developer.apple.com/documentation/SwiftUI/ShareLink): Result sharing with link to app (production link would redirect to appstore listing, current link redirects to this repo)
 
**Design**
- App-wide accent color theming
- Light and Dark mode support
- Support for iPhone & iPad
- Utilized multicolor SF Symbols for composing the puzzle gride and keyboard. Using images instead of text for letters enables easy resizing and scaling for different-sized devices length of words being guessed. Coloring of letters, buttons, and grid depend on ternary operators reacting to enum and boolean changes after a user submits their guess.
- Closely-followed Apple Design guidelines for most view componenents
- "Fun" implementation of custom view components, such as the StatsToShow picker in Settings residing in a section header.

## Future Improvements
- Add customizable Notification support for reminding user to interact with app
- Data Persistance & Environment Object singleton
  - Change instance of AppManager class to an Environment Object. Due to the app's "simple" nature, a singleton instance would be sufficient.
  - Refactor several @Binding and @ObservedObject to reduce occurences of unnecessary data being injected into views
  - Add data persistance via CoreData. As of right now, all changes/progress/events exist as an instance during runtime.
- Move some remaining business logic currently in view models into applicable data models
- Update CustomKeyboard. Although individual keyboard button sizes scale correctly with varying device screens, my current implementation of SFSymbols has led to "stretched" letters
- Create a "Hint" function and Button that, when tapped, would reveal to the user a random, unused letter after a number of unsuccessful guesses.
- Implement Additional SWiftUI 4 / iOS 16 technologies
  - Charts for User Stats
  - Implement ViewThatFits for horizontal device orientation
- Enable Sign in with Apple


