import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  File? image;
  final picker = ImagePicker();
  final ma9 = TextEditingController();
  final ma20 = TextEditingController();
  final ma50 = TextEditingController();
  final macdH = TextEditingController();
  final macdS = TextEditingController();
  String result = "";

  void pickImage() async {
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);
    if(img!=null) setState(()=> image = File(img.path));
  }

  void analyze(){
    double m9 = double.tryParse(ma9.text) ?? 0;
    double m20 = double.tryParse(ma20.text) ?? 0;
    double m50 = double.tryParse(ma50.text) ?? 0;
    double h = double.tryParse(macdH.text) ?? 0;
    double s = double.tryParse(macdS.text) ?? 0;

    if(m9>m20 && m20>m50 && h>s) result="Tendência de ALTA";
    else if(m9<m20 && m20<m50 && h<s) result="Tendência de BAIXA";
    else result="Neutro / Indefinido";

    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trade Fácil HC")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            ElevatedButton(onPressed: pickImage, child: Text("Enviar Print")),
            if(image!=null) Image.file(image!, height:180),

            SizedBox(height:20),
            Text("Indicadores:", style: TextStyle(fontSize:18)),
            TextField(controller: ma9, decoration: InputDecoration(labelText:"MM9")),
            TextField(controller: ma20, decoration: InputDecoration(labelText:"MM20")),
            TextField(controller: ma50, decoration: InputDecoration(labelText:"MM50")),
            TextField(controller: macdH, decoration: InputDecoration(labelText:"MACD Hist")),
            TextField(controller: macdS, decoration: InputDecoration(labelText:"MACD Signal")),

            SizedBox(height:20),
            ElevatedButton(onPressed: analyze, child: Text("Analisar")),

            if(result.isNotEmpty)
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(result, style: TextStyle(fontSize:20, color: Colors.blue)),
              )
          ],
        ),
      ),
    );
  }
}
