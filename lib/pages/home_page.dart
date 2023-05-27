import 'package:flutter/material.dart';
import 'package:ucv_laboratorio_8/helpers/db_helper.dart';
import 'package:ucv_laboratorio_8/models/dog_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Dog> _dogs = [];

  @override
  void initState() {
    super.initState();
    loadDogs();
  }

  Future<void> loadDogs() async {
    DBHelper dbHelper = DBHelper();
    List<Dog> dogs = await dbHelper.dogs();
    setState(() {
      _dogs = dogs;
    });
  }

  void navigateToRegisterPage() async {
    await Navigator.pushNamed(context, '/register');
    // Actualizar la lista después de regresar de la página de registro
    loadDogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Perros'),
      ),
      body: ListView.builder(
        itemCount: _dogs.length,
        itemBuilder: (context, index) {
          Dog dog = _dogs[index];
          return ListTile(
            title: Text(dog.name),
            subtitle: Text('Edad: ${dog.age}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToRegisterPage,
        child: Icon(Icons.add),
      ),
    );
  }
}