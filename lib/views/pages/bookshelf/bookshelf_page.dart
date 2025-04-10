part of '../pages.dart';

class BookshelfPage extends StatefulWidget {
  const BookshelfPage({super.key});

  @override
  State<BookshelfPage> createState() => _BookshelfPageState();
}

bool isBookEvent = false;
bool isRent = false;

class _BookshelfPageState extends State<BookshelfPage> {
  @override
  Widget build(BuildContext context) {
    // EpubViewer.setConfig(
    //     themeColor: Theme.of(context).primaryColor,
    //     identifier: "iosBook",
    //     scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
    //     allowSharing: true,
    //     enableTts: true,
    //     nightMode: true);
    if (!detectUser) {
      navigation(context,
          fromEvent: const GoToMainPage(), toEvent: GoToSignInPage());
    }

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          // // Note: Sensitivity is integer used when you don't want to mess up vertical drag
          // if (details.delta.dx > 10) {
          //   // Right Swipe
          //   setState(() {
          //     isRent = false;
          //   });
          // } else if (details.delta.dx < -10) {
          //   //Left Swipe
          //   setState(() {
          //     isRent = true;
          //   });
          // }
        },
        child: Stack(children: [
          //Background
          Container(color: mainColor),
          SafeArea(child: Container(color: backgroundPhoneColor)),

          (isRent)
              ? const BookShelfRentPage()
              : (isBookEvent)
                  ? const BookEventPage()
                  : const BookShelfBuyPage(),

          SafeArea(
              child: Align(
            alignment: Alignment.topCenter,
            child: ClipPath(
              clipper: HeaderClipper(),
              child: Container(
                height: 80,
                color: mainColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                isRent = false;
                                isBookEvent = false;
                                setState(() {});
                              },
                              child: Text(
                                "Beli",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: textMain,
                                    color: (!isRent && !isBookEvent)
                                        ? Colors.white
                                        : Colors.white),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              height: 4,
                              width: MediaQuery.of(context).size.width * 0.2,
                              color: (!isRent && !isBookEvent)
                                  ? purpleColor
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                isRent = true;
                                isBookEvent = false;

                                setState(() {});
                              },
                              child: Text(
                                "Sewa",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: textMain,
                                    color:
                                        (isRent) ? Colors.white : Colors.white),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              height: 4,
                              width: MediaQuery.of(context).size.width * 0.2,
                              color:
                                  (isRent) ? purpleColor : Colors.transparent,
                            ),
                          ],
                        ),
                        // Column(
                        //   children: [
                        //     GestureDetector(
                        //       onTap: () {
                        //         isRent = false;
                        //         isBookEvent = true;

                        //         setState(() {});
                        //       },
                        //       child: Text(
                        //         "Event",
                        //         style: TextStyle(
                        //             fontSize: 16,
                        //             fontFamily: textMain,
                        //             color: (isBookEvent)
                        //                 ? Colors.white
                        //                 : Colors.white),
                        //       ),
                        //     ),
                        //     Container(
                        //       margin: const EdgeInsets.only(top: 15),
                        //       height: 4,
                        //       width: MediaQuery.of(context).size.width * 0.2,
                        //       color: (isBookEvent)
                        //           ? purpleColor
                        //           : Colors.transparent,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),

          // (isloaded) ? const LoadedListProductVertikal() : const SizedBox()

          //Header
          // SafeArea(
          //   child: HeaderBackArrowandTitlePage('Rak Buku Saya', onTap: () {
          //     navigationPop(context);
          //   }),
          // ),
        ]),
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}

class BookShelfBuyPage extends StatefulWidget {
  const BookShelfBuyPage({super.key});

  @override
  State<BookShelfBuyPage> createState() => _BookShelfBuyPageState();
}

