import 'package:flutter/cupertino.dart';
import 'package:flutter_hishab_khata/di_container.dart';
import 'package:flutter_hishab_khata/src/core/application/navigation_service.dart';
import 'package:flutter_hishab_khata/src/features/home/data/models/order.dart';
import 'package:flutter_hishab_khata/src/features/home/data/requests/request_order.dart';
import 'package:flutter_hishab_khata/src/features/home/data/requests/request_update_order.dart';
import 'package:flutter_hishab_khata/src/features/home/domain/interface_orders_repository.dart';
import 'package:flutter_hishab_khata/src/helpers/debugger_helper.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ProviderOrders extends ChangeNotifier {
  final IOrdersRepository ordersRepository;

  ProviderOrders({
    required this.ordersRepository,
  });

  //states
  OrderModel _order = OrderModel();
  OrderModel _requestUpdateOrder = OrderModel();
  List<OrderModel> _allOrders = [];
  List<OrderModel> _ordersByPhoneNumber = [];
  bool _loading = false;
  int _totalOrdersCount = 0;

  //getters
  OrderModel get order => _order;
  OrderModel get requestUpdateOrder => _requestUpdateOrder;

  List<OrderModel> get allOrders => _allOrders;

  List<OrderModel> get ordersByPhoneNumber => _ordersByPhoneNumber;

  bool get loading => _loading;

  int get totalOrdersCount => _totalOrdersCount;

  //setters
  set order(OrderModel data) {
    _order = data;
    try {
      _order.due = _order.total! - _order.paid! - _order.discount!;
    } catch (e) {
      Debugger.debug(title: "ProviderOrders.dueCalculation: error", data: e);
    }
    notifyListeners();
  }

  set requestUpdateOrder(OrderModel data) {
    _requestUpdateOrder = data;
    try {
      _requestUpdateOrder.due = _requestUpdateOrder.total! - _requestUpdateOrder.paid! - _requestUpdateOrder.discount!;
    } catch (e) {
      Debugger.debug(title: "ProviderOrders.dueCalculation->updateOrder: error", data: e);
    }
    notifyListeners();
  }

  set loading(bool flag) {
    _loading = flag;
    notifyListeners();
  }

  set totalOrdersCount(int total) {
    _totalOrdersCount = total;
    notifyListeners();
  }

  //methods
  void fetchAllOrders() async {
    _allOrders.clear();
    loading = true;
    _allOrders.addAll(await ordersRepository.fetchAllOrders());
    loading = false;
    notifyListeners();
  }

  void fetchAllOrdersByPhoneNumber(String? phoneNumber) async {
    loading = true;
    _ordersByPhoneNumber.clear();
    if(phoneNumber==null){
      loading = false;
      return;
    }

    _ordersByPhoneNumber = await ordersRepository.fetchAllOrdersByPhoneNumber(phoneNumber);
    loading = false;
    notifyListeners();
  }

  void saveOrder({String? fromHistoryScreen}) async {
    if (_order.customer?.phoneNumber?.length != 11) {
      Fluttertoast.showToast(msg: "Invalid customer phone number!");
      return;
    }

    if (_order.total == null || _order.total! <= 0) {
      Fluttertoast.showToast(msg: "Check input data again!");
      return;
    }

    loading = true;

    //update date
    _order.createdAt = DateFormat('yyyy-MM-dd').format(DateTime.now());
    int? result = await ordersRepository.addOrder(RequestOrder(
      phoneNumber: _order.customer?.phoneNumber,
      total: _order.total,
      paid: _order.paid,
      due: _order.due,
      discount: _order.discount??0,
      createdAt: _order.createdAt,
    ));
    if (result == null || result <= -1) {
      //means not saved
      Fluttertoast.showToast(msg: "Failed to save order!");
    } else {
      //means success
      Fluttertoast.showToast(msg: "Success! Order is saved!");
      //update customer list
      fetchAllOrders();
      countTotalOrders();
      if(fromHistoryScreen=="1"){
        fetchAllOrdersByPhoneNumber(_order.customer?.phoneNumber);
      }

      //pop back to previous page
      Navigator.pop(sl<NavigationService>().navigatorKey.currentContext!);
      sendSmsToCustomer(order);

      _order = OrderModel();
    }

    loading = false;
  }

  void updateOrder({String? fromHistoryScreen}) async {
    if (_requestUpdateOrder.customer?.phoneNumber?.length != 11) {
      Fluttertoast.showToast(msg: "Invalid customer phone number!");
      return;
    }

    if (_requestUpdateOrder.total == null || _requestUpdateOrder.total! <= 0) {
      Fluttertoast.showToast(msg: "Check input data again!");
      return;
    }

    loading = true;

    int? result = await ordersRepository.updateOrder(RequestUpdateOrder(
      id: _requestUpdateOrder.id,
      total: _requestUpdateOrder.total,
      paid: _requestUpdateOrder.paid,
      due: _requestUpdateOrder.due,
      discount: _requestUpdateOrder.discount,
    ));
    if (result!=200) {
      //means not saved
      Fluttertoast.showToast(msg: "Failed to save order!");
    } else {
      //means success
      Fluttertoast.showToast(msg: "Success! Order is updated!");
      //update customer list
      fetchAllOrders();
      fetchAllOrdersByPhoneNumber(_order.customer?.phoneNumber);
      /*if(fromHistoryScreen=="1"){
        fetchAllOrdersByPhoneNumber(_order.customer?.phoneNumber);
      }*/

      //pop back to previous page
      Navigator.pop(sl<NavigationService>().navigatorKey.currentContext!);

      _requestUpdateOrder = OrderModel();
    }

    loading = false;
  }

  void countTotalOrders() async {
    totalOrdersCount = await ordersRepository.countTotalOrders() ?? 0;
    notifyListeners();
  }

  void sendSmsToCustomer(OrderModel order) async {
    String message = "MI Enterprise"
        "\nDate: ${order.createdAt}"
        "\nOrder by: ${order.customer?.phoneNumber}"
        "\nTotal Amount: ${order.total}"
        "\nPaid: ${order.paid ?? 0}"
        "\nDiscount: ${order.discount ?? 0}"
        "\nDue: ${order.due??0}";

    List<String> recipients = [
      "+88${order.customer?.phoneNumber}",
    ];

    String result = await sendSMS(
      message: message,
      recipients: recipients,
    ).catchError(
      (error) async{
        Debugger.debug(
          title: "SendingSMS: result",
          data: error,
        );
        return error;
      },
    );
    Debugger.debug(
      title: "SendingSMS: result",
      data: result,
    );
  }

  void deleteOrder(int? id) async{
    if(id==null) return;

    int? responseCode = await ordersRepository.deleteOrder(id);
    if(responseCode==200){
      Fluttertoast.showToast(msg: "Order is deleted.");
      fetchAllOrders();
      countTotalOrders();
    }else{
      Fluttertoast.showToast(msg: "Failed to delete order!");
    }


  }

  Future<OrderModel?> fetchTotalOrdersInfoByPhoneNumber(String? phoneNumber) async{
    return await ordersRepository.totalOrdersInfoByPhoneNumber(phoneNumber??"");
  }

  void deleteOrderAndFetchAllOrdersByPhoneNumber(int? id, String? phoneNumber) async{
    if(phoneNumber==null || id==null){
      Fluttertoast.showToast(msg: "Try again later!");
      return;
    }

    await ordersRepository.deleteOrder(id);
    fetchAllOrdersByPhoneNumber(phoneNumber);
    countTotalOrders();
  }
}
