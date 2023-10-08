import 'package:flutter/material.dart';

import '../../../entities/dealership.dart';
import '../../../entities/sale.dart';
import '../../../entities/user.dart';
import '../../../repository/database.dart';

class SalesListState with ChangeNotifier {
  SalesListState(this.loggedUser) {
    init();
  }

  void init() async {
    await getDealerships();
    await getSales();
  }

  final User loggedUser;

  final _salesList = <Sale>[];
  List<Sale> get salesList => _salesList;

  final _salesTableController = SaleTableController();

  int? _dealershipController;
  int? get dealershipController => _dealershipController;

  final _dealershipList = <Dealership>[];
  List<Dealership> get dealershipList => _dealershipList;

  final _dealershipTableController = DealershipsTableController();

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2023),
    end: DateTime.now(),
  );

  void setDateRange(DateTimeRange newDateRange) async {
    dateRange = newDateRange;

    await getSales();

    notifyListeners();
  }

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
        (element) => element.soldWhen.isAfter(dateRange.end),
      )
      ..removeWhere(
        (element) => element.soldWhen.isBefore(dateRange.start),
      )
      ..sort(
        (a, b) => b.isComplete.toString().compareTo(a.isComplete.toString()),
      );

    _salesList
      ..clear()
      ..addAll(result);

    notifyListeners();
  }

  Future<void> getDealerships() async {
    final result = await _dealershipTableController.selectAll();

    _dealershipList
      ..clear()
      ..addAll(result)
      ..removeWhere((element) => element.isActive == false);

    notifyListeners();
  }

  void setDealership(Dealership dealership) async {
    _dealershipController = dealership.id!;
    await getSales();

    notifyListeners();
  }

  Future<void> setUncomplete(Sale sale) async {
    final saleUncomplete = Sale(
      id: sale.id,
      customerCpf: sale.customerCpf,
      customerName: sale.customerName,
      soldWhen: sale.soldWhen,
      priceSold: sale.priceSold,
      dealershipPercentage: sale.dealershipPercentage,
      headquartersPercentage: sale.headquartersPercentage,
      safetyPercentage: sale.safetyPercentage,
      vehicleId: sale.vehicleId,
      dealershipId: sale.dealershipId,
      userId: sale.userId,
      isComplete: false,
    );

    await _salesTableController.update(saleUncomplete);

    await getSales();

    notifyListeners();
  }
}
