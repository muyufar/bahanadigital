part of '../services.dart';

class MateriEventService {
  //List Material Event
  static Future<List<ListMateriEventModel>> getListMaterialEvent(
      {http.Client? client}) async {
    String url = '${apiHttp}ba_event.php';
    client ??= http.Client();

    try {
      http.Response response = await client.post(Uri.parse(url),
          body: {'tag': 'listfileevent', 'id_user': idUser});

      log('Response List Material Event : ${response.body}');

      var data = jsonDecode(response.body);
      return List<ListMateriEventModel>.from(
          data.map((e) => ListMateriEventModel.fromJson(e)));
    } catch (e) {
      throw (Exception(e));
    }
  }
}
