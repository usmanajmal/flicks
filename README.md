
# Project 1 - *Flicks*

**Flicks** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **11** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can view a list of movies currently playing in theaters. Poster images load asynchronously.
- [x] User can view movie details by tapping on a cell.
- [x] User sees loading state while waiting for the API.
- [x] User sees an error message when there is a network error.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] Add a tab bar for **Now Playing** and **Top Rated** movies.
- [ ] Implement segmented control to switch between list view and grid view.
- [ ] Add a search bar.
- [x] All images fade in.
- [x] For the large poster, load the low-res image first, switch to high-res when complete.
- [x] Customize the highlight and selection effect of the cell.
- [x] Customize the navigation bar.

The following **additional** features are implemented:

- [x] Show a placeholder image when image is being loaded for better user experience
- [x] In case of network error, show same placeholder image and blank lines for title
      for better user experience
- [x] Added a Splash Screen

## Video Walkthrough

Here's a walkthrough of implemented user stories:

- [Flicks - Video Walkthrough](http://imgur.com/qr6YAP3)
- [Alternate Link to gif](http://i.imgur.com/qr6YAP3.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
[x] below means the problem encountered is fixed.

- [x] Had trouble initially with creating outlet for image view in prototype cell's class
  For somereason, the class and the storyboard weren't appear side-by-side
- [x] Hit uncaught exception 'NSUnknownKeyException'. Fixed it from Connections Inspector 
- [x] Navigation controller went haywire after adding tab controller. Problem was that
      I was setting view controller in tabBarController.viewController array instead of
      setting it to [nowPlayingNavigationController, topRatedNavigationController]
- [ ] In case of Network Error, tapping on placeholder cell breaks the app


## License

    Copyright [2016] [Usman Ajmal]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
