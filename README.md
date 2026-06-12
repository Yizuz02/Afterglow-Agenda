# Afterglow Agenda

A retro-inspired productivity app built with Flutter and Firebase.

Afterglow Agenda combines task management, notes, reminders, collaboration, and productivity tools inside a nostalgic pixel-art experience inspired by Windows 95, CRT displays, and vaporwave aesthetics.

## Features

### Current
- User authentication
- Task management
- Real-time synchronization
- User profiles

### Planned
- Collaborative task lists
- Reminders and notifications
- Attachments (images, PDFs, voice notes)
- Productivity analytics
- Offline mode
- AI-assisted task planning
- Custom themes
- Pixel-art desktop interface
- Vaporwave-inspired UI

## Tech Stack

- Flutter
- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- Firebase Cloud Messaging
- Firebase Analytics
- Firebase Remote Config
- Cloud Functions

## Project Structure

```text
lib/
├── core/
│   ├── constants/
│   ├── theme/
│   ├── services/
│   └── utils/
│
├── features/
│   ├── auth/
│   ├── tasks/
│   ├── notes/
│   ├── notifications/
│   ├── profile/
│   └── settings/
│
├── shared/
│   ├── widgets/
│   ├── models/
│   └── providers/
│
└── main.dart
```

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Firebase Account
- Android Studio or VS Code

### Installation

Clone the repository:

```bash
git clone https://github.com/yourusername/afterglow-agenda.git
cd afterglow-agenda
```

Install dependencies:

```bash
flutter pub get
```

Configure Firebase:

```bash
flutterfire configure
```

Run the application:

```bash
flutter run
```

## Firebase Services

| Service | Purpose |
|----------|----------|
| Authentication | User login and registration |
| Firestore | Real-time database |
| Storage | File uploads |
| Cloud Messaging | Push notifications |
| Analytics | Usage metrics |
| Remote Config | Feature flags |
| Functions | Backend automation |

## Design Philosophy

Afterglow Agenda aims to recreate the feeling of using a personal computer in the late 90s while providing modern productivity features.

Visual inspirations include:

- Windows 95
- Vaporwave
- CRT monitors
- Pixel art
- Retro desktop interfaces
- Synthwave aesthetics

## License

MIT License
