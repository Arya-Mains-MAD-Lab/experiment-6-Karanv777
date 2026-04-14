## Name : Karan Verma
## Roll Number : 23EACAD058
## Experiment Title : SQLite Database Application
## Aim : To study and implement local database operations in Flutter using SQLite and perform CRUD (Create, Read, Update, Delete) operations.

## Procedure
- Install Flutter SDK
   - Download and install the Flutter SDK from the official website and set up environment variables.
   - Verify installation using:
     ```bash
     flutter doctor
     ```

- Install Android Studio
   - Install Android Studio and configure it with Flutter and Dart plugins.

- Create a New Flutter Project
   - Open Android Studio
   - Click on New Flutter Project
   - Select Flutter Application
   - Enter project name and location
   - Click Finish

- Add Required Dependencies
   - Open `pubspec.yaml`
   - Add the following dependencies:
     ```yaml
     sqflite_common: any
     sqflite_common_ffi_web: any
     path: any
     ```
   - Run:
     ```bash
     flutter pub get
     ```

- Write the Source Code
   - Open the `main.dart` file and replace the existing code with the given program.
   - The program uses SQLite database to perform CRUD operations:
      - Create database and table
      - Insert student data
      - Fetch and display records
      - Delete records

- Initialize Database for Web
   - Use:
     ```dart
     databaseFactory = databaseFactoryFfiWeb;
     ```
   - This enables SQLite support on Flutter Web.

- Connect Device/Emulator
   - Run the app on:
      - Android Emulator OR
      - Flutter Web browser

- Run the Application
   - Click Run button or use:
     ```bash
     flutter run
     ```

- Observe the Output
   - The app allows:
      - Adding student names
      - Displaying stored records
      - Deleting records
   - Data is stored locally using SQLite.

## Output: A Flutter application displaying a list of students with options to add and delete records using SQLite database.

- <img width="1297" height="1002" alt="image" src="https://github.com/user-attachments/assets/bffb0bf4-cb32-466f-b962-a4eab0c8ae19" />


## Conclusion : The experiment was successfully completed by implementing SQLite database operations in Flutter and performing basic CRUD functionality on student records.
