import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_manager/adapters/date.dart';
import 'package:invest_manager/adapters/number.dart';
import 'package:invest_manager/adapters/string.dart';
import 'package:invest_manager/widgets/input_masks.dart';
import 'package:path_provider/path_provider.dart';

class _CounterFieldState {
  _CounterFieldState({
    this.rebuild = false,
    required this.value,
  });

  final bool rebuild;
  final BigInt value;
}

class _PasswordFieldState {
  _PasswordFieldState({
    this.visible = false,
    this.value = '',
  });

  final bool visible;
  final String value;
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
  _NumberCubit({BigInt? initialValue}) : super(initialValue);

  void change(BigInt? value) => emit(value);
}

class _DateTimeCubit extends Cubit<DateTime?> {
  _DateTimeCubit({DateTime? initialValue}) : super(initialValue);

  void change(DateTime? value) => emit(value);
}

class _TextCubit extends Cubit<String> {
  _TextCubit({String initialValue = ""}) : super(initialValue);

  void change(String value) => emit(value);
}

class _PasswordCubit extends Cubit<_PasswordFieldState> {
  _PasswordCubit({
    String initialValue = "",
    bool visible = false,
  }) : super(_PasswordFieldState(
          value: initialValue,
          visible: visible,
        ));

  void change(String value) => emit(_PasswordFieldState(
        visible: state.visible,
        value: value,
      ));

  void toggleVisibility() => emit(_PasswordFieldState(
        value: state.value,
        visible: !state.visible,
      ));
}

class _ContentPickerCubit extends Cubit<String> {
  _ContentPickerCubit({String initialValue = ''}) : super(initialValue);

  void valueChanged(String newValue) => emit(newValue);
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

class TextInputField extends StatelessWidget {
  TextInputField({
    Key? key,
    required this.labelText,
  })  : _textCubit = _TextCubit(),
        super(key: key);

  final String labelText;
  final _TextCubit _textCubit;

  String get currentValue => _textCubit.state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_TextCubit, String>(
      bloc: _textCubit,
      builder: (context, state) => TextFormField(
        onChanged: _textCubit.change,
        initialValue: state.toString(),
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  PasswordField({
    Key? key,
    required this.labelText,
  })  : _passwordCubit = _PasswordCubit(),
        super(key: key);

  final String labelText;
  final _PasswordCubit _passwordCubit;

  String get currentValue => _passwordCubit.state.value;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_PasswordCubit, _PasswordFieldState>(
      bloc: _passwordCubit,
      builder: (context, state) => TextField(
        obscureText: !state.visible,
        onChanged: _passwordCubit.change,
        decoration: InputDecoration(
          hintText: labelText,
          suffixIcon: IconButton(
            icon: Icon(
              state.visible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: _passwordCubit.toggleVisibility,
          ),
        ),
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

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    this.isLoading = false,
    required this.onSubmit,
    required this.text,
  }) : super(key: key);

  final bool isLoading;
  final VoidCallback onSubmit;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onSubmit,
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
      child: isLoading
          ? Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2.0),
              child: const CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 3,
              ),
            )
          : Text(text),
    );
  }
}

