import 'package:hijri_date/hijri.dart';
import 'package:intl/intl.dart';

String getMDate() {
  // Current Gregorian date
  DateTime now = DateTime.now();
  String gregorianDate = DateFormat('d MMMM yyyy', 'ar').format(now);
  return gregorianDate;
}

String getHDate() {
  // Set the language to Arabic
  HijriDate.setLocal('ar');
  HijriDate hijri = HijriDate.now();
  // Now longMonthName will return names like "رمضان" or "شوال"
  String hijriDate = "${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear}";
  return hijriDate;
}
