class ConfigApi{
  //static const String baseUrl = "http://ec2-52-91-64-40.compute-1.amazonaws.com:8080";
  static const String baseUrl = "https://hishabkhata-spring-api.onrender.com";

  //account
  static const String userLogin = "/api/auth/signin";

  //customers
  static const String createCustomer = "/api/customers/create";
  static const String allCustomers = "/api/customers/all";
  static const String countCustomers = "/api/customers/count";
  static String searchCustomersByName(String keyword){
    return "/api/customers/search?keyword=$keyword";
  }

  //orders
  static const String createOrder = "/api/orders/create";
  static const String updateOrder = "/api/orders/update";
  static const String allOrders = "/api/orders/all";
  static const String countOrders = "/api/orders/count";
  static String deleteOrder(var id){
    return "/api/orders/delete?orderId=$id";
  }
  static String findOrdersByPhoneNumber(var phoneNumber){
    return "/api/orders/find?phoneNumber=$phoneNumber";
  }
  static String calculateOrdersForPhoneNumber(var phoneNumber){
    return "/api/orders/calculateTotal?phoneNumber=$phoneNumber";
  }

  static String calculateOrdersReport({required String fromDate, required String toDate}){
    return "/api/orders/ordersReport?fromDate=$fromDate&toDate=$toDate";
  }

}