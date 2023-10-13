import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:invest_manager/components/b3.dart';

import '../../../models/b3.dart';

part 'events.dart';
part 'states.dart';

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  SearchScreenBloc() : super(const InitialSearchScreenState()) {
    on<NewSearchEvent>((event, emit) async {
      emit(SearchingScreenState(search: event.search));

      final companiesSearch = await searchListedCompanies(event.search);

      emit(SearchedScreenState(search: event.search, companies: companiesSearch));
    });
  }
}