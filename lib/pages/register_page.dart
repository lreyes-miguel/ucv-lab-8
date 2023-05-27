import 'package:flutter/material.dart';
import 'package:ucv_laboratorio_8/helpers/db_helper.dart';
import 'package:ucv_laboratorio_8/models/dog_model.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  void registerDog() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      int age = int.parse(_ageController.text);

      Dog newDog = Dog(name: name, age: age);
      DBHelper dbHelper = DBHelper();
      await dbHelper.insertDog(newDog);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Perro registrado correctamente.'),
        ),
      );

      Navigator.pop(context); // Regresar a la página anterior
      // Actualizar la lista en la página de inicio
      (context as Element).reassemble(); // Llama a reassemble() en el contexto actual
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Perro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre del perro.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Edad',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la edad del perro.';
                  }
                  int? age = int.tryParse(value);
                  if (age == null || age <= 0) {
                    return 'La edad debe ser un número entero positivo.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: registerDog,
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}