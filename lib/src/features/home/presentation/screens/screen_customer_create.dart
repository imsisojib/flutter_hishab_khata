import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/button_filled.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/common_appbar.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/texteditform_cardview.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/providers/provider_customers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenCustomerCreate extends StatelessWidget {
  const ScreenCustomerCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        tittle: "Add Customer",
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
      ),
      body: SafeArea(
        child: Consumer<ProviderCustomers>(
          builder: (_, providerCustomers, child) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(24.h),
                    child: Column(
                      children: [
                        TextEditFormCardView(
                          tittleText: "Phone Number",
                          hintText: "01XXXXXXXXX",
                          inputType: TextInputType.number,
                          onChanged: (String value) {
                            var data = providerCustomers.customer;
                            data.phoneNumber = value;
                            providerCustomers.customer = data;
                          },
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextEditFormCardView(
                          tittleText: "Customer Name",
                          hintText: "Customer Name",
                          onChanged: (String value) {
                            var data = providerCustomers.customer;
                            data.name = value;
                            providerCustomers.customer = data;
                          },
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextEditFormCardView(
                          tittleText: "Company Name",
                          hintText: "Company Name",
                          onChanged: (String value) {
                            var data = providerCustomers.customer;
                            data.companyName = value;
                            providerCustomers.customer = data;
                          },
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextEditFormCardView(
                          tittleText: "Customer Address",
                          hintText: "Customer Address",
                          onChanged: (String value) {
                            var data = providerCustomers.customer;
                            data.address = value;
                            providerCustomers.customer = data;
                          },
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        providerCustomers.loading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ButtonFilled(
                                buttonText: "Add Customer",
                                function: () {
                                  providerCustomers.saveCustomer();
                                },
                              ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
