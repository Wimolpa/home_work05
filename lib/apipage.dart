import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:home_work05/cartoons.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
// State variable
  List<cartoon>? _cartoons;

// เมธอดสำหรับโหลดข้อมูล
  void _getCountries() async {
    var dio = Dio(BaseOptions(responseType: ResponseType.plain));
    var response =
        await dio.get('https://api.sampleapis.com/rickandmorty/characters');
    List list = jsonDecode(response.data);

    setState(() {
      _cartoons = list.map((cartoons) => cartoon.fromJson(cartoons)).toList();

      //     // เรียงลำดับตามชื่อจาก A ไป Z (กรณีต้องการเรียงลำดับ)
      _cartoons!.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  @override
  void initState() {
    super.initState();
    // เรียกเมธอดสำหรับโหลดข้อมูลใน initState() ของคลาสที่ extends มาจาก State
    _getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _cartoons == null
                ? SizedBox.shrink()
                : ListView.builder(
                    itemCount: _cartoons!.length,
                    itemBuilder: (context, index) {
                      var cartoons = _cartoons![index];
                      return ListTile(
                        title: Text(cartoons.name ?? ''),
                        subtitle: Text(cartoons.type ?? ''),
                        // leading: Text(country.long_name ?? ''),
                        trailing: Image.network(cartoons.image),
                        onTap: () {
                          _showMyDialog(
                              cartoons.name,
                              cartoons.status,
                              cartoons.species,
                              cartoons.gender,
                              cartoons.image,
                              cartoons.type);
                        },
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }

  Future<void> _showMyDialog(String name, String status, String species, String gender, String image, String? type) async {
  cartoon c = new cartoon(name: name, image: image, type: type, status: status, species: species, gender: gender);
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(name ?? ''),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Status : '+ c.status),
              Text('Species : '+ c.species),
              Text('Gender : '+ c.gender),
              Image.network(c.image),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('CLOSE'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

}