class _BookShelfBuyPageState extends State<BookShelfBuyPage> {
  final ScrollController _scrollController = ScrollController();
  late List<BookshelfModel> _bookshelfModel = [];
  // late List<BookshelfModel> result =
  //     LinkedHashSet<BookshelfModel>.from(_bookshelfModel).toList();
  int limit = 10;

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      ListEbookServices.getBookshelf(idUser, limit: limit, status: 1)
          .then((value) {
        setState(() {
          _bookshelfModel = _bookshelfModel + value;
          limit = limit * 2;
        });
      });
    }
  }

  bool isloaded = false;

  Future<List<BookshelfModel>> bookshelf =
      ListEbookServices.getBookshelf(idUser, limit: 0, status: 1);

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(onScroll);
    return SafeArea(
        child: SizedBox(
      child: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              bookshelf =
                  ListEbookServices.getBookshelf(idUser, limit: 0, status: 1);
              _bookshelfModel = [];
            });
          });
        },
        child: FutureBuilder(
            future: bookshelf,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                List<BookshelfModel> bookshelfModel =
                    snapshot.data as List<BookshelfModel>;
                if (_bookshelfModel.isEmpty) {
                  _bookshelfModel = bookshelfModel;
                }

                return GridView.builder(
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (layarPhoneTablet) ? 5 : 2,
                      crossAxisSpacing: 28,
                      mainAxisSpacing: 8,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width < 411.0)
                              ? 2 / 3.8
                              : 2 / 3.3,
                    ),
                    padding: const EdgeInsets.only(
                        top: 100, left: 28, right: 28, bottom: 90),
                    itemCount: _bookshelfModel.length,
                    itemBuilder: (context, index) {
                      if (index < _bookshelfModel.length) {
                        return CardBookShelfWidget(
                            idBook: _bookshelfModel[index].idBook,
                            title: _bookshelfModel[index].title,
                            writer: _bookshelfModel[index].writer,
                            cover: _bookshelfModel[index].cover,
                            category: _bookshelfModel[index].category,
                            urlPdf: _bookshelfModel[index].urlPdf,
                            sisaHari: _bookshelfModel[index].sisaHari);
                      } else {
                        return CardBookShelfWidget(
                            idBook: _bookshelfModel[index].idBook,
                            title: _bookshelfModel[index].title,
                            writer: _bookshelfModel[index].writer,
                            cover: _bookshelfModel[index].cover,
                            category: _bookshelfModel[index].category,
                            urlPdf: _bookshelfModel[index].urlPdf,
                            sisaHari: _bookshelfModel[index].sisaHari);
                      }
                    });
              } else {
                if (snapshot.hasError) {
                  return Center(
                    child: Lottie.network(
                        'https://assets7.lottiefiles.com/private_files/lf30_hmqi5dfw.json'),
                  );
                } else {
                  return const LoadedListProductVertikal();
                }
              }
            }),
      ),
    ));
  }
}

class BookShelfRentPage extends StatefulWidget {
  const BookShelfRentPage({super.key});

  @override
  State<BookShelfRentPage> createState() => _BookShelfRentPageState();
}

class _BookShelfRentPageState extends State<BookShelfRentPage> {
  final ScrollController _scrollController = ScrollController();
  late List<BookshelfModel> _bookshelfModel = [];
  // late List<BookshelfModel> result =
  //     LinkedHashSet<BookshelfModel>.from(_bookshelfModel).toList();
  int limit = 10;

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      ListEbookServices.getBookshelf(idUser, limit: limit, status: 2)
          .then((value) {
        setState(() {
          _bookshelfModel = _bookshelfModel + value;
          limit = limit * 2;
        });
      });
    }
  }

  bool isloaded = false;

  Future<List<BookshelfModel>> bookshelf =
      ListEbookServices.getBookshelf(idUser, limit: 0, status: 2);
  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(onScroll);
    return SafeArea(
        child: SizedBox(
      child: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              bookshelf =
                  ListEbookServices.getBookshelf(idUser, limit: 0, status: 2);
              _bookshelfModel = [];
            });
          });
        },
        child: FutureBuilder(
            future: bookshelf,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                List<BookshelfModel> bookshelfModel =
                    snapshot.data as List<BookshelfModel>;
                if (_bookshelfModel.isEmpty) {
                  _bookshelfModel = bookshelfModel;
                }

                return GridView.builder(
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (layarPhoneTablet) ? 5 : 2,
                      crossAxisSpacing: 28,
                      mainAxisSpacing: 8,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width < 411.0)
                              ? 2 / 3.8
                              : 2 / 3.3,
                    ),
                    padding: const EdgeInsets.only(
                        top: 100, left: 28, right: 28, bottom: 90),
                    itemCount: _bookshelfModel.length,
                    itemBuilder: (context, index) {
                      if (index < _bookshelfModel.length) {
                        return CardBookShelfWidget(
                            idBook: _bookshelfModel[index].idBook,
                            title: _bookshelfModel[index].title,
                            writer: _bookshelfModel[index].writer,
                            cover: _bookshelfModel[index].cover,
                            category: _bookshelfModel[index].category,
                            urlPdf: _bookshelfModel[index].urlPdf,
                            sisaHari: _bookshelfModel[index].sisaHari);
                      } else {
                        return CardBookShelfWidget(
                          idBook: _bookshelfModel[index].idBook,
                          title: _bookshelfModel[index].title,
                          writer: _bookshelfModel[index].writer,
                          cover: _bookshelfModel[index].cover,
                          category: _bookshelfModel[index].category,
                          urlPdf: _bookshelfModel[index].urlPdf,
                          sisaHari: _bookshelfModel[index].sisaHari,
                        );
                      }
                    });
              } else {
                if (snapshot.hasError) {
                  return Center(
                    child: Lottie.network(
                        'https://assets7.lottiefiles.com/private_files/lf30_hmqi5dfw.json'),
                  );
                } else {
                  return const LoadedListProductVertikal();
                }
              }
            }),
      ),
    ));
  }
}

