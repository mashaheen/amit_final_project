// To parse this JSON data, do
//
//     final error = errorFromJson(jsonString);

import 'dart:convert';

Error errorFromJson(String str) => Error.fromJson(json.decode(str));

String errorToJson(Error data) => json.encode(data.toJson());

class Error {
  Error({
    this.message,
    this.errors,
  });

  String message;
  Errors errors;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    message: json["message"],
    errors: Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors.toJson(),
  };
}

class Errors {
  Errors({
    this.email,
  });

  List<String> email;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    email: List<String>.from(json["email"].map((x) => x)),

  );

  Map<String, dynamic> toJson() => {
    "email": List<dynamic>.from(email.map((x) => x)),

  };
}