class CurrencyFormField extends StatelessWidget {
  CurrencyFormField({
    Key? key,
    required this.labelText,
  })  : _numberCubit = _NumberCubit(initialValue: BigInt.zero),
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
            _numberCubit.change(value.asMoney());
          }
        },
        initialValue: state?.asCurrency() ?? '',
        decoration: InputDecoration(
          labelText: labelText,
        ),
        inputFormatters: [masks['currency']!.formatter],
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  DatePicker({
    Key? key,
    required this.labelText,
    DateTime? initialDate,
    DateTime? minDate,
    DateTime? maxDate,
  })  : initialDate = initialDate ?? DateTime.now(),
        minDate = minDate ?? DateTime(1900),
        maxDate = maxDate ?? DateTime(2101),
        _dateTimeCubit =
            _DateTimeCubit(initialValue: initialDate ?? DateTime.now()),
        super(key: key);

  final _DateTimeCubit _dateTimeCubit;
  final String labelText;
  final DateTime initialDate, minDate, maxDate;

  DateTime? get currentValue => _dateTimeCubit.state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_DateTimeCubit, DateTime?>(
      bloc: _dateTimeCubit,
      builder: (context, state) {
        TextEditingController c = TextEditingController(
          text: state?.toDateStr() ?? DateTime.now().toDateStr(),
        );
        return TextField(
          controller: c,
          decoration: InputDecoration(
            icon: const Icon(Icons.calendar_today), //icon of text field
            labelText: labelText, //label text of field
          ),
          readOnly: true,
          onTap: () async {
            final DateTime? dateChosen = await showDatePicker(
              context: context,
              initialDate: initialDate, //get today's date
              firstDate:
                  minDate, //DateTime.now() - not to allow to choose before today.
              lastDate: maxDate,
            );
            if (dateChosen != null) {
              _dateTimeCubit.change(dateChosen);
            }
          },
        );
      },
    );
  }
}

class DropDownTextField extends StatelessWidget {
  DropDownTextField({
    super.key,
    required this.values,
    required this.label,
  }) : _cubit = _TextCubit(
          initialValue: values.first,
        );

  final List<String> values;
  final String label;
  final _TextCubit _cubit;

  String get currentValue => _cubit.state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_TextCubit, String>(
      bloc: _cubit,
      builder: (context, state) => Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Text("$label :"),
            const SizedBox(
              width: 10,
            ),
            DropdownButton<String>(
              value: state,
              items: values
                  .map((v) => DropdownMenuItem<String>(
                        value: v,
                        child: Text(v),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  _cubit.change(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FilePickerButton extends StatelessWidget {
  FilePickerButton({
    Key? key,
    required this.label,
    this.disabled = false,
    this.onFilePicked,
  })  : _cubit = _ContentPickerCubit(),
        super(key: key);

  final String label;
  final bool disabled;
  final _ContentPickerCubit _cubit;
  final void Function(String)? onFilePicked;

  String get currentValue => _cubit.state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_ContentPickerCubit, String>(
      bloc: _cubit,
      builder: (newContext, state) => Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Column(
          children: [
            OutlinedButton.icon(
                icon: const Icon(Icons.folder),
                onPressed: disabled
                    ? null
                    : () async {
                        String dir = Platform.isAndroid
                            ? '/storage/emulated/0'
                            : (await getApplicationDocumentsDirectory()).path;

                        final filePicker =
                            await FilePicker.platform.pickFiles();

                        String pathChosen = filePicker?.files.single.path ?? '';

                        _cubit.valueChanged(pathChosen);

                        if (pathChosen != '' && onFilePicked != null) {
                          onFilePicked!(pathChosen);
                        }
                      },
                label: Text(label),
                style: disabled
                    ? OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        foregroundColor: Colors.grey.withOpacity(.8),
                      )
                    : OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)))),
            Text(state),
          ],
        ),
      ),
    );
  }
}

class DirectoryPickerButton extends StatelessWidget {
  DirectoryPickerButton({
    Key? key,
    required this.label,
  })  : _cubit = _ContentPickerCubit(),
        super(key: key);

  final String label;
  final _ContentPickerCubit _cubit;

  String get currentValue => _cubit.state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_ContentPickerCubit, String>(
      bloc: _cubit,
      builder: (newContext, state) => Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Column(
          children: [
            OutlinedButton.icon(
                icon: const Icon(Icons.folder),
                onPressed: () async {
                  String dir = Platform.isAndroid
                      ? '/storage/emulated/0'
                      : (await getApplicationDocumentsDirectory()).path;

                  final filePicker =
                      await FilePicker.platform.getDirectoryPath();
                  ;

                  String pathChosen = filePicker ?? '';

                  _cubit.valueChanged(pathChosen);
                },
                label: Text(label),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)))),
            Text(state),
          ],
        ),
      ),
    );
  }
}
