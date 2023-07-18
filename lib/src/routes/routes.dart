import 'package:flutter_hishab_khata/src/features/home/domain/enums/enum_customers_screen_mode.dart';
import 'package:flutter_hishab_khata/src/features/home/domain/enums/enum_order_action.dart';

class Routes {
  static const String homeScreen = "/";

  //login
  static const String loginScreen = "/login";

  static const String customersScreen = "/customers";
  static const String customerCreateScreen = "/customers/create";
  static const String customerUpdateScreen = "/customers/update";
  ///ORDERS
  static const String ordersScreen = "/orders";
  static const String orderCreateScreen = "/orders/create";
  static const String orderUpdateScreen = "/orders/update";
  static const String ordersByCustomerScreen = "/orders-by-customer";
  static const String ordersReportScreen = "/orders-report";

  static String getCustomersScreenRoute(EnumCustomersScreenMode mode){
    return "$customersScreen?mode=${mode.name}";
  }

  static String getOrdersByCustomerScreenRoute(String phoneNumber, String customerName){
    return "$ordersByCustomerScreen?phone=$phoneNumber&name=$customerName";
  }

  static orderCreateFromHistoryScreen(){
    return "$orderCreateScreen?history=1";
  }
  static orderUpdateFromHistoryScreen(){
    return "$orderUpdateScreen?history=1";
  }

}