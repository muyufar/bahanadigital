part of '../models.dart';

class ListMateriEventModel extends Equatable {
  final String idTransaksi;
  final String hargaNormal;
  final String namaPromo;
  final String filePromo;
  final String linkPromo;
  final String deskripsiPromo;
  final String fileEvent;
  final String statusFileEvent;
  final String ketEvent;
  final String statusLink;
  final String tanggalAcaraEvent;
  const ListMateriEventModel({
    required this.idTransaksi,
    required this.hargaNormal,
    required this.namaPromo,
    required this.filePromo,
    required this.linkPromo,
    required this.deskripsiPromo,
    required this.fileEvent,
    required this.statusFileEvent,
    required this.ketEvent,
    required this.statusLink,
    required this.tanggalAcaraEvent,
  });

  factory ListMateriEventModel.fromJson(Map<String, dynamic> json) =>
      ListMateriEventModel(
        idTransaksi: json["id_transaksi"]??'',
        hargaNormal: json["harga_normal"]??'',
        namaPromo: json["nama_promo"]??'',
        filePromo: json["file_promo"]??'',
        linkPromo: json["link_promo"]??'',
        deskripsiPromo: json["deskripsi_promo"]??'',
        fileEvent: json["file_event"]??'',
        statusFileEvent: json["status_file_event"]??'',
        ketEvent: json["ket_event"]??'',
        statusLink: json["status_link"]??'',
        tanggalAcaraEvent: json["tanggal_acara_event"]??'',
      );

  @override
  List<Object?> get props => [
        idTransaksi,
        hargaNormal,
        namaPromo,
        filePromo,
        linkPromo,
        deskripsiPromo,
        fileEvent,
        statusFileEvent,
        ketEvent,
        statusLink,
        tanggalAcaraEvent
      ];
}
