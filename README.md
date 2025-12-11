# chat-frontend
this is for the implementation for the chat applciation created as backend using java

# add-dependency
these are the dependency i have added

# change-analysis-option-file
changed the anasysis option file 

# change-analysis-option-file-2
changed the analysis option file

# constants
added the app constants file
added the storage constants file

# models/-datamodels
created the model for the user details
there is a challenge where how to use the null section
it has been solved and rectified  

this was the line

  factory UserModel.fromLocalJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] as String,
      token: json['token'] as String?,
      id: json['id'] as int?,
    );
  }

# dto/-registerresponse
the dto code has been added for the registering section

# dto/-loginresponse 
added the dto code for the loginresponse

# dto/-TokenResponse 
added the dto code for the token response
updated the code for the login response

# model/-MessageModel
added the code for the model in the message model 

#  model/-privateMessageModel
added the code for the model in the private message model section

# core/service/-storageService
added the storage serive in the service section of the core storage

# test-storage
added the code for the test storage in main.dart
after running this command i got the result 
aaditantony@aadits-MacBook-Pro chat % flutter analyze
Resolving dependencies... 
Downloading packages... 
  _fe_analyzer_shared 85.0.0 (92.0.0 available)
  analyzer 7.6.0 (9.0.0 available)
  analyzer_buffer 0.1.10 (0.1.11 available)
  analyzer_plugin 0.13.4 (0.13.11 available)
  build 3.1.0 (4.0.3 available)
  build_resolvers 3.0.3 (3.0.4 available)
  build_runner 2.7.1 (2.10.4 available)
  build_runner_core 9.3.1 (9.3.2 available)
  characters 1.4.0 (1.4.1 available)
  custom_lint 0.8.0 (0.8.1 available)
  custom_lint_builder 0.8.0 (0.8.1 available)
  custom_lint_core 0.8.0 (0.8.1 available)
  custom_lint_visitor 1.0.0+7.7.0 (1.0.0+8.4.0 available)
  dart_style 3.1.1 (3.1.3 available)
  flutter_lints 5.0.0 (6.0.0 available)
  flutter_secure_storage_linux 1.2.3 (2.0.1 available)
  flutter_secure_storage_macos 3.1.3 (4.0.0 available)
  flutter_secure_storage_platform_interface 1.1.2 (2.0.1 available)
  flutter_secure_storage_web 1.2.1 (2.0.0 available)
  flutter_secure_storage_windows 3.1.2 (4.0.0 available)
  js 0.6.7 (0.7.2 available)
  lints 5.1.1 (6.0.0 available)
  matcher 0.12.17 (0.12.18 available)
  material_color_utilities 0.11.1 (0.13.0 available)
  meta 1.16.0 (1.17.0 available)
  mockito 5.5.0 (5.6.1 available)
  source_gen 3.1.0 (4.1.1 available)
  test 1.26.2 (1.28.0 available)
  test_api 0.7.6 (0.7.8 available)
  test_core 0.6.11 (0.6.14 available)
Got dependencies!
30 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Analyzing chat...                                                       

warning • Don't invoke 'print' in production code • lib/main.dart:10:3 • avoid_print
warning • Don't invoke 'print' in production code • lib/main.dart:49:7 • avoid_print

2 issues found. (ran in 0.7s)

# core/service/-apiService
the apiService section is added in the service of the core section

# core/service/-auth_service 
the auth service is added in the core section of the service

# test-service 
the code has been tested and its working fine
aaditantony@aadits-MacBook-Pro chat % flutter analyze
Resolving dependencies... (1.9s)
Downloading packages... 
  _fe_analyzer_shared 85.0.0 (92.0.0 available)
  analyzer 7.6.0 (9.0.0 available)
  analyzer_buffer 0.1.10 (0.1.11 available)
  analyzer_plugin 0.13.4 (0.13.11 available)
  build 3.1.0 (4.0.3 available)
  build_resolvers 3.0.3 (3.0.4 available)
  build_runner 2.7.1 (2.10.4 available)
  build_runner_core 9.3.1 (9.3.2 available)
  characters 1.4.0 (1.4.1 available)
  custom_lint 0.8.0 (0.8.1 available)
  custom_lint_builder 0.8.0 (0.8.1 available)
  custom_lint_core 0.8.0 (0.8.1 available)
  custom_lint_visitor 1.0.0+7.7.0 (1.0.0+8.4.0 available)
  dart_style 3.1.1 (3.1.3 available)
  flutter_lints 5.0.0 (6.0.0 available)
  flutter_secure_storage_linux 1.2.3 (2.0.1 available)
  flutter_secure_storage_macos 3.1.3 (4.0.0 available)
  flutter_secure_storage_platform_interface 1.1.2 (2.0.1 available)
  flutter_secure_storage_web 1.2.1 (2.0.0 available)
  flutter_secure_storage_windows 3.1.2 (4.0.0 available)
  js 0.6.7 (0.7.2 available)
  lints 5.1.1 (6.0.0 available)
  matcher 0.12.17 (0.12.18 available)
  material_color_utilities 0.11.1 (0.13.0 available)
  meta 1.16.0 (1.17.0 available)
  mockito 5.5.0 (5.6.1 available)
  riverpod_analyzer_utils 1.0.0-dev.7 (1.0.0-dev.8 available)
  source_gen 3.1.0 (4.1.1 available)
  test 1.26.2 (1.28.0 available)
  test_api 0.7.6 (0.7.8 available)
  test_core 0.6.11 (0.6.14 available)
Got dependencies!
31 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Analyzing chat...                                                       
No issues found! (ran in 0.7s)

# auth-provider
the auth service has been updated with the get method

# presentation/providers/-service-providers
the storage service provider has been added
the code has been pushed

presentation/providers/-auth-providers ⚠️
we have updated the main.dart file to add the providerscope
addded the riverpod generator code auth_provider.dart
added the riverpod genrator code in the service_provider.dart
all the analysis issues has been solved and the code is pushed ((learn)
command -> flutter pub run build_runner build --delete-conflicting-outputs

# presentation/views/-login_screen
the login screen has been implemented
the code has been pushed

# presentation/views/-register_screen
the code of the register screen has been implemented
the code has been modified in the login screen
currently solved all the issues regarding the login and register screen
the code has been pushed

# update-main
the main has been updated with the login screen
the code has been pushed

# testing-login-register 
the base url is changed to http://192.168.18.56:8080
android url is not working
the main dart has been updated
new method is added in the void main section
the auth service page const of additional  method 
the app constant has been changed
