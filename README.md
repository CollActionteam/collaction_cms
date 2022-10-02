# CollAction AdminCMS

CollAction cross-platform AdminCMS project (iOS/Android/Web).

## Code Generation

In order to generate code related to `freezed`, `injectable`, `json_serializable`, etc. choose a
command to run when you need to build or re-build these files:

_The watch command keeps re-building generated files. It is generally not recommended to use._

```bash
  flutter pub run build_runner watch --delete-conflicting-outputs
```

_If you want to build once you are done with your changes, to build generated files once run this
command, it's preferred._

```bash
  flutter pub run build_runner build --delete-conflicting-outputs
```

## Imutable app settings

We use an environment file called `.env` to define secrets used in the application. `
These secrets are bundled with the application at build-time.

Make a copy of the `.env.example` file, name it `.env` and fill out the missing secrets.

## Firebase

TBD

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
