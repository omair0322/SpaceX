# SpaceX Launches iOS Application

This project is an iOS application that displays information about SpaceX launches. The application is built using **Swift**, **Combine**, and **Alamofire**, and follows the **MVVM** architecture pattern for scalability and maintainability.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)

## Features

- **Launch List**: Displays a list of SpaceX launches with infinite scrolling.
- **Launch Detail View**: Detailed information about each launch, including rocket details, success status, media links, and mission patches.
- **Live API Data**: The app fetches real-time data from the SpaceX API using Alamofire and Combine.
- **Error Handling**: User-friendly error messages for network failures or other issues.
- **Combine Framework**: Used to handle asynchronous events and data streams.

## Requirements

- iOS 13.0 or higher
- Xcode 12.0+
- Swift 5.0+
- Swift Package Manager (SPM)

## Installation

### 1. Clone the Repository

Run the following command in your terminal to clone the project:

```bash
git clone https://github.com/omair0322/SpaceX.git
cd spacex-ios
