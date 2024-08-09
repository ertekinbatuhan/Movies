<h1 align="center">Movies App</h1>

<p align="center">
  The Movies App is an iOS application that allows you to view trending movies, TV shows, and popular movies using the TMDB API.
</p>

## Features

- Trending movies and TV shows
- Popular movies
- Detailed movie and TV show information
- User-friendly interface
- Modern design with SwiftUI

## Screenshots

<div style="display: flex; justify-content: space-between;">
    <img src="https://github.com/ertekinbatuhan/Movies/assets/101355515/84cfb598-9408-4732-9590-5054946bfe72" alt="image1" width="200" style="margin-right: 10px;">
    <img src="https://github.com/ertekinbatuhan/Movies/assets/101355515/9308a991-25c3-45f0-b41e-f31e984f182b" alt="image2" width="200" style="margin-right: 10px;">
    <img src="https://github.com/ertekinbatuhan/Movies/assets/101355515/a50b7592-edb0-4a98-9961-443d3aa8f956" alt="image3" width="200" style="margin-right: 10px;">
    <img src="https://github.com/ertekinbatuhan/Movies/assets/101355515/abb0719f-d3c7-42a4-9530-f752fade58a7" alt="image4" width="200">
</div>

<div style="display: flex; justify-content: space-between;">
    <img src="https://github.com/ertekinbatuhan/Movies/assets/101355515/4acd3702-e7e8-41d0-9266-ef53916183e1" alt="image1" width="200" style="margin-right: 10px;">
    <img src="https://github.com/ertekinbatuhan/Movies/assets/101355515/ed7e98e8-237d-4cdc-b1c9-e80582e17939" alt="image2" width="200" style="margin-right: 10px;">
    <img src="https://github.com/ertekinbatuhan/Movies/assets/101355515/d9802b6a-2e18-46af-863e-2092c2378204" alt="image3" width="200" style="margin-right: 10px;">
    <img src="https://github.com/ertekinbatuhan/Movies/assets/101355515/885f68c8-84ad-44ad-bcaa-2b30b71cec60" alt="image4" width="200">
</div>

## Technologies Used
- Swift
- SwiftUI
- TMDB API

 ## Architecture Used
The Finance Tracker app is built using the MVVM (Model-View-ViewModel) architectural pattern. This architecture helps to separate the business logic and data handling from the user interface, making the app more modular, testable, and maintainable.

- **Model**: Represents the data and business logic of the application. It handles the data operations and communicates with external services or databases.
- **View**: The user interface of the app, responsible for displaying the data and handling user interactions.
- **ViewModel**: Acts as an intermediary between the Model and the View. It processes the data received from the Model and prepares it for display in the View, also handling user input and updating the Model accordingly.

![Screenshot 2024-08-09 at 12 31 02](https://github.com/user-attachments/assets/f79044cc-7b40-4d2f-abc1-716dd6384964)

## API Usage

The application uses the following TMDB API endpoints:

- [Trending movies and TV shows](https://api.themoviedb.org/3/trending/all/day)
- [Discover TV shows](https://api.themoviedb.org/3/discover/tv)
- [Popular movies](https://api.themoviedb.org/3/movie/popular)


## Installation

1. Clone this repository:

```bash
git clone https://github.com/ertekinbatuhan/Movies.git

```

2. Navigate to the project directory:
  ```bash
cd Movies
```
3. Open the project with Xcode:
```bash
open Movies.xcodeproj

```
4. Get your TMDB API key and add it to the APIService.swift file:
```bash
let apiKey = "YOUR_TMDB_API_KEY"
```

5. Run the project.


