# :thinking: **What is a CMS?**

The Content Managment System _(CMS)_ aims to allow users to create/modify/delete/supervise content in a user-friendly way, without coding or accessing any service console such as Google/Firebase or connecting directly to the database.

Examples of CMS applications:
- **Wordpress**: Users are able to add, modify or remove articles, content or shopping items
- **Medium**: Users are able to add, modify, or remove articles.

It encourages more people from different backgrounds to contribute and take action, like creating CrowdActions or modifying existing ones. Access to the application is restricted to users who have been assigned the **ADMIN** or **MODERATOR** role. 

To test the app, please use the following link:
- https://collaction-development.web.app/

# 🏗️ **Setting up the project**

## Clone the repo
https://github.com/CollActionteam/collaction_cms.git

## Fill environment variables
Make a copy of the `env.example` file, name it `env`, and fill out the missing secrets. You can ask other members of the team for the secrets, but also you can find the secrets in **Firebase console / Collaction-development project  / Project Settings** and in **Your apps** section choose **API - WEB APP**. You’ll find the secrets below **SDK setup and configuration**, just copy and paste the values of `firebaseConfig` into the `env` file accordingly.

:warning: It’s important to name the `env` file as env without the `.` prefix, because right now Firebase hosting has a rule that ignores files with `.` prefix like `.env`.

## Api config
To test the api locally fill the variable `BASE_API_ENDPOINT_URL` with `http://localhost:3000/api` and run the api locally, you can follow the tutorial to set up the api locally. To test the api on development, just fill `BASE_API_ENDPOINT_URL` with `https://devapi.collaction.org`.

## Install the dependencies
On the root path of the project run `flutter pub get` on the command.

## Firebase configuration
Firebase config is managed by `FirebaseOptionsFactory` inside `generate_firebase_options.dart` this factory is going to generate a `FirebaseOptions` object based on `env` values. So no action is needed.

Check firebase configuration documentation [here](https://docs.collaction.org/configuring-firebase)

## Generating Code
In order to generate code related to `freezed` , `injectable` , `json_serializable`. Choose a command to run when you need to build or re-build these files.

The watch command keeps re-building generated files. It’s generally not recommended to use

 `flutter pub run build_runner watch --delete-conflicting-outputs`

If you want to build generated files once run this command, It’s preferred.

`flutter pub run build_runner build --delete-conflicting-outputs`

Sometimes, the values of the generated files don’t update properly, If that’s the case, one solution could be to run the following command before running the above commands.

`flutter pub run build_runner clean`.

## Running the project

**Firebase Emulator (Preferred method)**

After running `build_runner` command, run `flutter build web` command to build the web directory. To test the routes it’s important to create a `404.html` file inside web/build and copy the content of the file `index.html` into `404.html` . This way of running the project should work with the **api** running locally, as long as the `ADMINCMS_URL` variable in `.env` file of the **api** project is set to `http://localhost:55714`.

The command to run the firebase emulator is: `firebase emulators:start`.

**Flutter run**

Run the command  `flutter run -d chrome --web-port=<ADMINCMS_URL port>`.

:warning: **Considerations**

It has been reported some memory problems because Flutter appears to generate files in `.../Local/AppData/Temp` folder when running on Chrome `flutter run -d chrome` . Therefore it is recommended to check that folder for the presence of `flutter_tools` folders and erase them. 
