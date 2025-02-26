import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:karin/models/msiswa.dart';
import 'package:karin/models/api.dart';
import 'package:karin/widgets/form.dart';

class Edit extends StatefulWidget {
  final SiswaModel sw;

  const Edit({super.key, required this.sw});

  @override
  EditState createState() => EditState();
}

class EditState extends State<Edit> {
  final formkey = GlobalKey<FormState>();

  late TextEditingController nisController,
      namaController,
      tpController,
      tgController,
      kelaminController,
      agamaController,
      alamatController;

  @override
  void initState() {
    super.initState();
    nisController = TextEditingController(text: widget.sw.nis);
    namaController = TextEditingController(text: widget.sw.nama);
    tpController = TextEditingController(text: widget.sw.tplahir);
    tgController = TextEditingController(text: widget.sw.tglahir);
    kelaminController = TextEditingController(text: widget.sw.kelamin);
    agamaController = TextEditingController(text: widget.sw.agama);
    alamatController = TextEditingController(text: widget.sw.alamat);
  }

  Future<http.Response> editSw() async {
    try {
      final response = await http
          .post(
            Uri.parse(Baseurl.edit),
            body: {
              "id": widget.sw.id.toString(),
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
      throw Exception('Gagal mengupdate data: $e');
    }
  }

  void _showToast(String message, {bool isSuccess = true}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _onConfirm(BuildContext context) async {
    if (!formkey.currentState!.validate()) {
      _showToast("Harap lengkapi semua data!", isSuccess: false);
      return;
    }

    // Tampilkan loading saat proses berjalan
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final response = await editSw();
      Navigator.of(context).pop(); // Tutup dialog loading

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _showToast("Perubahan Data Berhasil disimpan");
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        } else {
          _showToast(data['message'] ?? "Gagal menyimpan data.", isSuccess: false);
        }
      } else {
        _showToast("Error ${response.statusCode}: Gagal mengupdate data.", isSuccess: false);
      }
    } catch (e) {
      Navigator.of(context).pop(); // Tutup dialog jika error
      _showToast(e.toString(), isSuccess: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () => _onConfirm(context),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.green,
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          child: const Text("Update"),
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Center(
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
    );
  }
}
