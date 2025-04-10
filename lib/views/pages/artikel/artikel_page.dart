part of '../pages.dart';

class ArtikelPage extends StatefulWidget {
  const ArtikelPage({super.key});

  @override
  State<ArtikelPage> createState() => ArtikelPageState();
}

class ArtikelPageState extends State<ArtikelPage> {
  String searchQuery = '';
  int offset = 0;
  List<ArtikelModel> artikelList = [];
  bool isLoading = false;
  bool hasMoreData = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (hasMoreData) {
          loadMoreData();
        }
      }
    });
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    List<ArtikelModel> newData = await ArtikelServices.getArtikel(
        tag: 'semua', limit: 10, offset: offset);
    setState(() {
      artikelList = newData;
      isLoading = false;
      hasMoreData = newData.length == 10;
    });
  }

  Future<void> loadMoreData() async {
    if (!isLoading && hasMoreData) {
      setState(() {
        isLoading = true;
      });
      offset += 10;
      List<ArtikelModel> newData = await ArtikelServices.getArtikel(
          tag: 'semua', limit: 10, offset: offset);
      setState(() {
        artikelList.addAll(newData);
        isLoading = false;
        hasMoreData = newData.length == 10;
      });
    }
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 16,
                    width: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 12,
                    width: 80,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!detectUser) {
      navigation(context,
          fromEvent: const GoToMainPage(), toEvent: GoToSignInPage());
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(color: mainColor),
          SafeArea(child: Container(color: backgroundPhoneColor)),
          SafeArea(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: blackColor),
                      onPressed: () => navigationPop(context),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Artikel',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: textMain,
                        fontWeight: FontWeight.bold,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari Artikel',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: grayColor),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (isLoading && artikelList.isEmpty)
                  Column(
                    children:
                        List.generate(3, (index) => _buildShimmerLoading()),
                  )
                else if (artikelList.isEmpty)
                  Center(
                    child: Text(
                      'Artikel tidak ditemukan',
                      style: TextStyle(
                        fontFamily: textMain,
                        color: blackColor,
                      ),
                    ),
                  )
                else
                  Column(
                    children: [
                      ...artikelList
                          .where((artikel) => artikel.judul
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()))
                          .map((artikel) => GestureDetector(
                                onTap: () {
                                  if (artikel.pdfUrl != null &&
                                      artikel.pdfUrl.isNotEmpty) {
                                    navigation(
                                      context,
                                      fromEvent: GoToArtikelPage(),
                                      toEvent: GoToPDFViewPage(
                                        urlPdf: artikel.pdfUrl
                                                .startsWith('http')
                                            ? artikel.pdfUrl
                                            : 'http://103.137.254.78/andibook/pdfartikel/${artikel.pdfUrl}',
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl: artikel.cover
                                                  .startsWith('http')
                                              ? artikel.cover
                                              : 'http://103.137.254.78/andibook/imageartikel/${artikel.cover}',
                                          width: 80,
                                          height: 120,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(
                                            color: const Color.fromARGB(
                                                255, 70, 62, 62),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              artikel.judul,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: textMain,
                                                fontWeight: FontWeight.bold,
                                                color: blackColor,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              artikel.penulis,
                                              style: TextStyle(
                                                fontFamily: textMain,
                                                color: grayColor,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              artikel.tglPosting,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: textMain,
                                                color: grayColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                      if (isLoading)
                        _buildShimmerLoading()
                      else if (!hasMoreData && artikelList.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Semua artikel telah dimuat',
                            style: TextStyle(
                              fontFamily: textMain,
                              color: grayColor,
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
