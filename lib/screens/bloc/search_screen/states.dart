part of 'bloc.dart';

abstract class SearchScreenState extends Equatable {
  const SearchScreenState({required this.search});

  final String search;

  @override
  List<Object> get props => [search];
}

class InitialSearchScreenState extends SearchScreenState {
  const InitialSearchScreenState()
      : super(search: "");
}

class SearchingScreenState extends SearchScreenState {
  const SearchingScreenState({required String search})
      : super(search: search);
}

class SearchedScreenState extends SearchScreenState {
  const SearchedScreenState({
    required String search,
    required this.companies,
  }) : super(search: search);

  final List<Company> companies;
}