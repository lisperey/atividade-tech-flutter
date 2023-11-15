// import 'dart:ffi';

import 'dart:collection';

import 'package:flutter/material.dart';

class NumeroRomano extends StatefulWidget {
  const NumeroRomano({super.key});

  @override
  State<NumeroRomano> createState() => _NumeroRomanoState();
}

class _NumeroRomanoState extends State<NumeroRomano> {
  final _romano = TextEditingController();
  final _arabico = TextEditingController();
  final arrayNumero = {
    'I': 1,
    'IV': 4,
    'V': 5,
    'IX': 9,
    'X': 10,
    'XL': 40,
    'L': 50,
    'XC': 90,
    'C': 100,
    'CD': 400,
    'D': 500,
    'CM': 900,
    'M': 1000
  };
  var numeroRetornoArabico = '';
  var numeroRetornoRomano = '';

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
      width: 300,
      height: 300,
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 40,
            child: TextFormField(
              controller: _romano,
              onChanged: (value) => {romanoToarabico(value)},
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Número Romano',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child:Text('Valor Arabico: $numeroRetornoArabico'),),
          SizedBox(
            width: 200,
            height: 40,
            child: TextFormField(
              controller: _arabico,
              onChanged: (value) => {arabicoToromano(value)},
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Número Arabico',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text('Valor Romano: $numeroRetornoRomano'),
          ),
        ],
      ),
    ), );
  }

  romanoToarabico(value) {
    if (_romano.text.isEmpty) {
      setState(() {
        numeroRetornoRomano = '';
      });
      return;
    }
    if (int.tryParse(value) != null) {
      setState(() {
        numeroRetornoArabico = 'Informe um número Romano';
      });
      return;
    }
    var numeroRetorno = 0;
    var numeros = arrayNumero;
    var romano = value.toUpperCase();
    for (int i = 0; i < romano.length; i++) {
      if (!numeros.containsKey(romano[i])) {
        setState(() {
          numeroRetornoArabico = 'Error.';
        });
        return;
      }
      var proxValue = 0;
      if ((i + 1) < romano.length) {
        proxValue = numeros.keys.contains(romano[i + 1])
            ? numeros.entries
                .firstWhere((entry) => entry.key == romano[i + 1])
                .value
            : 0;
      }

      if (proxValue >
          numeros.entries.firstWhere((entry) => entry.key == romano[i]).value) {
        numeroRetorno += (proxValue -
            numeros.entries
                .firstWhere((entry) => entry.key == romano[i])
                .value);
        i++;
      } else {
        numeroRetorno +=
            numeros.entries.firstWhere((entry) => entry.key == romano[i]).value;
      }
    }

    setState(() {
      numeroRetornoArabico = numeroRetorno.toString();
    });
  }

  arabicoToromano(value) {
    if (_arabico.text.isEmpty) {
      setState(() {
        numeroRetornoRomano = '';
      });
      return;
    }
    var arabico = int.tryParse(value);
    if (arabico == null) {
      setState(() {
        numeroRetornoRomano = 'Informe um número Arabico';
      });
      return;
    }

    var numeros = arrayNumero.entries.toList().reversed;
    var numeroRetorno = '';

    for (var e in numeros) {
      while (arabico! >= e.value) {
        numeroRetorno += e.key;
        arabico -= e.value;
      }
    }
    setState(() {
      numeroRetornoRomano = numeroRetorno;
    });
  }
}
