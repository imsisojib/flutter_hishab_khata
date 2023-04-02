import 'package:flutter_hishab_khata/src/features/home/data/models/customer.dart';

abstract class ICustomersRepository{
  Future<int?> addCustomer(Customer customer);
  Future<int?> deleteCustomer(String phoneNumber);
  Future<int?> updateCustomer(Customer customer);
  Future<List<Customer>> fetchAllCustomers();
  Future<Customer?> findCustomerById(String phoneNumber);
}