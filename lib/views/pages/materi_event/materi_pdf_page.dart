part of '../pages.dart';

class MateriPdfPage extends StatefulWidget {
  final String urlPdf;
  const MateriPdfPage(this.urlPdf, {Key? key}) : super(key: key);

  @override
  State<MateriPdfPage> createState() => _MateriPdfPageState();
}

class _MateriPdfPageState extends State<MateriPdfPage> {
  late PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  int index = 0;
  bool isloaded = true;

  @override
  void initState() {
    initializeFile();
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  // ignore: avoid_void_async
  void initializeFile() async {
    final Directory tempPath = await getApplicationDocumentsDirectory();
    final File tempFile1 =
        File(tempPath.path + widget.urlPdf.split('pdfs').last);
    final bool checkFileExist = await tempFile1.exists();
    if (checkFileExist) {
      tempFile = tempFile1;
    }
  }

  @override
  Widget build(BuildContext context) {
    log('URLPDF ${widget.urlPdf.split('pdfs').last}');
    log('URLPDF ${tempFile.toString().split('app_flutter').last.replaceAll("'", '')}');

    if (tempFile.toString().split('app_flutter').last.replaceAll("'", '') !=
        widget.urlPdf.split('pdfs').last) {
      if (listTempFile.length <= 5) {
        listTempFile.add(tempFile);
      }

      if (index == 5) {
        index = 0;
      }

      if (listTempFile.length > 5) {
        listTempFile.insert(index, tempFile);
      }

      tempFile = null;
    }

    while (listTempFile.length > index) {
      if (widget.urlPdf.split('pdfs').last ==
          listTempFile[index]
              .toString()
              .split('app_flutter')
              .last
              .replaceAll("'", '')) {
        tempFile = listTempFile[index];
      }

      index++;
    }

    log('_tempFile $tempFile');

    return WillPopScope(
      onWillPop: () async {
        navigationPop(context);
        return false;
      },
      child: Stack(
        children: [
          //Background
          Container(color: mainColor),
          Scaffold(
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
            body: (tempFile == null)
                ? SfPdfViewer.network(
                    widget.urlPdf.replaceAll(' ', '%20'),
                    controller: _pdfViewerController,
                    key: _pdfViewerKey,
                    enableTextSelection: false,
                    onDocumentLoaded: (PdfDocumentLoadedDetails details) async {
                      // final Directory tempPath =
                      //     await getApplicationDocumentsDirectory();

                      // tempFile = await File(
                      //         tempPath.path + widget.urlPdf.split('pdfs').last)
                      //     .writeAsBytes(details.document.save());

                      log('tes');
                      setState(() {
                        isloaded = false;
                      });
                    },
                  )
                : SfPdfViewer.file(
                    tempFile!,
                    key: _pdfViewerKey,
                    enableTextSelection: false,
                    onDocumentLoaded: (PdfDocumentLoadedDetails details) async {
                      setState(() {
                        isloaded = false;
                      });
                    },
                  ),
          ),

          // (isloaded)
          //     ? const Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     : const SizedBox()
        ],
      ),
    );
  }
}
