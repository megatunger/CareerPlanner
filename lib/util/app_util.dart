import 'package:intl/intl.dart';

class AppUtil {
  String toDateString(String time) {
    DateTime _tmp = DateTime.parse(time).toLocal();
    var newFormat = DateFormat("HH:MM dd/MM/yyyy");
    String updatedDt = newFormat.format(_tmp);
    return updatedDt;
  }
}
