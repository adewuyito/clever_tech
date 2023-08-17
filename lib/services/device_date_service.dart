import 'package:intl/intl.dart';

class DateDay{
  DateTime now = DateTime.now();

  String getDate(){
    final String date;
    date = DateFormat('d MMM').format(now);
    return date;
  }

  String getDay(){
    final String day;
    day = DateFormat('EEEE').format(now);
    return day;
  }
}