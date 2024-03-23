import 'package:intl/intl.dart';

final DateFormat _onlyDate = DateFormat('dd/MM/yyyy');

extension StrDateFormat on DateTime {
  String toDateStr() => _onlyDate.format(this);
}
