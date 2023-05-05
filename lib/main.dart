import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _resultado = 'Preencha os valores';
  TextEditingController etanolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void _reset() {
    etanolController.text = '';
    gasolinaController.text = '';

    setState(() {
      _resultado = 'Preencha os valores';
    });
  }

  void _calculaCombustivelIdeal() {
    double vEtanol = double.parse(etanolController.text.replaceAll(',', '.'));
    double vGasolina =
        double.parse(gasolinaController.text.replaceAll(',', '.'));
    double proporcao = vEtanol / vGasolina;

    setState(() {
      _resultado = (proporcao <= 0.7)
          ? 'Abasteça com Etanol'
          : 'Abasteça com Gasolina'; //if ternário
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Etanol ou Gasolina?',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightBlue[900],
          actions: [
            IconButton(onPressed: _reset, icon: const Icon(Icons.refresh))
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formkey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.local_gas_station,
                    size: 140,
                    color: Colors.lightBlue[900],
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: etanolController,
                    textAlign: TextAlign.center,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o valor do Etanol';
                      }
                      return null;
                    },
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                        labelText: 'Valor do Etanol',
                        labelStyle: TextStyle(color: Colors.lightBlue[900])),
                    style:
                        TextStyle(color: Colors.lightBlue[900], fontSize: 26),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: gasolinaController,
                    textAlign: TextAlign.center,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o valor do Gasolina';
                      }
                      return null;
                    },
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                        labelText: 'Valor do Gasolina',
                        labelStyle: TextStyle(color: Colors.lightBlue[900])),
                    style:
                        TextStyle(color: Colors.lightBlue[900], fontSize: 26),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue[900]),
                              child: const Text(
                                'Verificar',
                                style: TextStyle(fontSize: 25),
                              ),
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  _calculaCombustivelIdeal();
                                }
                              }))),
                  Text(_resultado,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.lightBlue[900], fontSize: 26))
                ]),
          ),
        ));
  }
}
