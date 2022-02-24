class LoginRequest {
  String username;
  String password;

  LoginRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}

class ChangePasswordRequest {
  String newPassword;
  String oldPassword;

  ChangePasswordRequest({required this.newPassword, required this.oldPassword});

  Map<String, dynamic> toJson() => {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      };
}

class ChangePasswordResponse {
  String status;
  String message;

  ChangePasswordResponse({required this.message, required this.status});

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };

  factory ChangePasswordResponse.fromJson(dynamic json) =>
      ChangePasswordResponse(
        status: json["status"],
        message: json["message"],
      );
}
