import 'package:flutter/cupertino.dart';
import 'package:flutter_hishab_khata/di_container.dart';
import 'package:flutter_hishab_khata/src/core/application/navigation_service.dart';
import 'package:flutter_hishab_khata/src/features/home/data/models/customer.dart';
import 'package:flutter_hishab_khata/src/features/home/domain/interface_customer_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ProviderCustomers extends ChangeNotifier{

  final ICustomersRepository customersRepository;
  ProviderCustomers({required this.customersRepository,});

  //states
  Customer _customer = Customer();
  List<Customer> _allCustomers = [];
  List<Customer> _searchedCustomers = [];
  bool _loading = false;
  bool _searching = false;
  int _totalCustomerCount = 0;

  //getters
  Customer get customer => _customer;
  List<Customer> get allCustomers => _allCustomers;
  List<Customer> get searchedCustomers => _searchedCustomers;
  bool get loading => _loading;
  bool get searching => _searching;
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

  set searching(bool flag){
    _searching = flag;
    notifyListeners();
  }

  set totalCustomerCount(int total){
    _totalCustomerCount = total;
    notifyListeners();
  }

  //methods
  void fetchAllCustomers({bool forceFetch = false}) async{
    searching = false;
    if(_allCustomers.isNotEmpty && !forceFetch) return;
    _allCustomers.clear();
    loading = true;
    _allCustomers.addAll(await customersRepository.fetchAllCustomers());
    loading = false;
    notifyListeners();
  }

  void searchCustomers(String keyword) async{
    /*_allCustomers.clear();
    loading = true;
    _allCustomers = await customersRepository.searchCustomers(keyword);
    loading = false;
    notifyListeners();*/

    //local searching
    searching = true;
    _searchedCustomers.clear();
    _searchedCustomers.addAll(_allCustomers.where((element) => (element.name?.toLowerCase().contains(keyword.toLowerCase())??false) || (element.phoneNumber?.toLowerCase().contains(keyword.toLowerCase())??false) || (element.companyName?.toLowerCase().contains(keyword.toLowerCase())??false)));
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
    if(result!=200){
      //means not saved
      Fluttertoast.showToast(msg: "Failed to save this customer!");

    }else{
      //means success
      Fluttertoast.showToast(msg: "Success! Customer info is saved!");
      //update customer list
      fetchAllCustomers(forceFetch: true,);
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

  void showAllCustomers() {
    _searchedCustomers.clear();
    searching = false;
  }



}