Android setup notes:

- Place `google-services.json` in `android/app/`.
- Add the following permission in `android/app/src/main/AndroidManifest.xml` within `<manifest>`:

  <uses-permission android:name="android.permission.CAMERA" />

- For Firebase phone auth on Android, ensure you have a valid SHA-1 (and optionally SHA-256) fingerprint added to the Firebase Android app settings.
- During development, use Firebase Auth test phone numbers to avoid SMS charges.
