import 'package:bahanaki/models/models.dart';
import 'package:bahanaki/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_bahanaflix_event.dart';
part 'category_bahanaflix_state.dart';

class CategoryBahanaflixBloc
    extends Bloc<CategoryBahanaflixEvent, CategoryBahanaflixState> {
  CategoryBahanaflixBloc() : super(CategoryBahanaflixInitial()) {
    on<FetchDataListCategoryBahanaflixEvent>((event, emit) async {
      List<ListCategoryBahanaflixModel> listCategoryBahanaflixModel =
          await ListCategoryServices.getListCategoryBahanaflix();
      emit(ListCategoryLoaded(
          listCategoryBahanaflixModel: listCategoryBahanaflixModel));
    });
  }
}
