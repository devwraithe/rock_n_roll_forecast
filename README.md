# Rock 'n' Roll Band Weather Track

**NasaAPod** is a cross-platform mobile application (Android and iOS) to track weather in a fashion manner for a rock'n'roll band staff. Note that the `master` branch is the most up-to-date.

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
- IDE with Flutter SDK installed (Visual Studio Code, Android Studio e.t.c)
- Knowledge of Dart and Flutter
- Emulator or Mobile Device
- Knowledge of Environment Variables (particularly [envied](https://pub.dev/packages/envied))
- Hands to code :smile:


## 🔒 Setting Up Environment Variables

This project utilizes environment variables to manage configuration settings. I use [Envied](https://pub.dev/packages/envied) to handle environment variable management.

To set up the required environment variables for this project, please refer to the Envied documentation:

Visit the [Envied](https://pub.dev/packages/envied) package documentation on [pub.dev](https://www.pub.dev).
Follow the instructions provided in the documentation to install and configure Envied for your development environment.
Envied simplifies the management of environment variables and ensures consistent and secure handling of sensitive information. Make sure to set the required environment variables as specified in the project's configuration files.

For more information on how to work with environment variables in this project, please consult the documentation provided by Envied.

**NOTE**: You need to setup Envied before running the project else you'll get errors.


## 🚀 Getting Started

To get started with this prototype, follow these steps:

1. Clone the repository to your local machine

```sh
$ git clone https://github.com/devwraithe/rock_n_roll_forecast
```

2. Navigate to the project directory

```
$ cd rock_n_roll_forecast
```

3. Install the necessary dependencies

```sh
$ flutter pub get
```

4. Run the application on an emulator or mobile device

```sh
$ flutter run
```
