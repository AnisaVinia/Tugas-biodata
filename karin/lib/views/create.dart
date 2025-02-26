import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:karin/models/api.dart';
import 'package:karin/widgets/form.dart';

class Create extends StatefulWidget {
  @override
  CreateState createState() => CreateState();
}

class CreateState extends State<Create> {
  final formkey = GlobalKey<FormState>();

  final nisController = TextEditingController();
  final namaController = TextEditingController();
  final tpController = TextEditingController();
  final tgController = TextEditingController();
  final kelaminController = TextEditingController();
  final agamaController = TextEditingController();
  final alamatController = TextEditingController();

  Future<http.Response> createSw() async {
    try {
      final response = await http
          .post(
            Uri.parse(Baseurl.tambah),
            body: {
              "nis": nisController.text,
              "nama": namaController.text,
              "tplahir": tpController.text,
              "tglahir": tgController.text,
              "kelamin": kelaminController.text,
              "agama": agamaController.text,
              "alamat": alamatController.text,
            },
          )
          .timeout(const Duration(seconds: 10)); // Tambahkan timeout
      return response;
    } catch (e) {
      throw Exception('Gagal menyimpan data: $e');
    }
  }

  void _onConfirm(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final response = await createSw();
      Navigator.of(context).pop(); // Tutup loading

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Berhasil disimpan!")),
          );
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        } else {
          _showError(context, data['message'] ?? 'Gagal menyimpan.');
        }
      } else {
        _showError(context, 'Server error: ${response.statusCode}');
      }
    } catch (e) {
      Navigator.of(context).pop(); // Pastikan loading ditutup saat error
      _showError(context, e.toString());
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: const Text("Simpan"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.green,
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          onPressed: () {
            if (formkey.currentState!.validate()) {
              _onConfirm(context);
            }
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: AppForm(
              formkey: formkey,
              nisController: nisController,
              namaController: namaController,
              tpController: tpController,
              tgController: tgController,
              kelaminController: kelaminController,
              agamaController: agamaController,
              alamatController: alamatController,
            ),
          ),
        ),
      ),
    );
  }
}
