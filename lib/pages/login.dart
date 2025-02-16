import 'package:app_nutricao/_core/color_list.dart';
import 'package:app_nutricao/_core/input_style.dart';
import 'package:app_nutricao/components/avatar.dart';
import 'package:app_nutricao/components/custom_button.dart';
import 'package:app_nutricao/data/database_helper.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<Map<String, dynamic>> _registros = [];

  final _formkey = GlobalKey<FormState>();
  final _modalFormKey = GlobalKey<FormState>();

// Controllers do Login
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

// Controllers do Modal
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _exibeTodosRegistros() async {
    final data = await Database.exibeTodosRegistros();
    setState(() {
      _registros = data;
    });
  }

  loginButtonClicked() {
    if (_formkey.currentState!.validate()) {
      print('Form OK!');
    } else {
      print('Form NOK!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, preencha corretamente todos os campos."),
        ),
      );
    }
  }

  registerButtonClicked() async {
    if (_modalFormKey.currentState!.validate()) {
      await _insereRegistro();
      Navigator.of(context).pop();
    } else {
      print('Form NOK!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, preencha corretamente todos os campos."),
        ),
      );
    }
  }

  // Insere um novo registro
  Future<void> _insereRegistro() async {
    await Database.insereRegistro(_nameController.text, _emailController.text,
        _birthdateController.text, _passwordController.text);
    _exibeTodosRegistros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                    colors: [
                      AppColors.gradientTopColor,
                      AppColors.gradientBottomColor
                    ]),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                              decoration: textInputDecoration("Email"),
                              keyboardType: TextInputType.emailAddress,
                              validator: (String? value) {
                                if (value == null || !value.contains("@")) {
                                  return "Por favor, digite um email válido";
                                }
                                return null;
                              }),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                              decoration: textInputDecoration("Senha"),
                              obscureText: true,
                              validator: (String? value) {
                                if (value == null || value.length < 8) {
                                  return "Por favor, digite uma senha válida";
                                }
                                return null;
                              }),
                        ),
                        CustomButton(350, "Entrar", loginButtonClicked),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Ainda não possui conta?'),
                            const SizedBox(width: 10),
                            InkWell(
                              child: const Text(
                                "Cadastre-se agora!",
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              onTap: () {
                                _showForm();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showForm() async {
    showModalBottomSheet(
      context: context,
      elevation: 1,
      isScrollControlled: true,
      builder: (_) => SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Form(
            key: _modalFormKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Cadastrar novo Usuário',
                        style: TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const AvatarImage(),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: _nameController,
                          decoration: textInputDecoration("Nome"),
                          validator: (String? value) {
                            if (value == null || value.length < 3) {
                              return "Por favor, digite um nome válido";
                            }
                            return null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: textInputDecoration("Email"),
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value == null || !value.contains("@")) {
                            return "Por favor, digite um email válido";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: _passwordController,
                          decoration: textInputDecoration("Senha"),
                          obscureText: true,
                          validator: (String? value) {
                            if (value == null) {
                              return "Por favor, digite uma senha válida";
                            }
                            if (value.length < 8) {
                              return "Por favor, digite uma senha com pelo menos 8 dígitos";
                            }
                            return null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: _confirmPasswordController,
                          decoration: textInputDecoration("Confirmar Senha"),
                          obscureText: true,
                          validator: (String? value) {
                            if (value == null) {
                              return "Por favor, digite uma senha válida";
                            }
                            if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              return "As senhas não coincidem.";
                            }
                            return null;
                          }),
                    ),
                    CustomButton(350, "Cadastrar", registerButtonClicked),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
