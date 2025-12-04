# chat-frontend
this is for the implementation for the chat applciation created as backend using java

# add-dependency
these are the dependency i have added

# change-analysis-option-file
changed the anasysis option file 

# # change-analysis-option-file-2
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
