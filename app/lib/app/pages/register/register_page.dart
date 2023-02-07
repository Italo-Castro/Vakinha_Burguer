import 'package:delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app/app/core/ui/widgtes/delivery_app_bar.dart';
import 'package:delivery_app/app/core/ui/widgtes/delivery_button.dart';
import 'package:delivery_app/app/pages/register/register_controller.dart';
import 'package:delivery_app/app/pages/register/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/base_state/base_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
            any: () => hideLoader(),
            register: () => showLoader(),
            error: () {
              hideLoader();
              showError('Erro ao registrar Usuário');
            },
            success: () {
              hideLoader();
              showSuccess('Cadastro realaizado com sucesso');
              Navigator.pop(context);
            });
      },
      child: Scaffold(
        appBar: DeliveryAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastro',
                    style: context.textStyles.textTitle,
                  ),
                  Text(
                    'Preencha os campos abaixo para criar o seu cadastro.',
                    style: context.textStyles.textMedium.copyWith(fontSize: 18),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  TextFormField(
                    controller: _nameEC,
                    decoration: InputDecoration(
                      labelText: ('Nome'),
                    ),
                    validator: Validatorless.required('Nome obrigatório'),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                      labelText: ('E-mail'),
                    ),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('E-mail obrigatório'),
                        Validatorless.email('E-mail inválido')
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  TextFormField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: ('senha'),
                    ),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Senha obrigatório'),
                        Validatorless.min(
                            6, 'Senha deve coter peo menos 6 caracteres')
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: ('Confirma Senha'),
                    ),
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('Confirma senha obrigatório'),
                        Validatorless.compare(
                            _password, 'Senha diferente de confirma senha.')
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Center(
                    child: DeliveryButton(
                      width: double.infinity,
                      onPressed: () {
                        final valid = formKey.currentState?.validate() ?? false;
                        if (valid) {
                          controller.register(
                              _nameEC.text, _email.text, _password.text);
                        }
                      },
                      label: 'Cadastrar',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
