import 'dart:developer';

import 'package:bahanaki/bloc/bloc.dart';
import 'package:bahanaki/routes/routes.dart';
import 'package:bahanaki/services/services.dart';
import 'package:bahanaki/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPreferencesUser().getIdUser().then((value) {
      idUser = value;
    });

    if (detectUser) {
      ListEbookServices.baCard('carttotal', idUser, '', status: '')
          .then((value) {
        itemCardProduct = value.cartCheckout!.totalItem;
        log('imte cart$itemCardProduct');
      });
    }

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    versionInfo();

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PagesBloc()),
          BlocProvider(
              create: (_) => CategoryBahanaflixBloc()
                ..add(FetchDataListCategoryBahanaflixEvent())),
          BlocProvider(
              create: (_) =>
                  DataListEbookBloc()..add(FetchDataListEbookEvent())),
          BlocProvider(
              create: (_) => BannerBloc()..add(FetchDataListBannerEvent())),
          BlocProvider(
              create: (_) => CountCartBloc()
                ..add(FetchDataCountCartItemEvent(idUser: idUser))),
          BlocProvider(
              create: (_) =>
                  ItemCartBloc()..add(FetchDataItemCartEvent(idUser: idUser))),
          BlocProvider(create: (_) => AdsBloc()..add(FetchDataListAdsLoaded())),
          BlocProvider(
              create: (_) =>
                  AdssekunderBloc()..add(FetchDataListAdssekunderLoaded()))
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ));
  }
}
