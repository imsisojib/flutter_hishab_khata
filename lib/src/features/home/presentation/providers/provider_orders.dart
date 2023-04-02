import 'package:flutter/cupertino.dart';
import 'package:flutter_hishab_khata/di_container.dart';
import 'package:flutter_hishab_khata/src/core/application/navigation_service.dart';
import 'package:flutter_hishab_khata/src/features/home/data/models/order.dart';
import 'package:flutter_hishab_khata/src/features/home/domain/interface_orders_repository.dart';
import 'package:flutter_hishab_khata/src/helpers/debugger_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ProviderOrders extends ChangeNotifier{

  final IOrdersRepository ordersRepository;
  ProviderOrders({required this.ordersRepository,}){
    //call to find total customers
    countTotalOrders();
  }

  //states
  Order _order = Order();
  List<Order> _allOrders = [];
  bool _loading = false;
  int _totalOrdersCount = 0;

  //getters
  Order get order => _order;
  List<Order> get allOrders => _allOrders;
  bool get loading => _loading;
  int get totalOrdersCount => _totalOrdersCount;

  //setters
  set order(Order data){
    _order = data;
    try{
      _order.due = _order.total!-_order.paid!-_order.discount!;
    }catch(e){
      Debugger.debug(title: "ProviderOrders.dueCalculation: error", data: e);
    }
    notifyListeners();
  }
  set loading(bool flag){
    _loading = flag;
    notifyListeners();
  }

  set totalOrdersCount(int total){
    _totalOrdersCount = total;
    notifyListeners();
  }

  //methods
  void fetchAllOrders() async{
    _allOrders.clear();
    _allOrders = await ordersRepository.fetchAllOrders();
    notifyListeners();
  }

  void saveOrder() async{
    if(_order.phoneNumber?.length!=11){
      Fluttertoast.showToast(msg: "Invalid customer phone number!");
      return;
    }

    if(_order.total==null || _order.total!<=0){
      Fluttertoast.showToast(msg: "Check input data again!");
      return;
    }

    loading = true;

    //update date
    _order.createdAt = DateFormat('yyyy-MM-dd').format(DateTime.now());
    int? result = await ordersRepository.addOrder(_order);
    if(result==null || result<=-1){
      //means not saved
      Fluttertoast.showToast(msg: "Failed to save order!");

    }else{
      //means success
      Fluttertoast.showToast(msg: "Success! Order is saved!");
      //update customer list
      fetchAllOrders();
      countTotalOrders();

      //pop back to previous page
      Navigator.pop(sl<NavigationService>().navigatorKey.currentContext!);
    }

    loading = false;

  }

  void countTotalOrders() async{
    totalOrdersCount = await ordersRepository.countTotalOrders()??0;
    notifyListeners();
  }



}