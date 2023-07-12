import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/button_filled.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/common_appbar.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/textbox_cardview.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/texteditform_cardview.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/providers/provider_orders.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenOrderUpdate extends StatelessWidget{
  final String? fromHistoryScreen;
  const ScreenOrderUpdate({super.key, this.fromHistoryScreen});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CommonAppBar(
        tittle: "Update Order",
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
                        SizedBox(height: 8.h,),
                        providerOrders.requestUpdateOrder.customer==null?const SizedBox():ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          title: Text(
                            providerOrders.requestUpdateOrder.customer?.phoneNumber??"",
                            style: theme.textTheme.headlineSmall,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                providerOrders.requestUpdateOrder.customer?.name??"",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.h,),
                              Text(
                                providerOrders.requestUpdateOrder.customer?.companyName??"",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                providerOrders.requestUpdateOrder.customer?.address??"",
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
                          initialValue: "${providerOrders.requestUpdateOrder.total??0}",
                          onChanged: (String value) {
                            var data = providerOrders.requestUpdateOrder;
                            try {
                              data.total = double.tryParse(value);
                            } catch (e) {
                              data.total = 0;
                            }
                            providerOrders.requestUpdateOrder = data;
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
                          initialValue: "${providerOrders.requestUpdateOrder.paid??0}",
                          onChanged: (String value) {
                            var data = providerOrders.requestUpdateOrder;
                            try {
                              data.paid = double.tryParse(value);
                            } catch (e) {
                              data.paid = 0;
                            }
                            providerOrders.requestUpdateOrder = data;
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
                          initialValue: "${providerOrders.requestUpdateOrder.discount??0}",
                          onChanged: (String value) {
                            var data = providerOrders.requestUpdateOrder;
                            try {
                              data.discount = double.tryParse(value);
                            } catch (e) {
                              data.discount = 0;
                            }
                            providerOrders.requestUpdateOrder = data;
                          },
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        TextBoxCardView(
                          tittleText: "Total Due",
                          hintText: "Due",
                          initialValue: "${providerOrders.requestUpdateOrder.due ?? 0}",
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        providerOrders.loading
                            ? const Center(
                          child: CircularProgressIndicator(),
                        )
                            : ButtonFilled(
                          buttonText: "Update Order",
                          function: () {
                            providerOrders.updateOrder(fromHistoryScreen: fromHistoryScreen);
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