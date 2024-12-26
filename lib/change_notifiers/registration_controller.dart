import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/components/dialog/dialogs.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/services/auth_services.dart';

class RegistrationController extends ChangeNotifier {
  bool _isRegisterMode = true;

  bool get isRegisterMode => _isRegisterMode;
  set isRegisterMode(bool value) {
    _isRegisterMode = value;
    notifyListeners();
  }

  bool _isPasswordHidden = true;
  bool get isPasswordHidden => _isPasswordHidden;
  set isPasswordHidden(bool value) {
    _isPasswordHidden = value;
    notifyListeners();
  }

  String _fullName = '';
  set fullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  String get fullName => _fullName.trim();

  String _email = '';
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get email => _email.trim();

  String _password = '';
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String get password => _password;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> authenticateWithEmailAndPassword(
      {required BuildContext context}) async {
    isLoading = true;
    try {
      if (isRegisterMode) {
        await AuthServices.register(
          fullName: fullName,
          email: email,
          password: password,
        );
        if (!context.mounted) return;
        showMessageDialog(
          context: context,
          message:
              'A verification message has been sent to your gmail. PLease confirm your email to proceed to the app',
        );
        // reload the user
        while (!AuthServices.isEmailVerified) {
          await Future.delayed(
            const Duration(seconds: 5),
            () => AuthServices.user?.reload(),
          );
        }
      } else {
        // sign in user
        await AuthServices.login(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      // show the dialog
      showMessageDialog(
        context: context,
        message: authExceptionMapper[e.code] ?? 'An Unknown Error occured',
      );
    } catch (e) {
      if (!context.mounted) return;
      // show another dialog
      showMessageDialog(
        context: context,
        message: 'An Unknown Error occured',
      );
    } finally {
      isLoading = false;
    }
  }

  Future<void> resetPassword(
      {required BuildContext context, required String email}) async {
    isLoading = true;
    try {
      await AuthServices.resetPassword(email: email);
      if (!context.mounted) return;
      showMessageDialog(
          context: context,
          message:
              'A reset password link has been sent to $email. Open link to reset your password');
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      // show the dialog
      showMessageDialog(
        context: context,
        message: authExceptionMapper[e.code] ?? 'An Unknown Error occured',
      );
    } catch (e) {
      if (!context.mounted) return;
      // show another dialog
      showMessageDialog(
        context: context,
        message: 'An Unknown Error occured',
      );
    } finally {
      isLoading = false;
    }
  }
}
