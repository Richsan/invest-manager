part of 'bloc.dart';

abstract class SearchScreenEvent extends Equatable {
  const SearchScreenEvent({required this.search});

  final String search;
  @override
  List<Object?> get props => [search];
}

class NewSearchEvent extends SearchScreenEvent {
  const NewSearchEvent({required String search}):
      super(search: search);
}