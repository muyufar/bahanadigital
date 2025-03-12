import 'package:bahanaki/models/models.dart';
import 'package:bahanaki/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc() : super(BannerInitial()) {
    on<FetchDataListBannerEvent>((event, emit) async {
      List<BannerModel> bannerModel = await BannerService.getBannerBahana();
      emit(ListBannerLoaded(bannerModel: bannerModel));
    });
  }
}
