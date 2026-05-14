import 'dart:io';
import 'package:flutter/material.dart';
import 'package:staynia/data/entity/model/auth_token.dart';
import 'package:staynia/data/entity/model/user.dart';

abstract class UserEvent {}

class EditUser extends UserEvent {
  final BuildContext context;
  final File? image;
  final String name, email, phone, gender;
  final String? password, newPassword, confirmNewPassword;

  EditUser(
    this.context,
    this.email,
    this.name,
    this.phone,
    this.gender,
    this.password,
    this.newPassword,
    this.confirmNewPassword,
    this.image,
  );
}

class LogoutSubmit extends UserEvent {
  final bool clearUser;
  LogoutSubmit({this.clearUser = false});
}

class LoadUser extends UserEvent {}

class SaveUser extends UserEvent {
  final User user;
  final AuthToken? token;

  SaveUser(this.user, {this.token});
}

class UnauthenticatedEvent extends UserEvent {}

class SaveUserOnRefresh extends UserEvent {
  final User user;
  final AuthToken token;

  SaveUserOnRefresh(this.user, this.token);
}

class ErrorEvent extends UserEvent {
  String? errorCode;
  ErrorEvent({this.errorCode});
}
