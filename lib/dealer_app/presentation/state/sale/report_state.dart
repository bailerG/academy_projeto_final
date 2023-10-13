import 'package:flutter/material.dart';

import '../../../entities/dealership.dart';
import '../../../entities/sale.dart';
import '../../../entities/user.dart';
import '../../../usecases/database_controllers/dealerships_table_controller.dart';
import '../../../usecases/database_controllers/sale_table_controller.dart';
import '../../pages/sale/report_screen.dart';

/// State controller of [ReportGenerationScreen] managing the data displayed.
class ReportState with ChangeNotifier {
  /// Constructs an instance of [ReportState] with
  /// the given [loggedUser] parameter.
  ReportState(this.loggedUser) {
    _init();
  }

  void _init() async {
    await getSales();
    await _getDealerships();
  }

  /// The current user logged.
  final User loggedUser;

  final _salesList = <Sale>[];

  /// All instances of [Sale] registered on the selected dealership.
  List<Sale> get salesList => _salesList;

  int? _dealershipController;

  /// Controls what dealership is selected on the screen's dropdown.
  int? get dealershipController => _dealershipController;

  final _dealershipList = <Dealership>[];

  /// All instances of [Dealership] on the database.
  List<Dealership> get dealershipList => _dealershipList;

  final _salesTableController = SaleTableController();
  final _dealershipTableController = DealershipsTableController();

  /// Range of time to filter [salesList].
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2023),
    end: DateTime.now(),
  );

  /// Sets the values of [dateRange].
  void setDateRange(DateTimeRange newDateRange) {
    dateRange = newDateRange;
    notifyListeners();
  }

  /// Gets all instances of [Sale] from the database
  /// within the selected [dateRange].
  ///
  /// If [loggedUser] has an admin role, they are able to
  /// select which instance of [Dealership] they want the sales from.
  Future<void> getSales() async {
    int? dealershipID;

    loggedUser.roleId != 1
        ? dealershipID = loggedUser.dealershipId
        : dealershipID = _dealershipController;

    var result = await _salesTableController.selectByDealership(
      dealershipID ?? 1,
    );

    result
      ..removeWhere(
        (element) => element.isComplete == false,
      )
      ..removeWhere(
        (element) => element.soldWhen.isAfter(dateRange.end),
      )
      ..removeWhere(
        (element) => element.soldWhen.isBefore(dateRange.start),
      );

    _salesList
      ..clear()
      ..addAll(result);

    notifyListeners();
  }

  Future<void> _getDealerships() async {
    final result = await _dealershipTableController.selectAll();

    _dealershipList
      ..clear()
      ..addAll(result)
      ..removeWhere((element) => element.isActive == false);

    notifyListeners();
  }

  /// Callback function that sets a new value to [_dealershipController]
  /// whenever the user selects a different dealership on dropdown.
  void setDealership(Dealership dealership) async {
    _dealershipController = dealership.id!;
    await getSales();

    notifyListeners();
  }
}
