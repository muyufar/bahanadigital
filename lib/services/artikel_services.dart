part of 'services.dart';

class ArtikelServices {
  static Future<List<ArtikelModel>> getArtikel(
      {required int limit, offset, tag, http.Client? client}) async {
    String url = '${apiHttp}ba_artikel.php';
    client ??= http.Client();

    http.Response response = await client.get(
      Uri.parse('$url?tag=$tag&limit=$limit&offset=$offset'),
    );

    log('tag=$tag&limit=$limit&offset=$offset');
    log('Response Artikel : ${response.body}');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var result = data;
      return List<ArtikelModel>.from(
          result.map((e) => ArtikelModel.fromJson(e)));
    } else {
      throw (Exception(response.statusCode));
    }
  }

  static Future<ArtikelModel> getArtikelById(String id) async {
    var response = await http.get(
      Uri.parse('${apiHttp}ba_artikel.php?id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return ArtikelModel.fromJson(data['data']);
    } else {
      throw Exception('Gagal memuat detail artikel');
    }
  }
}
