# Flutter Notes App

A simple, clean notes app built with Flutter, Firebase Authentication, and Firestore. Users can sign up, log in, and manage their personal notes securely.

---

## 🚀 Getting Started

### 1. **Clone the Repository**
```sh
git clone <your-repo-url>
cd Individual_assignment_2/individual_assignment_2
```

### 2. **Firebase Setup**
- Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
- Register your Android app with the package name `com.example.individual_assignment_2`.
- Add your emulator/device SHA-1 fingerprint in the Firebase Console.
- Enable **Email/Password** authentication in **Authentication > Sign-in method**.
- Download `google-services.json` and place it in `android/app/`.

### 3. **Install Dependencies**
```sh
flutter pub get
```

### 4. **Run the App**
- Start your Android emulator or connect a device.
- Run:
```sh
flutter run
```

---

## 📝 Features
- **Sign Up & Login**: Secure authentication with email and password.
- **Notes CRUD**: Add, edit, delete, and view notes in real time.
- **Firestore Integration**: Each user's notes are stored under their unique user ID.
- **Provider State Management**: Clean, maintainable state management.
- **Modern UI**: Responsive, user-friendly interface with SnackBars, dialogs, and loaders.
- **Error Handling**: All errors and successes are shown with SnackBars.

---

## 🗂️ Folder Structure
```
/lib
  /data
    - auth_repository.dart
    - notes_repository.dart
  /domain
    - note.dart
  /providers
    - auth_provider.dart
    - notes_provider.dart
  /screens
    - login_screen.dart
    - signup_screen.dart
    - notes_list_screen.dart
    - edit_note_screen.dart
  - main.dart
```

---

## 🛠️ How It Works
1. **Sign Up**: Create an account with email and password.
2. **Login**: Log in to access your notes.
3. **Notes List**: View all your notes. If none, see the hint: _"Nothing here yet—tap ➕ to add a note."_
4. **Add Note**: Tap the ➕ button, enter your note, and save.
5. **Edit Note**: Tap the blue pencil icon, edit, and save.
6. **Delete Note**: Tap the red trash icon, confirm deletion.
7. **Logout**: Tap the logout icon in the AppBar.

---

## 📋 Requirements
- Flutter SDK
- Android Studio or VS Code
- Firebase project with Email/Password Auth enabled
- Android emulator or device

---

## 📸 Screenshots
_Add screenshots of the app here if needed._

---

## 📖 License
This project is for educational purposes.
