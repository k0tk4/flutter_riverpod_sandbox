import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:freshcode_loyalty_t3/authentication/presentation/widgets/phone_input.dart';
import 'package:freshcode_loyalty_t3/text_config.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef OnPressCallback = Function();

class SubmitButton extends ConsumerWidget {
  final FormGroup form;
  final OnPressCallback? onPress;
  final String title;
  const SubmitButton({Key? key, required this.onPress, required this.title, required this.form})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form1 = ReactiveForm.of(context);
    return SizedBox(
      width: 400,
      child: ElevatedButton(
        key: const Key('userEditForm_continue_raisedButton'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          shadowColor: Colors.transparent,
          primary: Colors.greenAccent,
        ),
        onPressed: form1!.valid ? onPress : null,
        child: Text(TextConfig.logIn),
      ),
    );
  }
}
