# star_astro

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# star-astro-mobile
### Configure project
To **run** the project please follow these steps:

Step to generate missing files:
```
 dart run build_runner build
```
Step to generate missing files and delete conflicting files:
```
  flutter pub run build_runner build --delete-conflicting-outputs
```

### Use auto generated navigation system.
To use the default router first import this in import section
```
import 'package:auto_route/auto_route.dart';
```
And then you can use routing functions like
```
context.pushNamed(NAME_OF_THE_ROUTE)
```

### Add new route
Create your stateless or stateful screen file. Then define a name in AppRouter.dart file in constants list and add your screen with below syntax.
```
AutoRoute(page: LoginScreen,  path: ROUTE_LOGIN),
```
Update page and path as per your requirement and then don't forget to run the **build_runner**.

