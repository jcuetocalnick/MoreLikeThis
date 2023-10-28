Original App Design Project - README Template
===

# MoreLikeThis

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview
### Description: app that allows user to enter either a movie, book, or series and app will populate more of this content that the user might also like.

### App Evaluation
[Evaluation of your app across the following attributes]

- **Category: The app is an entertainment recommendation app.**
- **Mobile: The app is primarily tageted towards mobile devices, specifically iOS devices, but is also adaptable to iOS tablet screens.**
- **Story: The apps main story or feature is its ability to help users find new content that is similar to what they already enjoy.**
- **Market: The targeted audience for this app is almost any one who is looking for new entertaining content as it is not restricted to one type of entertainment media. Any one from as young as 10 to as old as 100.**
- **Habit: The main habit forming feature is notifications and weekly release of new content for the users to sift through.**
- **Scope: The apps scope so far is limited to finding content for users such as books or movies along with detailed information about the content selected. The app currently does not have the ability to play that content or link you to a streaming or entertainment service to view the newly found content but could be something that can be implemented in the future.**

## Product Spec
### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [user can  scroll through a screen where a list of movies/books/shows are shown.]
* [user can switch screen by tapping on the tab bar at the bottom of the screen.]
* [user can click on movie/book/show to see more information about the specific.]
* [user can click on specific movie/book/show view and can click on "More Like this" button where more like the selected will be displayed.]
* [user will see a customized icon for the app.]
* [user will be prompted to launch-screen as soon as app launches.]

**Optional Nice-to-have Stories**

* [user has a search bar at the top of the screen where they can search for specific movie/book/show without having to scroll.]
* [user can favorite with a star icon their favorite book/movie/show.]
* [user can receive notifications when favorited has acquire a new "more like this".]


### 2. Screen Archetypes

- [ ] [LaunchScreen]
* [user will be prompted to launch-screen as soon as app launches.]
- [ ] [MovieViewController]
* [user can  scroll through a screen where a list of movies/books/shows are shown.]
 - [ ] [BookViewController]
* [user can  scroll through a screen where a list of movies/books/shows are shown.]
- [ ] [ShowViewController]
* [user can  scroll through a screen where a list of movies/books/shows are shown.]
- [ ] [DetailedViewController]
* [user can click on movie/book/show to see more information about that specific item.]
- [ ] [MoreLikeThisCellViewController]
* [user can click on specific movie/book/show view and can click on "More Like this" button where more like the selected will be displayed.]


### 3. Navigation

**Tab Navigation** (This is when the user switches between screens by simply clicking on a tab displayed at the top or bottom of the app.)
* [Book Tab]
* [Movie Tab]
* [TV-Show Tab]

**Flow Navigation** (This is when the user taps on something on a screen and is taken to another screen. From that screen, they can go back to the previous screen, or navigate to another screen.)

- [ ] [Main Content Screen (Latest or Most Popular)]
* [This will navigate to a detailed screen depending on the item selected from the main content screen]
- [ ] [The second screen is the MoreLikeThis screen]
* [To navigate to this screen the user must select More Like This from the detailed screen of the Mains screen selected item]

**LaunchScreen => ViewController**
from the launchScreeen we are re-directed to the viewController where we have the lists of our movies/books/shows.

**ViewController => DetailedViewController**
after clicked on specific movies/books/shows we are taken  to a screen where more detailed information about the selected is prompted to the user.

**MoreLikeThisCell => MoreLikeThisViewController**
after user clicks on the cell/ button to see more movies/books/shows like this user is taken to a different screen with more suggestions.


Wireframes
[Add picture of your hand sketched wireframes in this section] 

[BONUS] Digital Wireframes & Mockups
[BONUS] Interactive Prototype
Schema
[This section will be completed in Unit 9]

Models
[Add table of models]

Networking
[Add list of network requests by screen ]
[Create basic snippets for each Parse network request]
[OPTIONAL: List endpoints if using existing API such as Yelp]
