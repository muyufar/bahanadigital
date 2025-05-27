part of '../services.dart';

class PaymentBrowserService {
  static Future<String> postPaymentToBrowser(
      {required String idTransaksi,
      required String noInvoice,
      required String total,
      required String idUser,
      http.Client? client}) async {
    client ??= http.Client();

    String url = 'https://bahanadigital.com/payment_ba_manual/index.php';
    try {
      http.Response response = await client.post(Uri.parse(url), body: {
        'id_transaksi': idTransaksi,
        'no_invoice': noInvoice,
        'total': total,
        'iduser': idUser,
      });

      log('id_transaksi${idTransaksi}no_invoice${noInvoice}total${total}iduser$idUser');

      log('postPaymentToBrowser${response.body}');

      var data = json.decode(response.body);

      return data['uri'];
    } catch (e) {
      throw (Exception(e));
    }
  }
}
