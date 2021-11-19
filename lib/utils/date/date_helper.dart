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

  static bool isSameDay(DateTime primeira, DateTime segunda){
    var primeiraHoje = DateTime(primeira.year, primeira.month, primeira.day);
    var primeiraAmanha = primeiraHoje.add(Duration(days: 1));
    return segunda.isAtSameMomentAs(primeiraHoje) || (segunda.isAfter(primeiraHoje) && segunda.isBefore(primeiraAmanha));
  }
}
