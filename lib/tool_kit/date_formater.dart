import 'package:intl/intl.dart';

abstract class DateFormater {
  static String formater(DateTime time){
   return DateFormat('EEEE, MMM d, y').format(time); // Saturday, Jul 18, 2026
  }
}