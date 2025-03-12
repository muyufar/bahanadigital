part of '../pages.dart';

class LisrMateriEventPage extends StatelessWidget {
  const LisrMateriEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigationPop(context);
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            //Background
            Container(color: mainColor),
            SafeArea(child: Container(color: backgroundPhoneColor)),

            //List Materi Event
            SafeArea(
              child: Padding(
                  padding: const EdgeInsets.only(top: 80, left: 16, right: 16),
                  child: FutureBuilder(
                    future: MateriEventService.getListMaterialEvent(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ListMateriEventModel> listMateriEventModel =
                            snapshot.data as List<ListMateriEventModel>;

                        return ListView.builder(
                          itemCount: listMateriEventModel.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  if (listMateriEventModel[index].fileEvent ==
                                      '0') {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const AlertDialog(
                                            title: Text('Info'),
                                            content: Text(
                                                'Belum ada materi untuk event ini'),
                                          );
                                        });
                                  } else {
                                    navigation(context,
                                        fromEvent:
                                            const GoToLisrMateriEventPage(),
                                        toEvent: GoToMateriPdfPage(
                                            listMateriEventModel[index]
                                                .statusFileEvent));
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 20, left: 16, right: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3)),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(top: 116),
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(16),
                                              bottomRight: Radius.circular(16)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              (layarPhoneTablet)
                                                  ? const SizedBox(height: 250)
                                                  : const SizedBox(),
                                              Text(
                                                  listMateriEventModel[index]
                                                      .namaPromo,
                                                  style: textBold),
                                              Text(
                                                  listMateriEventModel[index]
                                                      .tanggalAcaraEvent,
                                                  style: TextStyle(
                                                      fontFamily: textMain,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: grayColor)),
                                              Text(
                                                  listMateriEventModel[index]
                                                      .deskripsiPromo,
                                                  style: TextStyle(
                                                      fontFamily: textMain)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: (layarPhoneTablet) ? 370 : 130,
                                        decoration: BoxDecoration(
                                          color: grayColor,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  listMateriEventModel[index]
                                                      .filePromo),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        );
                      } else {
                        if (snapshot.hasError) {
                          return const Center(child: Text('Belum ada data'));
                        }
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )),
            ),

            //header
            SafeArea(
              child: HeaderBackArrowandTitlePage('Buku Event',
                  onTap: () => navigationPop(context)),
            )
          ],
        ),
      ),
    );
  }
}
