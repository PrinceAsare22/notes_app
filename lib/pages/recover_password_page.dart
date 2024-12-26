import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/change_notifiers/registration_controller.dart';
import 'package:notes_app/components/buttons/note_back_button.dart';
import 'package:notes_app/components/buttons/note_button.dart';
import 'package:notes_app/components/notes/note_form_field.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/validator.dart';
import 'package:provider/provider.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  late final TextEditingController emailController;

  GlobalKey<FormFieldState> emailKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const NoteBackButton(),
        title: const Text('Recover Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Don\'t worry! Happens to the best of us!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              NoteFormField(
                controller: emailController,
                key: emailKey,
                labelText: 'Email',
                validator: Validator.emailValidator,
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                child: Selector<RegistrationController, bool>(
                  selector: (_, controller) => controller.isLoading,
                  builder: (_, isLoading, __) => NoteButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (emailKey.currentState?.validate() ?? false) {
                              context
                                  .read<RegistrationController>()
                                  .resetPassword(
                                      context: context,
                                      email: emailController.text.trim());
                            }
                          },
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CupertinoActivityIndicator(
                              color: white,
                            ),
                          )
                        : const Text(
                            'Send me a recovery link!',
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
