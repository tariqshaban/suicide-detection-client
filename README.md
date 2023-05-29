Displaying a Suicide Text Classification Model Results from a Restful API
==============================
This is a supplementary submission of **final paper** for the **CIS737** course.

It contains the code necessary to issue a RESTful API request by providing a text, and classifying it to whether it is
suicidal or not.

To view a live example, [click here](https://tariqshaban.github.io/suicide-detection/).

Getting Started
------------
Clone the project from GitHub

`$ git clone https://github.com/tariqshaban/suicide-detection-client.git`

The project is an implementation of [suicide-detection](https://github.com/tariqshaban/suicide-detection/) repository.

This project was built using Flutter SDK version 3.10.1.

API setup
------------
The project mandates a working API to retrieve the results, clone the following project from GitHub and set up a local
server; Python must be installed since it operates on
Flask. `$ git clone https://github.com/tariqshaban/suicide-detection-server.git`.

Make sure to handle the CORS policy if the server is running locally (by
running: `flutter run lib/config/main.dart -d BROWSER_NAME --web-browser-flag "--disable-web-security"`).

Development server
------------
Run `flutter build web -t lib/config/main.dart` to deploy the web application, a build folder will be generated
at `build/web`.

> **Note**: The application cannot run when opening the index.html directly; you must run it on a server (such as
> **XAMPP**).

--------