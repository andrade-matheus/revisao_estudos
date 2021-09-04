import 'package:intl/intl.dart';

class DateHelper {
  static DateTime now = DateTime.now();
  static DateTime hoje = DateTime(now.year, now.month, now.day);
  static DateTime amanha = hoje.add(Duration(days: 1));

  static String formatarData(DateTime data) {
    return DateFormat('yyyy-MM-dd').format(data);
  }

  static String botaoDataToString(DateTime data) {
    return DateFormat.MMMMEEEEd('pt_BR').format(data);
  }

  static String formatarParaSql(DateTime data) {
    return DateFormat("yyyy-MM-dd").format(data);
  }

  static bool isLog(DateTime data) {
    if (data.isBefore(hoje)) {
      return true;
    } else if (data.isBefore(amanha)) {
      return false;
    } else {
      return true;
    }
  }
}
