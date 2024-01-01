import 'package:intl/intl.dart';

DateTime parseDate(String date) {
  try {
    return DateFormat('dd-MM-yyyy').parse(date);
  } catch (e) {
    return DateTime.now();
  }
}

bool isValidDate(String date) {
  try {
    DateFormat('dd-MM-yyyy').parseStrict(date);
    return true;
  } catch (e) {
    return false;
  }
}
