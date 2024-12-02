import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie1/cubit/Password_states.dart';

class PasswordCubit extends Cubit<PasswordStates> {
  PasswordCubit() : super(PasswordStates());
  static PasswordCubit get(context) => BlocProvider.of(context);
  bool visible = false;
  bool isPassword = true;
  void changeState() {
    visible = !visible;
    isPassword = !isPassword;
    emit(ChangePasswordState());
  }
}
