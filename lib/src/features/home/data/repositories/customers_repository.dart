import 'dart:convert';

import 'package:flutter_hishab_khata/src/config/config_api.dart';
import 'package:flutter_hishab_khata/src/core/application/token_service.dart';
import 'package:flutter_hishab_khata/src/core/data/database/hishab_database.dart';
import 'package:flutter_hishab_khata/src/core/domain/interfaces/interface_api_interceptor.dart';
import 'package:flutter_hishab_khata/src/features/home/data/models/customer.dart';
import 'package:flutter_hishab_khata/src/features/home/domain/interface_customer_repository.dart';
import 'package:flutter_hishab_khata/src/helpers/debugger_helper.dart';

class CustomerRepository implements ICustomersRepository {
  //final HishabDatabase db;
  final IApiInterceptor apiInterceptor;
  final TokenService tokenService;

  CustomerRepository({required this.apiInterceptor, required this.tokenService});

  @override
  Future<int?> addCustomer(Customer customer) async {
    var response = await apiInterceptor.post(
      endPoint: ConfigApi.createCustomer,
      body: jsonEncode(customer.toJson()),
      headers: tokenService.getUnAuthHeadersForJson(),
    );

    Debugger.debug(
      title: "RepositoryCustomers.addCustomer(): response",
      data: response.body,
      statusCode: response.statusCode,
    );

    return response.statusCode;

    /*
    int? result;
    result = await db.database
        ?.insert(
      db.customerTable,
      customer.toJson(),
    )
        .onError((error, stackTrace) {
      Debugger.debug(
        title: "CustomerRepository.addCustomer: onError",
        data: error,
      );
      return -1;
    });
    Debugger.debug(
      title: "CustomerRepository.addCustomer",
      data: result,
    );
    return result;*/
  }

  @override
  Future<int?> deleteCustomer(String phoneNumber) async {
    /*int? result = await db.database
        ?.delete(db.customerTable, where: 'phone_number = ?', whereArgs: [phoneNumber]);
    Debugger.debug(
      title: "CustomerRepository.deleteCustomer",
      data: result,
    );
    return result;*/
  }

  @override
  Future<List<Customer>> fetchAllCustomers() async {
    /*List<Map<String, Object?>>? mapList =
        await db.database?.query(db.customerTable, orderBy: "name ASC");
    Debugger.debug(
      title: "CustomersRepository.fetchAllCustomers",
      data: mapList,
    );

    List<Customer> customersList = [];
    for (Map<String, Object?> item in mapList!) {
      customersList.add(Customer.fromJson(item));
    }
    return customersList;*/
    return [];
  }

  @override
  Future<List<Customer>> searchCustomers(String keyword) async {
    /*List<Map<String, Object?>>? mapList = await db.database?.query(
      db.customerTable,
      orderBy: "name ASC", //DESC
      where: "name LIKE ?",
      whereArgs: ["%$keyword%"],
    );
    Debugger.debug(
      title: "CustomersRepository.searchCustomers",
      data: mapList,
    );

    List<Customer> customersList = [];
    for (Map<String, Object?> item in mapList!) {
      customersList.add(Customer.fromJson(item));
    }
    return customersList;*/

    return [];
  }

  @override
  Future<int?> updateCustomer(Customer customer) async {
    /*int? result = await db.database?.update(db.customerTable, customer.toJson(),
        where: 'phone_number = ?', whereArgs: [customer.phoneNumber]);
    Debugger.debug(
      title: "CustomerRepository.updateCustomer",
      data: result,
    );
    return result;*/

    return null;
  }

  @override
  Future<Customer?> findCustomerById(String phoneNumber) async {
    /*List<Map<String, Object?>>? result = await db.database?.query(
      db.customerTable,
      columns: ['phone_number', 'name', 'address', 'company_name'],
      where: 'phone_number = ?',
      whereArgs: [phoneNumber],
      limit: 1,
    );
    Debugger.debug(
      title: "CustomerRepository.findCustomerById",
      data: result,
    );

    if (result == null || result.isEmpty) return null;

    Customer? customer = Customer.fromJson(result.first);

    return customer;*/

    return null;
  }

  @override
  Future<int?> countTotalCustomers() async {
    /*var result = await db.database?.rawQuery("SELECT COUNT(*) FROM ${db.customerTable}");
    Debugger.debug(
      title: "CustomerRepository.countTotalCustomers",
      data: result,
    );

    return result?.first['COUNT(*)'] as int?;*/

    return 0;
  }
}
