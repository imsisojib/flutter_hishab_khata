import 'package:flutter_hishab_khata/src/core/data/database/hishab_database.dart';
import 'package:flutter_hishab_khata/src/features/home/data/models/customer.dart';
import 'package:flutter_hishab_khata/src/features/home/domain/interface_customer_repository.dart';
import 'package:flutter_hishab_khata/src/helpers/debugger_helper.dart';

class CustomerRepository implements ICustomersRepository {
  final HishabDatabase db;

  CustomerRepository({required this.db});

  @override
  Future<int?> addCustomer(Customer customer) async {
    int? result;
    result = await db.database?.insert(
      db.customerTable, customer.toJson(),
    ).onError((error, stackTrace){
      Debugger.debug(title: "CustomerRepository.addCustomer: onError", data: error,);
      return -1;
    });
    Debugger.debug(title: "CustomerRepository.addCustomer", data: result,);
    return result;
  }

  @override
  Future<int?> deleteCustomer(String phoneNumber) async{
    int? result = await db.database?.delete(db.customerTable, where: 'phone_number = ?', whereArgs: [phoneNumber]);
    Debugger.debug(title: "CustomerRepository.deleteCustomer", data: result,);
    return result;
  }

  @override
  Future<List<Customer>> fetchAllCustomers() async{
    List<Map<String, Object?>>? mapList = await db.database?.query(db.customerTable);
    Debugger.debug(title: "CustomersRepository.fetchAllCustomers", data: mapList,);

    List<Customer> customersList = [];
    for (Map<String, Object?> item in mapList!) {
      customersList.add(Customer.fromJson(item));
    }
    return customersList;
  }

  @override
  Future<int?> updateCustomer(Customer customer) async{
    int? result = await db.database?.update(db.customerTable, customer.toJson(),
        where: 'phone_number = ?', whereArgs: [customer.phoneNumber]);
    Debugger.debug(title: "CustomerRepository.updateCustomer", data: result,);
    return result;
  }

  @override
  Future<Customer?> findCustomerById(String phoneNumber) async{
    List<Map<String, Object?>>? result = await db.database?.query(
      db.customerTable,
      columns: ['phone_number', 'name', 'address', 'company_name'],
      where: 'phone_number = ?',
      whereArgs: [phoneNumber],
      limit: 1,
    );
    Debugger.debug(title: "CustomerRepository.findCustomerById", data: result,);

    if(result==null || result.isEmpty) return null;

    Customer? customer = Customer.fromJson(result.first);

    return customer;
  }

  @override
  Future<int?> countTotalCustomers() async{
    var result = await db.database?.rawQuery(
      "SELECT COUNT(*) FROM ${db.customerTable}"
    );
    Debugger.debug(title: "CustomerRepository.countTotalCustomers", data: result,);

    return result?.first['COUNT(*)'] as int?;
  }

}