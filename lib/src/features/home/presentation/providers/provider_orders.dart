import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hishab_khata/di_container.dart';
import 'package:flutter_hishab_khata/src/core/application/navigation_service.dart';
import 'package:flutter_hishab_khata/src/features/home/data/models/order.dart';
import 'package:flutter_hishab_khata/src/features/home/data/requests/request_order.dart';
import 'package:flutter_hishab_khata/src/features/home/domain/interface_orders_repository.dart';
import 'package:flutter_hishab_khata/src/helpers/debugger_helper.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ProviderOrders extends ChangeNotifier {
  final IOrdersRepository ordersRepository;

  ProviderOrders({
    required this.ordersRepository,
  }) {
    //call to find total customers
    countTotalOrders();
  }

  //states
  OrderModel _order = OrderModel();
  List<OrderModel> _allOrders = [];
  bool _loading = false;
  int _totalOrdersCount = 0;

  //getters
  OrderModel get order => _order;

  List<OrderModel> get allOrders => _allOrders;

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
    _allOrders.addAll(await ordersRepository.fetchAllOrders());
    notifyListeners();
  }

  void fetchAllOrdersByPhoneNumber(String? phoneNumber) async {
    loading = true;
    _allOrders.clear();
    if(phoneNumber==null){
      loading = false;
      return;
    }

    _allOrders = await ordersRepository.fetchAllOrdersByPhoneNumber(phoneNumber);
    loading = false;
    notifyListeners();
  }

  void saveOrder() async {
    if (_order.phoneNumber?.length != 11) {
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
      phoneNumber: _order.phoneNumber,
      total: _order.total,
      paid: _order.paid,
      due: _order.due,
      discount: _order.discount,
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

      //pop back to previous page
      Navigator.pop(sl<NavigationService>().navigatorKey.currentContext!);
      sendSmsToCustomer(order);

      _order = OrderModel();
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
        "\nOrder by: ${order.phoneNumber}"
        "\nTotal Amount: ${order.total}"
        "\nPaid: ${order.paid ?? 0}"
        "\nDiscount: ${order.discount ?? 0}"
        "\nDue: ${order.due??0}";

    List<String> recipients = [
      "+88${order.phoneNumber}",
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

    await ordersRepository.deleteOrder(id);
    fetchAllOrders();
    countTotalOrders();

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

  Future<bool> backupOrders() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var ordersReference = firebaseFirestore.collection("Orders");
    //var ordersList = await ordersRepository.fetchAllOrders();
    /*for(var order in ordersList){
      await ordersReference.doc("${order.id}").set(order.toJson(), SetOptions(merge: true)).onError((error, stackTrace) {
        print("----error: $error");
      });
    }*/

    int count = 0;
    ordersReference.get().then((querySnapshot){
      print("--------size: ${querySnapshot.size}");
      for(DocumentSnapshot ds in querySnapshot.docs){
        count++;
        OrderModel order = OrderModel.fromJson(ds.data() as Map<String, dynamic>);
        print("--------count: $count");
        sl<IOrdersRepository>().addOrder(RequestOrder(
          phoneNumber: order.phoneNumber,
          total: order.total,
          paid: order.paid,
          due: order.due,
          discount: order.discount,
          createdAt: order.createdAt,
        ));
      }
    });

    return true;
  }
}
