part of 'bloc_bloc.dart';

@immutable
abstract class BlocEvent {}

class LoadingEvent extends BlocEvent {}

class InitialEvent extends BlocEvent {
  InitialEvent();
}

class RegisterUserEvent extends BlocEvent {
  final AuthUser authUser;
  RegisterUserEvent(this.authUser);
}

class LoginEvent extends BlocEvent {
  final AuthUser authUser;
  LoginEvent(this.authUser);
}

class BMICalculatorEvent extends BlocEvent {
  final UserModel? usermodel;
  BMICalculatorEvent(this.usermodel);
}

class BMIUpdateEvent extends BlocEvent {
  final double value;
  final UserModel userModel;
  final String status;
  BMIUpdateEvent(this.value, this.userModel, this.status);
}

class BMIthearaEvent extends BlocEvent {}

class BMIStoreEvent extends BlocEvent {
  final FoodModel foodModel;
  BMIStoreEvent(this.foodModel);
}

class RecordedEvent extends BlocEvent {}

class SignOutEvent extends BlocEvent {}

class DeleteEvent extends BlocEvent {
  String userId;
  DeleteEvent(this.userId);
}

class UpdateUserProfileEvent extends BlocEvent {
  final String userProfile;
  UpdateUserProfileEvent(this.userProfile);
}
