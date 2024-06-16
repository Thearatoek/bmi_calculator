part of 'bloc_bloc.dart';

@immutable
abstract class BlocState {}

class BlocInitial extends BlocState {}

class LoadingState extends BlocState {}

class BMICalculateState extends BlocState {
  final UserModel userModel;
  BMICalculateState({required this.userModel});
}

class BIMInitstate extends BlocState {}

class BMIthearaState extends BlocState {}

class BMIUpdateState extends BlocState {
  final UserModel userModel;

  BMIUpdateState(this.userModel);
}

class BMIStoreDataState extends BlocState {
  final FoodModel foodModel;
  BMIStoreDataState(this.foodModel);
}

class RegisterUserState extends BlocState {}

class LoginState extends BlocState {}

class RecordedState extends BlocState {
  final List<UserModel> listUsermodel;
  RecordedState(this.listUsermodel);
}

class SigOutState extends BlocState {}

class DeleteState extends BlocState {}

class UpdateUserProfileState extends BlocState {}

class LoginErrorState extends BlocState {}
