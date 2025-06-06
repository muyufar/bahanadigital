import 'dart:async';
import 'dart:developer';
import 'dart:io';
// import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:palette_generator/palette_generator.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:lottie/lottie.dart';

import 'package:bahanaki/bloc/bloc.dart';
import 'package:bahanaki/models/models.dart';
import 'package:bahanaki/routes/routes.dart';
import 'package:bahanaki/shared/shared.dart';
import 'package:bahanaki/services/services.dart';
import 'package:bahanaki/views/widgets/widgets.dart';

part 'ads/ads_detail_page.dart';
part 'auth/sign_in_page.dart';
part 'auth/sign_up_page.dart';
part 'auth/verification_email_page.dart';
part 'blog/blog_page.dart';
part 'bookshelf/bookshelf_page.dart';
part 'bookshelf/pdf_view_page.dart';
part 'bookshelf/epub_view_page.dart';
part 'cart/cart_page.dart';
part 'data_event/data_event.dart';
part 'data_event/detail_event.dart';
part 'edit_profile/edit_profile_page.dart';
part 'event/event_page.dart';
part 'event_sertifikat/event_sertifikat_page.dart';
part 'event_sertifikat/pdf_sertifikat_page.dart';
part 'home/home_page.dart';
part 'home/home_banner_page.dart';
part 'home/home_list_product_page.dart';
part 'home/home_package_page.dart';
part 'home/home_category_page.dart';
part 'home/home_ads_page.dart';
part 'info/info_page.dart';
part 'main_page.dart';
part 'materi_event/list_materi_event_page.dart';
part 'materi_event/materi_pdf_page.dart';
part 'more/more_page.dart';
part 'more/more_content_page.dart';
part 'no_connection_page/no_connection_page.dart';
part 'notifications/notifications_page.dart';
part 'payment/payment_page.dart';
part 'payment/payment_event_page.dart';
part 'payment/add_payment_page.dart';
part 'product_details/product_details_page.dart';
part 'product_details/product_details_content_page.dart';
part 'product_details/product_details_bottom_sheet_page.dart';
part 'profile/profile_page.dart';
part 'profile/profile_content_page.dart';
part 'promo/promo_page.dart';
part 'ticket/ticket_page.dart';
part 'transaction/transaction_page.dart';
part 'transaction/detail_transaction_page.dart';
part 'transaction/transaction_midtrans_page.dart';
part 'transaction_event/transaction_event_page.dart';
part 'transaction_event/detail_transaction_event_page.dart';
part 'artikel/artikel_page.dart';
part 'artikel/artikel_detail_page.dart';
