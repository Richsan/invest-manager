import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'events.dart';
part 'states.dart';

class LoaderScreenBloc extends Bloc<LoaderScreenEvent, LoaderScreenState> {
  LoaderScreenBloc({
    required Future data,
  }) : super(InitialLoaderScreenState(data: data)) {
    on<LoadScreenEvent>((event, emit) async {
      emit(const LoadingState());

      final dataResolved = await event.data;

      emit(LoadedState(data: dataResolved));
    });
  }
}
