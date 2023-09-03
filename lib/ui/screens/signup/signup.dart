import 'package:campuspulse/blocs/bloc/authentication_bloc.dart';
import 'package:campuspulse/data/data.dart';
import 'package:campuspulse/handlers/http_error/http_errors.handler.dart';
import 'package:campuspulse/utils/utils.dart';
import 'package:campuspulse/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuspulse/data/images.dart';
import 'package:campuspulse/router/routes.dart';
import '../../widgets/widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, this.loginTapped});
  final VoidCallback? loginTapped;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  62.verticalSpace,
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppImages.logo,
                      height: 58.h,
                      width: 58.w,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      'UniPasco Ghana',
                      style: context.getTheme.textTheme.displaySmall,
                    ),
                  ),
                  36.verticalSpace,
                  Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      'Let’s get you started',
                      style: context.getTheme.textTheme.displayMedium,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      'Sign Up to enjoy amazing past questions',
                      style: context.getTheme.textTheme.labelMedium,
                    ),
                  ),
                  15.verticalSpace,
                  CustomText(
                    'Full Name',
                    style: context.getTheme.textTheme.bodyMedium,
                  ),
                  6.verticalSpace,
                  CustomTextFieldWidget(
                    controller: nameController,
                    hintText: 'Your name',
                  ),
                  20.verticalSpace,
                  CustomText(
                    'E-mail',
                    style: context.getTheme.textTheme.bodyMedium,
                  ),
                  6.verticalSpace,
                  CustomTextFieldWidget(
                    controller: emailController,
                    hintText: 'name@provider.com',
                    validator: (v) => Validators.validateEmail(v),
                  ),
                  20.verticalSpace,
                  CustomText(
                    'Password',
                    style: context.getTheme.textTheme.bodyMedium,
                  ),
                  6.verticalSpace,
                  StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return CustomTextFieldWidget(
                        controller: passwordController,
                        maxLines: 1,
                        validator: (v) => Validators.validatePassword(v),
                        obscureText: obscurePassword,
                        hintText: 'Your password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            obscurePassword = !obscurePassword;
                            setState(() {});
                          },
                          icon: obscurePassword
                              ? const Icon(IconlyLight.show)
                              : const Icon(IconlyLight.hide),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomAdaptiveTextButton(
                      onTap: () {},
                      text: 'Forgot password?',
                      style: context.getTheme.textTheme.labelMedium!.copyWith(
                        color: const Color(0xFF0F96FF),
                      ),
                    ),
                  ),
                  26.verticalSpace,
                  BlocConsumer<AuthenticationBloc, AuthenticationState>(
                    listenWhen: (previous, current) =>
                        current is SignUpSuccess || current is SigningUpError,
                    listener: (context, state) {
                      if (state is SigningUpError) {
                        // show flush message when somwthing is wrong

                        return UiUtils.flush(
                          context,
                          errorState: ErrorState.error,
                          msg: HttpErrorUtils.getErrorMessage(state.error),
                        );
                      } else if (state is SignUpSuccess) {
                        // navigate user to verification screen is success
                        Navigator.of(context).pushNamed(
                          Routes.verificationScreen,
                          arguments: emailController.text,
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomElevatedButton(
                        isBusy: state is SigningUp,
                        title: 'Register',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // sign user up with email and password
                            context.read<AuthenticationBloc>().add(
                                  SignUpWithEmail(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                          }
                        },
                      );
                    },
                    buildWhen: (previous, current) =>
                        current is SigningUp ||
                        current is SignUpSuccess ||
                        current is SigningUpError,
                  ),
                  32.verticalSpace,
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'Already have an account? ',
                        style: context.getTheme.textTheme.bodyMedium,
                        children: [
                          WidgetSpan(
                            child: CustomAdaptiveTextButton(
                              onTap: widget.loginTapped!,
                              text: 'Sign In',
                              style: context.getTheme.textTheme.labelMedium
                                  ?.copyWith(
                                color: const Color(0xFF0F96FF),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  30.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
