# Task Manager App

## Overview

The Task Manager App is a Flutter application designed to help users manage their tasks efficiently. The app includes features for user authentication, task CRUD operations, pagination, and local data persistence using SQLite. It is designed following Flutter best practices, with robust state management and comprehensive unit tests to ensure functionality.

## Features

- **User Authentication**: Secure login using username and password.
- **Task Management**: Add, view, edit, and delete tasks.
- **Pagination**: Efficiently fetch large numbers of tasks.
- **State Management**: Efficiently managed state using Provider.
- **Local Storage**: Persistent local storage using SQLite.
- **Unit Tests**: Comprehensive unit tests covering core functionalities.

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK

### Installation

1. **Clone the repository:**

   git clone https://github.com/your-username/task-manager-app.git
   cd task-manager-app

2. **Install dependencies:**

    flutter pub get

3. **Run the app:**

    flutter run

4. **Project Structure:**

        lib/
    ├── models/
    │   └── task.dart
    ├── providers/
    │   └── task_provider.dart
    ├── screens/
    │   ├── login_screen.dart
    │   └── task_screen.dart
    ├── services/
    │   └── task_service.dart
    ├── utils/
    │   └── storage_util.dart
    ├── widgets/
    |   ├── task_form.dart
    │   └── task_tile.dart
    └── main.dart

5. **Running Unit Tests:**

    flutter test