import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/components/button/app_button.dart';
import 'package:staynia/components/container/container_body.dart';
import 'package:staynia/components/input/custom_input.dart';
import 'package:staynia/components/widgets/custom_scaffold.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/data/entity/enum/app_button_type.dart';
import 'package:staynia/extension/app_extension.dart';
import 'package:staynia/extension/navigator_extension.dart';
import 'package:staynia/extension/theme_extension.dart';
import 'package:staynia/providers/manager/auth/auth_cubit.dart';
import 'package:staynia/providers/manager/auth/auth_state.dart';
import 'package:staynia/router/router_path.dart';
import 'package:staynia/components/title_column_content.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return CustomScaffold(
      removeTop: false,
      noNeedUser: true,
      decor: false,
      bodyBuilder: (_) => SingleChildScrollView(
        child: ContainerBody(
          child: BlocBuilder<AuthCubit, AuthState>(
            bloc: cubit,
            builder: (_, state) {
              return Form(
                autovalidateMode: state.autovalidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Box.s90,
                    TitleColumnContent(
                      title: "Welcome to",
                      text:
                          "Enter your Username  \nand Password for sign in. Enjoy booking in ${Constants.appName} 🪷",
                    ),
                    Column(
                      children: [
                        CustomInput(
                          label: "Username",
                          hintText: "Enter Username",
                          isRequired: true,
                          padding: const EdgeInsets.only(bottom: 10),
                          controller: cubit.usernameController,
                          onChanged: cubit.validateUsername,
                          validator: (_) => state.usernameError,
                        ),
                        CustomInput(
                          label: "Password",
                          hintText: "Enter Password",
                          isRequired: true,
                          isPassword: true,
                          padding: const EdgeInsets.only(bottom: 10),
                          controller: cubit.passwordController,
                          onChanged: cubit.validatePassword,
                          validator: (_) => state.passwordError,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ).copyWith(top: 20),
                      child: AppButton(
                        loading: state.loading,
                        content: state.loading ? "Login..." : "Login",
                        type: AppButtonType.primary,
                        onClick: cubit.login,
                      ),
                    ),
                    Center(
                      child: Text(
                        "Or",
                        style: TextStyle(
                          color: Color(0xFF010F07).withOpacitySafe(0.7),
                        ),
                      ),
                    ),
                    Box.s6,
                    Center(
                      child: Text.rich(
                        TextSpan(
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(fontWeight: FontWeight.w600),
                          text: "Don’t have account? ",
                          children: <TextSpan>[
                            TextSpan(
                              text: "Create new account.",
                              style: TextStyle(color: context.primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pushTo(RoutePaths.register);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
