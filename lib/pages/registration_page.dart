import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/change_notifiers/registration_controller.dart';
import 'package:notes_app/components/buttons/icon_button_outlined.dart';
import 'package:notes_app/components/buttons/note_button.dart';
import 'package:notes_app/components/notes/note_form_field.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/pages/recover_password_page.dart';
import 'package:notes_app/validator.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final RegistrationController registrationController;
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();

    registrationController = context.read();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    formKey = GlobalKey();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Selector<RegistrationController, bool>(
                selector: (_, controller) => controller.isRegisterMode,
                builder: (_, isRegisterMode, __) => Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(isRegisterMode ? 'Register' : 'Sign in',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 48,
                            fontFamily: 'Fredoka',
                            fontWeight: FontWeight.w600,
                            color: primary,
                          )),
                      const SizedBox(height: 16),
                      const Text(
                        'In order to sync your notes to the cloud, you need to register or sign in to the app.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      if (isRegisterMode) ...[
                        NoteFormField(
                          controller: nameController,
                          labelText: 'Full name',
                          fillColor: isDark ? gray900 : white,
                          filled: true,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          validator: Validator.nameValidator,
                          onChanged: (newvalue) {
                            registrationController.fullName = newvalue;
                          },
                        ),
                        const SizedBox(height: 8),
                      ],
                      NoteFormField(
                        controller: emailController,
                        labelText: 'Email',
                        fillColor: isDark ? gray900 : white,
                        filled: true,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validator.emailValidator,
                        onChanged: (newvalue) {
                          registrationController.email = newvalue;
                        },
                      ),
                      const SizedBox(height: 8),
                      Selector<RegistrationController, bool>(
                        selector: (_, controller) =>
                            controller.isPasswordHidden,
                        builder: (_, isPasswordHidden, __) => NoteFormField(
                          controller: passwordController,
                          labelText: 'Password',
                          fillColor: isDark ? gray900 : white,
                          filled: true,
                          obscureText: isPasswordHidden,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              registrationController.isPasswordHidden =
                                  !isPasswordHidden;
                            },
                            child: Icon(
                              isPasswordHidden
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                            ),
                          ),
                          validator: Validator.passwordValidator,
                          onChanged: (newvalue) {
                            registrationController.password = newvalue;
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (!isRegisterMode) ...[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const RecoverPasswordPage(),
                                ));
                          },
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      SizedBox(
                        height: 48,
                        child: Selector<RegistrationController, bool>(
                          selector: (_, controller) => controller.isLoading,
                          builder: (_, isLoading, __) => NoteButton(
                            child: isLoading
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CupertinoActivityIndicator(
                                        color: white),
                                  )
                                : Text(isRegisterMode
                                    ? 'Create my account'
                                    : 'Log me in'),
                            onPressed: isLoading
                                ? null
                                : () {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      registrationController
                                          .authenticateWithEmailAndPassword(
                                              context: context);
                                    }
                                  },
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(isRegisterMode
                                ? 'Or register with'
                                : 'Or sign in with'),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: IconButtonOutlined(
                                onPressed: () {},
                                icon: FontAwesomeIcons.google),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: IconButtonOutlined(
                                onPressed: () {},
                                icon: FontAwesomeIcons.facebook),
                          ),
                        ],
                      ),
                      const SizedBox(width: 32),
                      Text.rich(
                        TextSpan(
                          text: isRegisterMode
                              ? 'Already have an account? '
                              : 'Don\'t have an account? ',
                          style: const TextStyle(color: gray700),
                          children: [
                            TextSpan(
                                text: isRegisterMode ? 'Sign in' : 'Register',
                                style: const TextStyle(
                                  color: primary,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    registrationController.isRegisterMode =
                                        !isRegisterMode;
                                  }),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
