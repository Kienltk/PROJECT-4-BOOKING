import 'package:staynia/data/entity/model/user.dart';

abstract class UserState {}

class UserInit extends UserState {}

class LogoutLoading extends UserState {}

class DeleteLoading extends UserState {}

class Unauthenticated extends UserState {}

class Authenticated extends UserState {
  final User user;
  Authenticated(this.user);
}
