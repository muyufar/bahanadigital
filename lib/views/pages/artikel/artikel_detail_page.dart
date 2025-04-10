part of '../pages.dart';

class ArtikelDetailPage extends StatefulWidget {
  final ArtikelModel artikel;
  const ArtikelDetailPage({required this.artikel, super.key});

  @override
  State<ArtikelDetailPage> createState() => ArtikelDetailPageState();
}

class ArtikelDetailPageState extends State<ArtikelDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(color: mainColor),
          SafeArea(child: Container(color: backgroundPhoneColor)),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  color: mainColor,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: whiteColor,
                        ),
                        onPressed: () {
                          navigationPop(context);
                        },
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Detail Artikel',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: textMain,
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Article Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Cover Image
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: widget.artikel.cover,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[300],
                                height: 200,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Title
                        Text(
                          widget.artikel.judul,
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: textMain,
                            fontWeight: FontWeight.bold,
                            color: blackColor,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Author and Date
                        Text(
                          'Oleh ${widget.artikel.penulis}',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: textMain,
                            color: grayColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.artikel.tglPosting,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: textMain,
                            color: grayColor,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Read PDF Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () async {
                              String url = widget.artikel.pdfUrl;
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(
                                  Uri.parse(url),
                                  mode: LaunchMode.externalApplication,
                                );
                              } else {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Tidak dapat membuka PDF'),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Text(
                              'Baca Artikel',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: textMain,
                                fontWeight: FontWeight.bold,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
