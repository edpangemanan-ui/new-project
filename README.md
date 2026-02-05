# Inventory Realtime (Flutter + Firebase)

Project scaffold for a realtime inventory system that runs on Windows and Android using Flutter and Firebase (Firestore, Auth). Includes phone authentication, barcode scanning (`mobile_scanner`), and offline-first behavior.

## Quick setup
1. Install Flutter SDK and enable Windows desktop: `flutter doctor` and `flutter config --enable-windows-desktop`.
2. Create a Firebase project at the Firebase Console.
3. Enable **Authentication** (Phone) and **Cloud Firestore**.
4. Add an Android app and Windows app in Firebase and download `google-services.json` for Android. For Windows follow the Firebase C++ setup notes (links in Firebase docs).
5. Copy config files into the project as explained in the Firebase setup.
6. Run the app:
   - `flutter pub get`
   - `flutter run -d windows` (Windows)
   - `flutter run -d <device>` (Android)

## Local development
Use the Firestore Emulator for local testing. Configure `firebase.json` / `firestore.rules` as needed.

## Notes
- `mobile_scanner` is used for barcode scanning on Android devices.
- Phone authentication requires setting up the phone number sign-in method and may require reCAPTCHA or app verification on Android. For development you can add test phone numbers in Firebase Console under Authentication ▶ Sign-in method ▶ Phone (Test numbers).
- Android permissions: add `CAMERA` permission in `AndroidManifest.xml` and optionally request runtime permission before starting the scanner.
- For local development use the Firebase Emulators (Auth + Firestore) to avoid real SMS charges and to speed up testing.

## Files added
- `lib/main.dart` — app entry and Firebase init
- `lib/services/*` — firebase, auth, product services
- `lib/screens/*` — login, product list, product form
- `firestore.rules` — sample security rules
- `tools/seeder.dart` — small Firestore seeder script

