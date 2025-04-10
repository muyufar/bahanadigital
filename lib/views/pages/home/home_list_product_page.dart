part of '../pages.dart';

class AfterthoughtEbookProductPage extends StatelessWidget {
  const AfterthoughtEbookProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataListEbookBloc, DataListEbookState>(
        builder: (_, dataListEbookModelState) {
      if (dataListEbookModelState is DataListEbookLoaded) {
        List<ListEbookModel> listEbookModel =
            dataListEbookModelState.dataListEbookModel.afterthought;
        if (listEbookModel.isEmpty) {
          return const SizedBox();
        } else {
          return ListCardProductWidget(
              tag: 'hasil_renungan',
              titleCardList: 'Renungan',
              listEbookModel: listEbookModel,
              eBookDigital: true);
        }
      } else {
        //loaded
        return const LoadedListProuctHorizontal();
      }
    });
  }
}

class MagazineProductPage extends StatelessWidget {
  const MagazineProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataListEbookBloc, DataListEbookState>(
        builder: (_, dataListEbookModelState) {
      if (dataListEbookModelState is DataListEbookLoaded) {
        List<ListEbookModel> listEbookModel =
            dataListEbookModelState.dataListEbookModel.magazine;
        if (listEbookModel.isEmpty) {
          return const SizedBox();
        } else {
          return ListCardProductWidget(
              tag: 'hasil_majalah',
              titleCardList: 'Majalah Bahana',
              listEbookModel: listEbookModel,
              eBookDigital: true);
        }
      } else {
        //loaded
        return const LoadedListProuctHorizontal();
      }
    });
  }
}

class HomeListNewEbookProductPage extends StatelessWidget {
  const HomeListNewEbookProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataListEbookBloc, DataListEbookState>(
        builder: (_, dataListEbookModelState) {
      if (dataListEbookModelState is DataListEbookLoaded) {
        List<ListEbookModel> listEbookModel =
            dataListEbookModelState.dataListEbookModel.listNew;
        if (listEbookModel.isEmpty) {
          return const SizedBox();
        } else {
          return ListCardProductWidget(
              tag: 'hasil_terbaru',
              titleCardList: 'Buku Digital Terbaru',
              listEbookModel: listEbookModel,
              eBookDigital: true);
        }
      } else {
        //loaded
        return const LoadedListProuctHorizontal();
      }
    });
  }
}

class HomeListRentEbookProductPage extends StatelessWidget {
  const HomeListRentEbookProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataListEbookBloc, DataListEbookState>(
        builder: (_, dataListEbookModelState) {
      if (dataListEbookModelState is DataListEbookLoaded) {
        List<ListEbookModel> listEbookModel =
            dataListEbookModelState.dataListEbookModel.listRent;
        if (listEbookModel.isEmpty) {
          return const SizedBox();
        } else {
          return ListCardProductWidget(
              tag: 'hasil_sewa',
              titleCardList: 'Buku Digital Sewa',
              listEbookModel: listEbookModel,
              eBookDigital: true);
        }
      } else {
        //loaded
        return const LoadedListProuctHorizontal();
      }
    });
  }
}

class HomeListBuyEbookProductPage extends StatelessWidget {
  const HomeListBuyEbookProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataListEbookBloc, DataListEbookState>(
        builder: (_, dataListEbookModelState) {
      if (dataListEbookModelState is DataListEbookLoaded) {
        List<ListEbookModel> listEbookModel =
            dataListEbookModelState.dataListEbookModel.listBuy;
        if (listEbookModel.isEmpty) {
          return const SizedBox();
        } else {
          return ListCardProductWidget(
              tag: 'hasil_beli',
              titleCardList: 'Buku Digital Beli',
              listEbookModel: listEbookModel,
              eBookDigital: true);
        }
      } else {
        //loaded
        return const LoadedListProuctHorizontal();
      }
    });
  }
}
