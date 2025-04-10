part of 'routes.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    if (prevPageEvant is! GoToMainPage) {
      prevPageEvant = const GoToMainPage();
      context.read<PagesBloc>().add(prevPageEvant!);
    }
    void checkVersion() async {
      // final newVersion = NewVersion(androidId: 'id.ags.bahana_digital');
      // NewVersion(androidId: 'id.ags.bahana_digital')
      //     .showAlertIfNecessary(context: context);
      // final newVersion = NewVersion(androidId: 'com.example.bahana_digital');
      // final newVersion = NewVersion(androidId: 'com.snapchat.android');

      // final status = await newVersion.getVersionStatus();

      // newVersion.showUpdateDialog(
      //   context: context,
      //   versionStatus: status!,
      //   dialogTitle: 'Update Bahana Digital?',
      //   dialogText:
      //       'Bahana Digital recommends that you update to the latest version. You can keep using this app while downloading the update.',
      // );
      // log('Device : ' + status.localVersion);
      // log('Device : ' + status.storeVersion);

      final newVersion = NewVersion(androidId: 'id.ags.bahana_digital');
      final status = await newVersion.getVersionStatus();

      if (status != null) {
        if (status.canUpdate) {
          newVersion.showUpdateDialog(
              context: context,
              versionStatus: status,
              dialogTitle: 'Bahana Digital',
              dialogText: status.releaseNotes,
              allowDismissal: false);
        }
      }
    }

    checkVersion();
    return BlocBuilder<PagesBloc, PagesState>(builder: (_, pageSate) {
      return StreamBuilder<ConnectivityResult>(
        stream: Connectivity()
            .onConnectivityChanged
            .map((results) => results.first),
        builder: (_, snapshot) {
          return (snapshot.data != ConnectivityResult.none)
              ? (pageSate is OnMorePage)
                  ? (MorePage(
                      tag: pageSate.tag,
                      idCategory: pageSate.idCategory,
                      searchTitle: pageSate.searchTitle,
                      tagMore: pageSate.tagMore,
                    ))
                  : (pageSate is OnProductDetailsPage)
                      ? (ProductDetailsPage(
                          idBook: pageSate.idBook,
                        ))
                      : (pageSate is OnSignInPage)
                          ? (const SignInPage())
                          : (pageSate is OnSignUpPage)
                              ? (const SignUp())
                              : (pageSate is OnCartPage)
                                  ? (const CartPage())
                                  : (pageSate is OnTransactionPage)
                                      ? (const TransactionPage())
                                      : (pageSate is OnBookshelfPage)
                                          ? (const BookshelfPage())
                                          : (pageSate is OnPDFViewPage)
                                              ? (PDFViewPage(pageSate.urlPdf))
                                              : (pageSate is OnEpubViewPage)
                                                  ? (EpubViewPage(
                                                      idBook: pageSate.idBook,
                                                      url: pageSate.url))
                                                  : (pageSate is OnPaymentPage)
                                                      ? (PaymentPage(
                                                          noInvoice: pageSate
                                                              .noInvoice,
                                                          idTransaction: pageSate
                                                              .idTransaction,
                                                          totalPrice: pageSate
                                                              .totalPrice))
                                                      : (pageSate
                                                              is OnEditProfilePage)
                                                          ? (EditProfilePage(
                                                              nameUser: pageSate
                                                                  .nameUser,
                                                              email: pageSate
                                                                  .email,
                                                              linkImage: pageSate
                                                                  .linkImage,
                                                              noPhone: pageSate
                                                                  .noPhone))
                                                          : (pageSate
                                                                  is OnDetailTransactionPage)
                                                              ? (DetailTransactionPage(
                                                                  idTransaction:
                                                                      pageSate
                                                                          .idTransaction))
                                                              : (pageSate
                                                                      is OnAddPaymentPage)
                                                                  ? (AddPaymentPage(
                                                                      addPaymentModel:
                                                                          pageSate
                                                                              .addPaymentModel,
                                                                      isEvent:
                                                                          pageSate
                                                                              .isEvent,
                                                                    ))
                                                                  : (pageSate
                                                                          is OnAdsDetailPage)
                                                                      ? (AdsDetailPage(
                                                                          idAds: pageSate
                                                                              .idAds,
                                                                          tag: pageSate
                                                                              .tag))
                                                                      : (pageSate
                                                                              is OnVerificationEmailPage)
                                                                          ? (VerificationEmailPage(
                                                                              fromSingUp: pageSate.fromSingUp,
                                                                              email: pageSate.email))
                                                                          : (pageSate is OnTransactionMidtransPage)
                                                                              ? (TransactionMidtransPage(url: pageSate.url))
                                                                              : (pageSate is OnEventPage)
                                                                                  ? (const EventPage())
                                                                                  : (pageSate is OnDataEventPage)
                                                                                      ? (const DataEventPage())
                                                                                      : (pageSate is OnTicketEventPage)
                                                                                          ? (const TicketPage())
                                                                                          : (pageSate is OnEventSertifikatPage)
                                                                                              ? (const EventSertifikatPage())
                                                                                              : (pageSate is OnTransactionEventPage)
                                                                                                  ? (const TransactionEventPage())
                                                                                                  : (pageSate is OnInfoEventPage)
                                                                                                      ? (const InfoEventPage())
                                                                                                      : (pageSate is OnDetailEventPage)
                                                                                                          ? (DetailEventPage(pageSate.idPromo))
                                                                                                          : (pageSate is OnPaymentEventPage)
                                                                                                              ? (PaymentEventPage(idTransaksi: pageSate.idTransaksi, noInvoice: pageSate.noInvoice))
                                                                                                              : (pageSate is OnDetailTransaksiEventPage)
                                                                                                                  ? (DetailTransaksiEventPage(idTransaksi: pageSate.idTransaksi))
                                                                                                                  : (pageSate is OnLisrMateriEventPage)
                                                                                                                      ? (const LisrMateriEventPage())
                                                                                                                      : (pageSate is OnMateriPdfPage)
                                                                                                                          ? (MateriPdfPage(pageSate.urlPdf))
                                                                                                                          : (pageSate is OnPdfSertifikatPage)
                                                                                                                              ? (PdfSertifikatPage(linkDownloadSertifikat: pageSate.linkDownloadSertifikat, linkViewSertifikat: pageSate.linkViewSertifikat))
                                                                                                                              : (pageSate is onArtikelPage)
                                                                                                                                  ? (const ArtikelPage())
                                                                                                                                  // : (pageSate is OnDetailArtikelPage)
                                                                                                                                  // ? (ArtikelDetailPage(artikel: pageSate.idArtikel))
                                                                                                                                  : MainPage(bottomNavBarIndex: (pageSate as OnMainPage).bottomNavBarIndex)
              : const NoConnectionPage();
        },
      );
    });
  }
}
