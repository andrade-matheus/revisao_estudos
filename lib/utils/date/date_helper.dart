import 'package:intl/intl.dart';

class DateHelper {
  static DateTime now () => DateTime.now();
  static DateTime hoje () => DateTime(now().year, now().month, now().day);
  static DateTime amanha () => hoje().add(Duration(days: 1));
  static DateTime ontem () => hoje().subtract(Duration(days: 1));

  static String formatarData(DateTime data) {
    return DateFormat('yyyy-MM-dd').format(data);
  }

  static String botaoDataToString(DateTime data) {
    return DateFormat.MMMMEEEEd('pt_BR').format(data);
  }

  static String formatarParaSql(DateTime data) {
    return DateFormat("yyyy-MM-dd").format(data);
  }

  static String formatarParaArquivo(DateTime data) {
    return DateFormat("yyyy_MM_dd_ss").format(data);
  }

  static String formatarParaCalendario(DateTime data) {
    String diaSemana = toBeginningOfSentenceCase(DateFormat("EEEE",'pt_BR').format(data)) ?? '';
    String dia = DateFormat("d",'pt_BR').format(data);
    String mes = toBeginningOfSentenceCase(DateFormat("MMMM",'pt_BR').format(data)) ?? '';

    return '$diaSemana, $dia de $mes';
  }

  static bool isLog(DateTime data) {
    if (data.isBefore(hoje())) {
      return true;
    } else if (data.isBefore(amanha())) {
      return false;
    } else {
      return false;
    }
  }

  static bool useLogTile(DateTime data) {
    if (data.isBefore(hoje())) {
      return true;
    } else if (data.isBefore(amanha())) {
      return false;
    } else {
      return true;
    }
  }

  static int isToday(DateTime data) {
    if (data.isBefore(hoje())) {
      return -1;
    } else if (data.isBefore(amanha())) {
      return 0;
    } else {
      return 1;
    }
  }

  static bool isSameDay(DateTime primeira, DateTime segunda){
    var primeiraHoje = DateTime(primeira.year, primeira.month, primeira.day);
    var primeiraAmanha = primeiraHoje.add(Duration(days: 1));
    return segunda.isAtSameMomentAs(primeiraHoje) || (segunda.isAfter(primeiraHoje) && segunda.isBefore(primeiraAmanha));
  }

  static DateTime removeHora(DateTime data){
    return DateTime(data.year, data.month, data.day);
  }
}
