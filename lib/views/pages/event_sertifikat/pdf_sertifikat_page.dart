part of '../pages.dart';

class PdfSertifikatPage extends StatelessWidget {
  final String linkViewSertifikat;
  final String linkDownloadSertifikat;
  const PdfSertifikatPage(
      {required this.linkDownloadSertifikat,
      required this.linkViewSertifikat,
      super.key});

  @override
  Widget build(BuildContext context) {
    PdfViewerController pdfViewerController = PdfViewerController();
    final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
    return WillPopScope(
      onWillPop: () async {
        navigationPop(context);
        return false;
      },
      child: Stack(
        children: [
          //Background
          Container(color: mainColor),

          SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: mainColor,
                leading: IconButton(
                    onPressed: () {
                      navigationPop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                    )),
              ),
              floatingActionButton: GestureDetector(
                onTap: () async {
                  await canLaunchUrl(Uri.parse(linkDownloadSertifikat))
                      ? launchUrl(
                          Uri.parse(linkDownloadSertifikat),
                          mode: LaunchMode.externalApplication,
                        )
                      : log("Can't open");
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: mainColor,
                  ),
                  child: const Icon(Icons.download, color: Colors.white),
                ),
              ),
              body: SfPdfViewer.network(
                linkViewSertifikat.replaceAll(' ', '%20'),
                controller: pdfViewerController,
                key: pdfViewerKey,
                enableTextSelection: false,
              ),
            ),
          )
        ],
      ),
    );
  }
}
