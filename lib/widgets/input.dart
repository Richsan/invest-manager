import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _CounterFieldState {
  _CounterFieldState({
    this.rebuild = false,
    required this.value,
  });

  final bool rebuild;
  final BigInt value;
}

class _CounterCubit extends Cubit<_CounterFieldState> {
  _CounterCubit({
    this.initialValue,
    this.stepValue,
    this.allowNegative = true,
    this.allowZero = true,
  }) : super(_CounterFieldState(
          value: initialValue ?? BigInt.zero,
          rebuild: true,
        ));

  final BigInt? initialValue;
  final BigInt? stepValue;
  final bool allowNegative;
  final bool allowZero;

  void increment() => emit(_CounterFieldState(
        value: state.value + (stepValue ?? BigInt.one),
        rebuild: true,
      ));

  void decrement() {
    BigInt newValue = state.value - (stepValue ?? BigInt.one);
    final newValueIsZero = newValue.compareTo(BigInt.zero) == 0;
    final newValueIsNegative = newValue.isNegative;

    if (newValueIsZero && !allowZero) {
      return;
    }

    if (newValueIsNegative && !allowNegative) {
      return;
    }

    emit(_CounterFieldState(
      value: newValue,
      rebuild: true,
    ));
  }

  void setValue(BigInt newValue) {
    final newValueIsZero = newValue.compareTo(BigInt.zero) == 0;
    final newValueIsNegative = newValue.isNegative;

    if (newValueIsZero && !allowZero) {
      emit(_CounterFieldState(value: state.value, rebuild: true));
      return;
    }

    if (newValueIsNegative && !allowNegative) {
      emit(_CounterFieldState(value: state.value, rebuild: true));
      return;
    }
    emit(_CounterFieldState(value: newValue));
  }

  void rebuild() => emit(_CounterFieldState(
        value: state.value,
        rebuild: true,
      ));

  void reset() => emit(
      _CounterFieldState(value: initialValue ?? BigInt.zero, rebuild: true));
}

class _NumberCubit extends Cubit<BigInt?> {
  _NumberCubit() : super(null);

  void change(BigInt? value) => emit(value);
}

class NumberFormField extends StatelessWidget {
  NumberFormField({
    Key? key,
    required this.labelText,
  })  : _numberCubit = _NumberCubit(),
        super(key: key);

  final String labelText;
  final _NumberCubit _numberCubit;
  BigInt? get currentValue => _numberCubit.state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_NumberCubit, BigInt?>(
      bloc: _numberCubit,
      builder: (context, state) => TextFormField(
        onChanged: (value) {
          if (value.isEmpty) {
            _numberCubit.change(null);
          } else {
            _numberCubit.change(BigInt.parse(value));
          }
        },
        initialValue: state?.toString() ?? '',
        decoration: InputDecoration(
          labelText: labelText,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class IntegerCounterField extends StatelessWidget {
  IntegerCounterField({
    super.key,
    this.initialValue,
    this.stepValue,
    this.allowNegative = true,
    this.allowZero = true,
    required this.labelText,
  }) : _counterCubit = _CounterCubit(
          initialValue: initialValue,
          stepValue: stepValue,
          allowNegative: allowNegative,
          allowZero: allowZero,
        );

  final BigInt? initialValue;
  final BigInt? stepValue;
  final bool allowNegative;
  final bool allowZero;
  final _CounterCubit _counterCubit;
  final String labelText;

  BigInt get currentValue => _counterCubit.state.value;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Row(
        children: [
          ElevatedButton(
            onPressed: _counterCubit.decrement,
            style: ElevatedButton.styleFrom(primary: Colors.red),
            child: Text('-'),
          ),
          SizedBox(width: 8),
          BlocBuilder<_CounterCubit, _CounterFieldState>(
            bloc: _counterCubit,
            buildWhen: (previous, current) => current.rebuild,
            builder: (newContext, state) => Expanded(
              child: TextFormField(
                key: UniqueKey(),
                initialValue: state.value.toString(),
                onTapOutside: (event) => _counterCubit.rebuild(),
                onEditingComplete: () => _counterCubit.rebuild(),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _counterCubit.setValue(BigInt.parse(value));
                  } else {
                    _counterCubit.setValue(BigInt.zero);
                    _counterCubit.rebuild();
                  }
                },
                decoration: InputDecoration(
                  labelText: labelText,
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: _counterCubit.increment,
            style: ElevatedButton.styleFrom(primary: Colors.green),
            child: Text('+'),
          ),
        ],
      ),
    );
  }
}
