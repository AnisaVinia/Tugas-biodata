class SiswaModel {
  final int id;
  final String nis;
  final String nama;
  final String tplahir;
  final String tglahir;
  final String kelamin;
  final String agama;
  final String alamat;

  SiswaModel({
    required this.id,
    required this.nis,
    required this.nama,
    required this.tplahir,
    required this.tglahir,
    required this.kelamin,
    required this.agama,
    required this.alamat,
  });
 
  factory SiswaModel.fromJson(Map<String, dynamic> json) {
    return SiswaModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      nis: json['nis'] ?? '',
      nama: json['nama'] ?? '',
      tplahir: json['tplahir'] ?? '',
      tglahir: json['tglahir'] ?? '',
      kelamin: json['kelamin'] ?? '',
      agama: json['agama'] ?? '',
      alamat: json['alamat'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nis': nis,
        'nama': nama,
        'tplahir': tplahir,
        'tglahir': tglahir,
        'kelamin': kelamin,
        'agama': agama,
        'alamat': alamat,
      };
}
