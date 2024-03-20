# Rock 'n' Roll Band Weather Track

**Rock 'n' Roll Band Weather Track** is a cross-platform mobile application (Android and iOS) to track the weather fashionably for a rock'n'roll band staff. Note that the `develop` branch is the most up-to-date, I've been making regular changes to improve the product.

🧪 **Unit & Widget Tests! (90% coverage!)**

## Table of Contents
- [Features](#features)
- [Screenshots](#screenshots)
- [Requirements](#requirements)
- [Configuring Environment Variables](#configuring-environment-variables)
- [Getting Started](#getting-started)

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

## Features

This application has the following features
- A list of cities for upcoming concerts
- Search functionality (Find by city name)
- Offline support using Hive (works with airplane mode)
- Cross-platform (tested on Pixel 6a, iPhone 15 Pro and iPad Pro)
- Support for multiple resolutions and sizes (tested on Pixel 4 and Pixel C Tab)
- Shows current weather info for each city
- Shows the next 5 days forecast for each city

## Requirements

- Operating System (Windows, Linux, or MacOS)
- IDE with Flutter SDK installed (Visual Studio Code, Android Studio etc.)
- Knowledge of Dart and Flutter
- Emulator or Mobile Device
- Knowledge of Environment Variables (particularly [envied](https://pub.dev/packages/envied))
- Hands to code :smile:


## Configuring Environment Variables

This project utilizes environment variables to manage configuration settings. I use [Envied](https://pub.dev/packages/envied) to handle environment variable management.

To set up the required environment variables for this project, please refer to the Envied documentation:

Visit the [Envied](https://pub.dev/packages/envied) package documentation on [pub.dev](https://www.pub.dev).
Follow the instructions provided in the documentation to install and configure Envied for your development environment.
Envied simplifies the management of environment variables and ensures consistent and secure handling of sensitive information. Make sure to set the required environment variables as specified in the project's configuration files.

For more information on how to work with environment variables in this project, please consult the documentation provided by Envied.

**NOTE**: You need to set up Envied before running the project else you'll get errors.


## Getting Started

**1. Clone the Repository:** Open your terminal and clone the "rock_n_roll_forecast" repository to your local machine:

```sh
$ git clone https://github.com/devwraithe/rock_n_roll_forecast
```

**2. Navigate to the Project Folder:** Change your working directory to the project folder:

```
$ cd rock_n_roll_forecast
```

**3. Install the Dependencies:** Install the project's dependencies using **pub** (Dart Package Manager):

```sh
$ flutter pub get
```

### Usage

To run and use the application, ensure you have either an emulator or a mobile device connected to your IDE. **[Here](https://developer.android.com/design-for-safety/privacy-sandbox/download#:~:text=Set%20up%20an%20Android%20device%20emulator%20image,-To%20set%20up&text=In%20Android%20Studio%2C%20go%20to,it%20isn't%20already%20installed.)** is a guide from the Android Developers' documentation to help you set up a device or an emulator.

**1. Run the Application:** To start the "rock_n_roll_forecast" application, run the following command:

```sh
$ flutter run
```


### Testing
The `test` folder is similar to the `lib` folder in addition to some test utilities. More tests are being added.

[`mockito`](https://pub.dev/packages/mockito) is used for creating mocks and stubs in unit tests to isolate and emulate dependencies.

[`bloc_test`](https://pub.dev/packages/bloc_test) is used for testing BLoC implementations by providing utilities for mocking.
  
To explore the test coverage, run tests with the --coverage argument

```sh
$ flutter test --coverage
```

To generate coverage files for the test (You might need to install `lcov`, run `brew install lcov` to install on MacOS)

```sh
$ genhtml coverage/lcov.info -o coverage/html
```

To open the generated html file

```sh
$ open coverage/html/index.html
```
