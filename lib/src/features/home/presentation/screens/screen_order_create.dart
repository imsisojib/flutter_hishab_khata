import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/button_filled.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/button_stroke.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/common_appbar.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/textbox_cardview.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/texteditform_cardview.dart';
import 'package:flutter_hishab_khata/src/features/home/domain/enums/enum_customers_screen_mode.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/providers/provider_orders.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/screens/screen_customers.dart';
import 'package:flutter_hishab_khata/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenOrderCreate extends StatelessWidget {
  const ScreenOrderCreate({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CommonAppBar(
        tittle: "Create Order",
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
      ),
      body: SafeArea(
        child: Consumer<ProviderOrders>(
          builder: (_, providerOrders, child) {
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(24.h),
                    child: Column(
                      children: [
                        ButtonStroke(
                          height: 35,
                          width: MediaQuery.of(context).size.width,
                          buttonText: "Select Customer",
                          function: () {
                            Navigator.pushNamed(context, Routes.getCustomersScreenRoute(EnumCustomersScreenMode.selection),);
                          },
                        ),
                        SizedBox(height: 8.h,),
                        providerOrders.order.customer==null?const SizedBox():ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          title: Text(
                            providerOrders.order.customer?.phoneNumber??"",
                            style: theme.textTheme.headlineSmall,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                providerOrders.order.customer?.name??"",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.h,),
                              Text(
                                providerOrders.order.customer?.companyName??"",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                providerOrders.order.customer?.address??"",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        TextEditFormCardView(
                          tittleText: "Total Amount",
                          hintText: "Total",
                          inputType: const TextInputType.numberWithOptions(
                            signed: true,
                          ),
                          onChanged: (String value) {
                            var data = providerOrders.order;
                            try {
                              data.total = double.tryParse(value);
                            } catch (e) {
                              data.total = 0;
                            }
                            providerOrders.order = data;
                          },
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextEditFormCardView(
                          tittleText: "Paid Amount",
                          hintText: "Paid",
                          inputType: const TextInputType.numberWithOptions(
                            signed: true,
                          ),
                          onChanged: (String value) {
                            var data = providerOrders.order;
                            try {
                              data.paid = double.tryParse(value);
                            } catch (e) {
                              data.paid = 0;
                            }
                            providerOrders.order = data;
                          },
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextEditFormCardView(
                          tittleText: "Discount Amount",
                          hintText: "Discount",
                          inputType: const TextInputType.numberWithOptions(
                            signed: true,
                          ),
                          onChanged: (String value) {
                            var data = providerOrders.order;
                            try {
                              data.discount = double.tryParse(value);
                            } catch (e) {
                              data.discount = 0;
                            }
                            providerOrders.order = data;
                          },
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextBoxCardView(
                          tittleText: "Total Due",
                          hintText: "Due",
                          initialValue: "${providerOrders.order.due ?? 0}",
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        providerOrders.loading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ButtonFilled(
                                buttonText: "Create Order",
                                function: () {
                                  providerOrders.saveOrder();
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
