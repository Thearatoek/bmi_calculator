import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online/feature/auth_provider/authetication.dart';
import 'package:online/feature/dashboard/dashboard_screen.dart';
import 'package:online/model/auth_model.dart';
import 'package:online/mybloc/bloc_bloc.dart';
import 'package:online/util/app_util.dart';
import 'package:online/widget/custome_input.dart';

import '../../widget/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLogin = false;
  final user = UserAuth();
  bool get isKeyboardAppear => MediaQuery.of(context).viewInsets.bottom > 0;
  @override
  Widget build(BuildContext context) {
    var authUser = BlocProvider.of<BlocBloc>(context);
    return keyboardDismisser(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 200,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Icon(
                  Icons.language,
                  size: 18,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'En',
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
                )
              ],
            ),
          ),
          backgroundColor: HexColor('#FFB80A'),
        ),
        body: BlocConsumer<BlocBloc, BlocState>(listener: (context, state) {
          if (state is LoginState) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => BlocBloc(),
                  child: const DashboardScreen(
                    username: 'Eha',
                  ),
                ),
              ),
            );
          }
          if (state is RegisterUserState) {
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => BlocBloc(),
                child: const DashboardScreen(
                  username: 'Eha',
                ),
              ),
            );
          }
        }, builder: (context, state) {
          return Container(
            color: HexColor('#FFB80A'),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 12,
                ),
                isLogin
                    ? const Text(
                        "Login !",
                        style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w700),
                      )
                    : const Text(
                        "Welcome !",
                        style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w700),
                      ),
                const SizedBox(
                  height: 10,
                ),
                isLogin
                    ? const Text(
                        "Sign in to Continous ",
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                      )
                    : const Text(
                        "Please do registration!",
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                const SizedBox(
                  height: 10,
                ),
                InputTextCustomWidget(
                  onchange: () {
                    setState(() {
                      validation();
                    });
                  },
                  controller: _phoneController,
                  name: "Email",
                  icon: const Icon(Icons.email),
                ),
                const SizedBox(
                  height: 10,
                ),
                InputTextCustomWidget(
                  onchange: () {
                    setState(() {
                      validation();
                    });
                  },
                  password: true,
                  controller: _passwordController,
                  name: "Password",
                  icon: const Icon(Icons.remove_red_eye_rounded),
                ),
                const SizedBox(
                  height: 10,
                ),
                isLogin
                    ? InkWell(
                        onTap: () {
                          isLogin = !isLogin;
                          setState(() {});
                        },
                        child: const Text("No acccount yet?"))
                    : InkWell(
                        onTap: () {
                          isLogin = !isLogin;
                          setState(() {});
                        },
                        child: const Text(
                          "You have already account??",
                        ),
                      ),
                const Expanded(child: SizedBox()),
                !isKeyboardAppear
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: ButtonCustomWidget(
                          isborder: isValidation,
                          onClick: validation() == false
                              ? () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                }
                              : () {
                                  var auth = AuthUser(email: _phoneController.text, password: _passwordController.text);

                                  if (isLogin) {
                                    authUser.add(LoginEvent(auth));
                                  } else {
                                    authUser.add(RegisterUserEvent(auth));
                                  }
                                },
                          name: isLogin ? "Login Now" : "Register Now",
                        ),
                      )
                    : const Text('')
              ],
            ),
          );
        }),
      ),
    );
  }

  bool isValidation = false;
  Widget keyboardDismisser({BuildContext? context, Widget? child}) {
    final gesture = GestureDetector(
      onTap: () {
        FocusScope.of(context!).requestFocus(FocusNode());
        validation();
      },
      child: child,
    );
    return gesture;
  }

  bool validation() {
    bool valid = isValidation = _phoneController.text != '' && _passwordController.text != '';
    debugPrint('================$valid');
    return valid;
  }
}
