import 'package:flutter/material.dart';

class ReportState with ChangeNotifier {
  ReportState();

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2023),
    end: DateTime.now(),
  );

  void setDateRange(DateTimeRange newDateRange) {
    dateRange = newDateRange;
    notifyListeners();
  }
}
