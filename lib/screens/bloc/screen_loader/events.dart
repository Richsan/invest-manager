part of 'bloc.dart';

abstract class LoaderScreenEvent extends Equatable {
  const LoaderScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadScreenEvent extends LoaderScreenEvent {
  const LoadScreenEvent({
    required this.data,
  }) : super();

  final Future data;

  @override
  List<Object> get props => [data];
}
