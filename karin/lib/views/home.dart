import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:karin/models/msiswa.dart';
import 'package:karin/models/api.dart';
import 'package:karin/views/details.dart';
import 'package:karin/views/create.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<SiswaModel>> sw;

  @override
  void initState() {
    super.initState();
    sw = getSwList();
  }

  Future<List<SiswaModel>> getSwList() async {
    final response = await http.get(Uri.parse(Baseurl.data));
    if (response.statusCode == 200) {
      final List<dynamic> items = json.decode(response.body);
      return items.map((json) => SiswaModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Data Siswa"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: FutureBuilder<List<SiswaModel>>(
          future: sw,
          builder: (context, AsyncSnapshot<List<SiswaModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text("Tidak ada data");
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var data = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    trailing: const Icon(Icons.view_list),
                    title: Text(
                      "${data.nis} ${data.nama}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Text("${data.tplahir}, ${data.tglahir}"),
                    onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Details(sw: data)),
                    );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.green,
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return Create();
          }));
        },
      ),
    );
  }
}
