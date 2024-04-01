part of 'bloc.dart';

abstract class LoaderScreenState extends Equatable {
  const LoaderScreenState();

  @override
  List<Object> get props => [];
}

class InitialLoaderScreenState extends LoaderScreenState {
  const InitialLoaderScreenState({
    required this.data,
  }) : super();

  final Future data;

  @override
  List<Object> get props => [data];
}

class LoadingState extends LoaderScreenState {
  const LoadingState() : super();
}

class LoadedState extends LoaderScreenState {
  const LoadedState({
    required this.data,
  }) : super();

  final dynamic data;

  @override
  List<Object> get props => [data];
}
