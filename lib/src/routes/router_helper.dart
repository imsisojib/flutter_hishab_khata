import 'package:fluro/fluro.dart';
import 'package:flutter_hishab_khata/src/features/errors/presentation/screens/screen_error.dart';
import 'package:flutter_hishab_khata/src/features/home/domain/enums/enum_customers_screen_mode.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/screens/screen_customer_create.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/screens/screen_customer_update.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/screens/screen_customers.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/screens/screen_home.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/screens/screen_order_create.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/screens/screen_order_update.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/screens/screen_orders.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/screens/screen_orders_by_customer.dart';
import 'package:flutter_hishab_khata/src/routes/routes.dart';

class RouterHelper {
  static final FluroRouter router = FluroRouter();

  ///Handlers
  static final Handler _homeScreenHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenHome();
  });

  static final Handler _customersScreenHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
        String? mode;
        try{
          mode = parameters['mode'][0];
        }catch(e){}
    return ScreenCustomers(
      mode: mode == "selection"
          ? EnumCustomersScreenMode.selection
          : EnumCustomersScreenMode.view,
    );
  });
  static final Handler _customersCreateScreenHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenCustomerCreate();
  });
  static final Handler _customersUpdateScreenHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenCustomerUpdate();
  });

  ///ORDERS
  static final Handler _ordersScreenHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenOrders();
  });
  static final Handler _ordersCreateScreenHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenOrderCreate();
  });
  static final Handler _ordersUpdateScreenHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
    return const ScreenOrderUpdate();
  });
  static final Handler _ordersByCustomerScreenHandler =
      Handler(handlerFunc: (context, Map<String, dynamic> parameters) {
        String? phone;
        String? name;
        try{
          phone = parameters['phone'][0];
        }catch(e){}
        try{
          name = parameters['name'][0];
        }catch(e){}
    return ScreenOrdersByCustomer(
      phoneNumber: phone,
      name: name,
    );
  });

  static final Handler _notFoundHandler =
      Handler(handlerFunc: (context, parameters) => const ScreenError());

  void setupRouter() {
    router.notFoundHandler = _notFoundHandler;

    //main-nav flow
    router.define(Routes.homeScreen,
        handler: _homeScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.ordersScreen,
        handler: _ordersScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.orderCreateScreen,
        handler: _ordersCreateScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.orderUpdateScreen,
        handler: _ordersUpdateScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.customersScreen,
        handler: _customersScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.customerCreateScreen,
        handler: _customersCreateScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.customerUpdateScreen,
        handler: _customersUpdateScreenHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.ordersByCustomerScreen,
        handler: _ordersByCustomerScreenHandler, transitionType: TransitionType.fadeIn);
  }
}