class BookEventPage extends StatefulWidget {
  const BookEventPage({super.key});

  @override
  State<BookEventPage> createState() => _BookEventPageState();
}

class _BookEventPageState extends State<BookEventPage> {
  final ScrollController _scrollController = ScrollController();
  late List<BookshelfModel> _bookshelfModel = [];
  // late List<BookshelfModel> result =
  //     LinkedHashSet<BookshelfModel>.from(_bookshelfModel).toList();
  int limit = 10;

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      ListEbookServices.getBookshelf(idUser, limit: limit, status: 3)
          .then((value) {
        setState(() {
          _bookshelfModel = _bookshelfModel + value;
          limit = limit * 2;
        });
      });
    }
  }

  bool isloaded = false;

  Future<List<BookshelfModel>> bookshelf =
      ListEbookServices.getBookshelf(idUser, limit: 0, status: 3);
  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(onScroll);
    return SafeArea(
        child: SizedBox(
      child: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              bookshelf =
                  ListEbookServices.getBookshelf(idUser, limit: 0, status: 2);
              _bookshelfModel = [];
            });
          });
        },
        child: FutureBuilder(
            future: bookshelf,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                List<BookshelfModel> bookshelfModel =
                    snapshot.data as List<BookshelfModel>;
                if (_bookshelfModel.isEmpty) {
                  _bookshelfModel = bookshelfModel;
                }

                return GridView.builder(
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (layarPhoneTablet) ? 5 : 2,
                      crossAxisSpacing: 28,
                      mainAxisSpacing: 8,
                      childAspectRatio:
                          (MediaQuery.of(context).size.width < 411.0)
                              ? 2 / 3.8
                              : 2 / 3.3,
                    ),
                    padding: const EdgeInsets.only(
                        top: 100, left: 28, right: 28, bottom: 90),
                    itemCount: _bookshelfModel.length,
                    itemBuilder: (context, index) {
                      if (index < _bookshelfModel.length) {
                        return CardBookShelfWidget(
                          idBook: _bookshelfModel[index].idBook,
                          title: _bookshelfModel[index].title,
                          writer: _bookshelfModel[index].writer,
                          cover: _bookshelfModel[index].cover,
                          category: _bookshelfModel[index].category,
                          urlPdf: _bookshelfModel[index].urlPdf,
                          sisaHari: _bookshelfModel[index].sisaHari,
                        );
                      } else {
                        return CardBookShelfWidget(
                          idBook: _bookshelfModel[index].idBook,
                          title: _bookshelfModel[index].title,
                          writer: _bookshelfModel[index].writer,
                          cover: _bookshelfModel[index].cover,
                          category: _bookshelfModel[index].category,
                          urlPdf: _bookshelfModel[index].urlPdf,
                          sisaHari: bookshelfModel[index].sisaHari,
                        );
                      }
                    });
              } else {
                if (snapshot.hasError) {
                  return Center(
                    child: Lottie.network(
                        'https://assets7.lottiefiles.com/private_files/lf30_hmqi5dfw.json'),
                  );
                } else {
                  return const LoadedListProductVertikal();
                }
              }
            }),
      ),
    ));
  }
}
