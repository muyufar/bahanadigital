part of 'models.dart';

class ArtikelModel extends Equatable {
  final String idArtikel;
  final String judul;
  final String cover;
  final String penulis;
  final String pdfUrl;
  final String halaman;
  final String tglPosting;

  const ArtikelModel({
    required this.idArtikel,
    required this.judul,
    required this.cover,
    required this.penulis,
    required this.pdfUrl,
    required this.halaman,
    required this.tglPosting,
  });

  factory ArtikelModel.fromJson(Map<String, dynamic> json) {
    return ArtikelModel(
      idArtikel: json['id_artikel'] ?? '',
      judul: json['judul'] ?? '',
      cover: json['cover'] ?? '',
      penulis: json['penulis'] ?? '',
      pdfUrl: json['pdf_url'] ?? '',
      halaman: json['halaman'] ?? '',
      tglPosting: json['tgl_posting'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        idArtikel,
        judul,
        cover,
        penulis,
        pdfUrl,
        halaman,
        tglPosting,
      ];
}