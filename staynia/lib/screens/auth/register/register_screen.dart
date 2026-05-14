import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/components/app_bar/custom_app_bar.dart';
import 'package:staynia/components/button/app_button.dart';
import 'package:staynia/components/container/container_body.dart';
import 'package:staynia/components/input/custom_input.dart';
import 'package:staynia/components/input/read_only_input.dart';
import 'package:staynia/components/widgets/agreement_content.dart';
import 'package:staynia/components/widgets/custom_scaffold.dart';
import 'package:staynia/core/base/base_screen.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/data/entity/enum/app_button_type.dart';
import 'package:staynia/extension/theme_extension.dart';
import 'package:staynia/providers/manager/address/address_cubit.dart';
import 'package:staynia/providers/manager/address/address_state.dart';
import 'package:staynia/components/title_column_content.dart';
import 'package:staynia/screens/auth/register/manager/register_cubit.dart';
import 'package:staynia/screens/auth/register/manager/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseScreen<RegisterScreen> {
  @override
  Map<Type, BaseCubit Function()> get cubitFactories => {
    RegisterCubit: () => sl<RegisterCubit>(),
    AddressCubit: () => sl<AddressCubit>(),
  };
  late final RegisterCubit cubit;
  late final AddressCubit addressCubit;

  @override
  void initState() {
    super.initState();
    cubit = getCubit<RegisterCubit>();
    addressCubit = getCubit<AddressCubit>();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return CustomScaffold(
      removeTop: false,
      noNeedUser: true,
      decor: false,
      appBar: CustomAppBar(title: 'Sign Up'),
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: context.scaffoldBackgroundColor,
      bodyBuilder: (_) => SingleChildScrollView(
        child: ContainerBody(
          margin: EdgeInsets.only(top: 40),
          child: BlocBuilder<RegisterCubit, RegisterState>(
            bloc: cubit,
            builder: (_, state) {
              return Form(
                autovalidateMode: state.autovalidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Box.s90,
                    TitleColumnContent(
                      title: "Sign Up",
                      text:
                          "Enter your infomation for sign in. \nEnjoy booking in ${Constants.appName} 🪷",
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
                          label: "Fullname",
                          hintText: "Enter Fullname",
                          isRequired: true,
                          padding: const EdgeInsets.only(bottom: 10),
                          controller: cubit.fullNameController,
                        ),
                        CustomInput(
                          label: "Phone Number",
                          hintText: "Enter Phone Number",
                          isRequired: true,
                          padding: const EdgeInsets.only(bottom: 10),
                          controller: cubit.phoneController,
                        ),
                        CustomInput(
                          label: "Email",
                          hintText: "Enter Email",
                          isRequired: true,
                          padding: const EdgeInsets.only(bottom: 10),
                          controller: cubit.emailController,
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
                        CustomInput(
                          label: "Confirm Password",
                          hintText: "Enter Confirm Password",
                          isRequired: true,
                          isPassword: true,
                          padding: const EdgeInsets.only(bottom: 10),
                          controller: cubit.confirmPassController,
                        ),
                        BlocBuilder<AddressCubit, AddressState>(
                          bloc: addressCubit,
                          builder: (_, state) {
                            return Column(
                              children: [
                                ReadOnlyInput(
                                  label: 'Province',
                                  isRequired: true,
                                  hintText:
                                      state.selectedProvince?.name ??
                                      "Select your province",
                                  onClick: () {
                                    addressCubit.showProvinces(
                                      callBack: (data) => cubit.province = data,
                                    );
                                  },
                                ),
                                ReadOnlyInput(
                                  label: 'District',
                                  isRequired: true,
                                  hintText:
                                      state.selectedDistrict?.name ??
                                      "Select your District",
                                  onClick: () {
                                    addressCubit.showDistricts(
                                      callBack: (data) => cubit.district = data,
                                    );
                                  },
                                ),
                                ReadOnlyInput(
                                  label: 'Ward',
                                  isRequired: true,
                                  hintText:
                                      state.selectedWard?.name ??
                                      "Select your Ward",
                                  onClick: () {
                                    addressCubit.showWards(
                                      callBack: (data) => cubit.ward = data,
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    AgreementContent(
                      title: 'Read and agree to the ',
                      subTitle: 'terms',
                      agree: true,
                      agreeOnClick: (isOk) {},
                      subTitleOnClick: () {},
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ).copyWith(top: 20),
                      child: AppButton(
                        loading: state.loading,
                        content: state.loading ? "Sign up..." : "Sign up",
                        type: AppButtonType.primary,
                        onClick: cubit.register,
                      ),
                    ),
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
