import 'package:app_nutricao/_core/color_list.dart';
import 'package:app_nutricao/_core/input_style.dart';
import 'package:app_nutricao/components/avatar.dart';
import 'package:app_nutricao/components/food_type_radio.dart';
import 'package:flutter/material.dart';

class NewFoodPage extends StatefulWidget {
  const NewFoodPage({super.key});

  @override
  State<NewFoodPage> createState() => _NewFoodPageState();
}

class _NewFoodPageState extends State<NewFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ola, bem-vindo!',
          style: TextStyle(color: AppColors.textLight),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.logout_outlined,
                color: AppColors.textLight,
              ),
            ),
          ),
        ],
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Form(
            child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Insira a imagem do alimento',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: AvatarImage(),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 350,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                    child: TextFormField(
                      decoration: textInputDecoration("Nome do alimento"),
                    ),
                  ),
                ),
              ),
              const Text(
                'Categoria',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              const FoodTypeRadio()
            ],
          ),
        )),
      ),
    );
  }
}
