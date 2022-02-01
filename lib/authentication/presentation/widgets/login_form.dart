import 'package:country_code_picker/country_code_picker.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freshcode_loyalty_t3/authentication/domain/notifiers/sign_in_notifier.dart';
import 'package:freshcode_loyalty_t3/authentication/domain/state/sign_in_state.dart';
import 'package:freshcode_loyalty_t3/authentication/presentation/widgets/flash.dart';
import 'package:freshcode_loyalty_t3/authentication/presentation/widgets/submit_button.dart';
import 'package:freshcode_loyalty_t3/text_config.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../global_providers.dart';

final signInPhoneModelProvider =
    StateNotifierProvider.autoDispose<SignInPhone, SignInState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return SignInPhone(
    authService: authService,
  );
});

class LoginForm extends ConsumerWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
      mask: ' ###-##-###-#',
      filter: {"#": RegExp(r'[0-9]')},
    );
    final form = ref.watch(formProvider);
    final state = ref.watch(signInPhoneModelProvider);
    final auth = ref.read(signInPhoneModelProvider.notifier);
    if (state != SignInState.loading() || state != SignInState.success()) {
      ShowFlash(context: context, message: 'test').showBasicFlash();
      print(state.toString());
    }
    return ReactiveForm(
      formGroup: form,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 7),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(35),
                    ),
                  ),
                  child: CountryCodePicker(
                    onChanged: print,
                    initialSelection: 'UA',
                    favorite: const ['+380', 'UA'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    flagWidth: 15,
                    textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.greenAccent),
                    alignLeft: false,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  height: 70,
                  padding: const EdgeInsets.only(top: 10),
                  child: ReactiveTextField(
                    textAlignVertical: TextAlignVertical.top,
                    inputFormatters: [maskFormatter],
                    formControlName: 'phone',
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.phone,
                    cursorHeight: 15,
                    autofocus: true,
                    maxLength: 13,
                    validationMessages: (control) => {
                      'required': "Обов'язкове поле",
                    },
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          ReactiveFormConsumer(builder: (
            context,
            form,
            child,
          ) {
            return SubmitButton(
              onPress: () {
                // auth.verifyPhone(form.control('phone').value);

              },
              title: TextConfig.logIn,
              form: form,
            );
          })
        ],
      ),
    );
  }
}


