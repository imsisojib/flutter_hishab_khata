import 'package:flutter/cupertino.dart';
import 'package:flutter_hishab_khata/di_container.dart';
import 'package:flutter_hishab_khata/src/core/application/navigation_service.dart';
import 'package:flutter_hishab_khata/src/features/home/data/models/customer.dart';
import 'package:flutter_hishab_khata/src/features/home/domain/interface_customer_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ProviderCustomers extends ChangeNotifier{

  final ICustomersRepository customersRepository;
  ProviderCustomers({required this.customersRepository,}){
    //call to find total customers
    countTotalCustomers();
  }

  //states
  Customer _customer = Customer();
  List<Customer> _allCustomers = [];
  bool _loading = false;
  int _totalCustomerCount = 0;

  //getters
  Customer get customer => _customer;
  List<Customer> get allCustomers => _allCustomers;
  bool get loading => _loading;
  int get totalCustomerCount => _totalCustomerCount;

  //setters
  set customer(Customer data){
    _customer = data;
    notifyListeners();
  }
  set loading(bool flag){
    _loading = flag;
    notifyListeners();
  }

  set totalCustomerCount(int total){
    _totalCustomerCount = total;
    notifyListeners();
  }

  //methods
  void fetchAllCustomers() async{
    _allCustomers.clear();
    _allCustomers = await customersRepository.fetchAllCustomers();
    notifyListeners();
  }

  void saveCustomer() async{
    if(_customer.phoneNumber?.length!=11){
      Fluttertoast.showToast(msg: "Invalid Phone Number!");
      return;
    }
    loading = true;
    Customer? findCustomer = await customersRepository.findCustomerById(_customer.phoneNumber!);
    if(findCustomer!=null){
      //return customer already exists
      Fluttertoast.showToast(msg: "Customer already exists with this phone number!");
      loading = false;
      return;
    }
    //update date
    _customer.createdAt = DateFormat('yyyy-MM-dd').format(DateTime.now());
    int? result = await customersRepository.addCustomer(_customer);
    if(result==null || result<=-1){
      //means not saved
      Fluttertoast.showToast(msg: "Failed to save this customer!");

    }else{
      //means success
      Fluttertoast.showToast(msg: "Success! Customer info is saved!");
      //update customer list
      fetchAllCustomers();
      countTotalCustomers();
      //clear cache
      _customer = Customer();

      //pop back to previous page
      Navigator.pop(sl<NavigationService>().navigatorKey.currentContext!);
    }

    loading = false;

  }

  void countTotalCustomers() async{
    totalCustomerCount = await customersRepository.countTotalCustomers()??0;
    notifyListeners();
  }



}