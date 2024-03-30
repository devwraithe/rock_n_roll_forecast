# Rock 'n' Roll Band Weather Track

**Rock 'n' Roll Band Weather Track** is a cross-platform mobile application (Android and iOS) to track the weather fashionably for a rock'n'roll band staff. Note that the `develop` branch is the most up-to-date, I've been making regular changes to improve the product.

![90% Tests Coverage](https://img.shields.io/badge/Tests_Coverage-90%25-green)

## Table of Contents
- [Features](#features)
- [Screenshots](#screenshots)
- [App Architecture & Folder Structure](#app-architecture-and-folder-structure)
- [Requirements](#requirements)
- [Configure Environment Variables](#configure-environment-variables)
- [Getting Started](#getting-started)
    - [Running the project](#running-the-project)
    - [Running tests](#running-tests)

## Features
This application has the following features
- A list of cities for upcoming concerts
    - Silverstone, UK
    - São Paulo, Brazil
    - Melbourne, Australia
    - Monte Carlo, Monaco
- Search functionality (Find by city name)
- Offline support using Hive (works with airplane mode)
- Cross-platform (tested on Pixel 6a, iPhone 15 Pro and iPad Pro)
- Support for multiple resolutions and sizes (tested on Pixel 4 and Pixel C Tab)
- Shows current weather info for each city
- Shows the next 5 days forecast for each city

## Screenshots
### Android
<div style="display: flex;">
    <img src="assets/images/github/android_1.png" alt="Image 1" width="32%"/>
    <img src="assets/images/github/android_2.png" alt="Image 2" width="32%"/>
</div>

### iOS
<div style="display: flex;">
    <img src="assets/images/github/ios_1.png" alt="Image 1" width="32%"/>
    <img src="assets/images/github/ios_2.png" alt="Image 2" width="32%"/>
</div>

## App Architecture and Folder Structure

The project adopts Clean Architecture principles to segregate the Presentation, Domain, and Data layers, and also employing a feature-first approach to folder structuring facilitates maintenance.

```
lib
├── app
│   ├── modules
│   │   └── weathers
│   │       ├── data
│   │       │   ├── datasources
│   │       │   ├── models
│   │       │   ├── repositories
│   │       ├── domain
│   │       │   ├── adapters
│   │       │   ├── entities
│   │       │   ├── repositories
│   │       │   ├── usecases
│   │       └── presentation
│   │           ├── cubits
│   │           ├── screens
│   │           └── widgets
│   ├── shared
│   │   ├── errors
│   │   ├── helpers
│   │   ├── routes
│   │   ├── services
│   │   ├── theme
│   │   └── utilities
│   └── app.dart
└── main.dart
```
- `main.dart` file serves as the app's entry point, initializing the app's components and configurations.
- `modules` folder organizes the codebase into feature-specific modules, each containing it's own `data`, `domain`, and `presentation` layers.
- `shared` folder hosts reusable components and utilities utilized across features.
    - `helpers` folder contains specific utility functions, classes, or modules designed to assist with particular tasks.
    - `services` folder encompasses modules responsible for providing various application-wide services, such as networking.
    - `utilities` folder houses general-purpose utility functions, classes, or modules that serve a wide range of functionalities.

## Requirements
- Operating System (Windows, Linux, or MacOS)
- IDE with Flutter SDK installed (Visual Studio Code, Android Studio, etc.)
- Knowledge of Dart and Flutter
- Emulator or Mobile Device
- Knowledge of environment variables
- Hands to code :smile:


## Configure Environment Variables

**NOTE:** This project uses Flutter `version 3.13.8`

You will need to have environment variables configured for the project to function properly, if you don't you will encounter errors particularly while trying to fetch weather information. Fear not though 😁, the bulk of the work has been done so all you need is to get your OpenWeather APP ID (or API KEY) that will be used to fetch weather information and create a `.env` file.

To get your OpenWeather APP ID, visit [this link](https://home.openweathermap.org/api_keys) (if you do not have an OpenWeather account yet, you will need to create one)

**Create a `.env` file in the base of your project**

```
rock_n_roll_forecast
...
├── ...
├── .env
├── ...
└── ...
```

**Add the following to the `.env` file**

```env
APP_ID=APP ID from OpenWeather API
BASE_URL=https://api.openweathermap.org
```

## Getting Started

**NOTE:** This project uses Flutter `version 3.13.8`

**1. Clone the Repository:** Open your terminal and clone the "rock_n_roll_forecast" repository to your local machine:

```yaml
$ git clone https://github.com/devwraithe/rock_n_roll_forecast
```

**2. Navigate to the Project Folder:** Change your working directory to the project folder:

```yaml
$ cd rock_n_roll_forecast
```

**3. Install the Dependencies:** Install the project's dependencies using **pub** (Dart Package Manager):

```yaml
$ flutter pub get
```


### Running the project

Please make sure you have either an emulator or a mobile device connected to your IDE. **[Here](https://developer.android.com/design-for-safety/privacy-sandbox/download#:~:text=Set%20up%20an%20Android%20device%20emulator%20image,-To%20set%20up&text=In%20Android%20Studio%2C%20go%20to,it%20isn't%20already%20installed.)** is a guide from the Android Developers' documentation to help you set up a device or an emulator.

**NOTE:** You must configure environment variables as instructed [**here**](#configure-environment-variables) for the project to function properly.
 
**Option 1:** If you intend to run the project via the command line using `flutter run`, you will need to attach additional arguments to the command to be able to pull the environment variables from the `.env` file and include it in the project at compile-time.

```yaml
flutter run --dart-define-from-file=.env
```

**Option 2:** If you'd prefer to run the project directly on Android Studio or Visual Studio Code (not in the command line), you should edit your **Run/Debug** configuration, the below image shows how you can configure your `main.dart` on Android Studio to include your `.env` at compile-time.

<img width="1058" alt="Screenshot 2024-03-30 at 10 27 44 AM" src="https://github.com/devwraithe/rock_n_roll_forecast/assets/39105147/22c09f26-48aa-40a0-a089-59b4ebaac1d8">

### Running tests
The `test` folder is similar to the `lib` folder with the addition of some utilities for testing. More tests are being added.

[`mockito`](https://pub.dev/packages/mockito) creates mocks and stubs in unit tests to isolate and emulate dependencies.

[`bloc_test`](https://pub.dev/packages/bloc_test) is used for testing BLoC implementations by providing utilities for mocking.
  
To explore the test coverage, run tests with the --coverage argument

```yaml
$ flutter test --coverage
```

To generate coverage files for the test, you might need to install `lcov` if you don't have it installed already. To install on **MacOS** & **Linux**, run `brew install lcov` and to install on **Windows**, run `choco install lcov`, then you should run the following code to generate the test coverage:

```yaml
$ genhtml coverage/lcov.info -o coverage/html
```

To open the generated html file

```yaml
$ open coverage/html/index.html
```
