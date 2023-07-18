import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/basic_textbox.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/button_filled.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/common_appbar.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/horizontal_divider.dart';
import 'package:flutter_hishab_khata/src/features/home/data/models/customer.dart';
import 'package:flutter_hishab_khata/src/features/home/data/models/order.dart';
import 'package:flutter_hishab_khata/src/features/home/data/requests/request_orders_report.dart';
import 'package:flutter_hishab_khata/src/features/home/domain/enums/enum_order_action.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/providers/provider_orders.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/widgets/common_popup_menu_widget.dart';
import 'package:flutter_hishab_khata/src/helpers/widget_helper.dart';
import 'package:flutter_hishab_khata/src/resources/app_colors.dart';
import 'package:flutter_hishab_khata/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenOrdersReport extends StatefulWidget {
  const ScreenOrdersReport({
    super.key,
  });

  @override
  State<ScreenOrdersReport> createState() => _ScreenOrdersReportState();
}

class _ScreenOrdersReportState extends State<ScreenOrdersReport> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProviderOrders>(context, listen: false).clearOrdersReport();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CommonAppBar(
        tittle: "Orders Report",
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
      ),
      body: SafeArea(
        child: Consumer<ProviderOrders>(
          builder: (_, providerOrders, child) {

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: InkWell(
                              onTap: () async{
                                var pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020, 1),
                                  lastDate: DateTime(DateTime.now().year+2,1),
                                );

                                if(pickedDate!=null){
                                  var data = providerOrders.requestOrdersReport??RequestOrdersReport();
                                  data.fromDate = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                                  providerOrders.requestOrdersReport = data;
                                }

                              },
                              child: BasicTextBox(
                                tittleText: "From Date",
                                text: providerOrders.requestOrdersReport?.fromDate??"yyyy-mm-dd",
                              ),
                            )),
                            SizedBox(
                              width: 24.w,
                            ),
                            Expanded(
                                child: InkWell(
                                  onTap: () async{
                                    var pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020, 1),
                                      lastDate: DateTime(DateTime.now().year+2,1),
                                    );

                                    if(pickedDate!=null){
                                      var data = providerOrders.requestOrdersReport??RequestOrdersReport();
                                      data.toDate = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                                      providerOrders.requestOrdersReport = data;
                                    }
                                  },
                                  child: BasicTextBox(
                              tittleText: "To Date",
                              text: providerOrders.requestOrdersReport?.toDate??"yyyy-mm-dd",
                            ),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        providerOrders.loading? const Center(child: CircularProgressIndicator(),): ButtonFilled(
                          buttonText: "View Report",
                          function: () {
                            providerOrders.viewOrdersReport();
                          },
                        )
                      ],
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: providerOrders.responseOrdersReport==null? const SizedBox(): Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey400,),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Calculation",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                  Text(
                                    "Count (${providerOrders.responseOrdersReport?.ordersCount??0})",
                                    style: theme.textTheme.titleSmall,
                                  )
                                ],
                              ),
                              SizedBox(height: 8.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Amount",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  Text(
                                    "${providerOrders.responseOrdersReport?.total ?? 0}",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Paid",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  Text(
                                    "${providerOrders.responseOrdersReport?.paid ?? 0}",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Discount",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  Text(
                                    "${providerOrders.responseOrdersReport?.discount ?? 0}",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              const HorizontalDivider(),
                              SizedBox(
                                height: 4.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Due",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  Text(
                                    "${providerOrders.responseOrdersReport?.due ?? 0}",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        HorizontalDivider(height: 2,),
                        SizedBox(height: 2.h,),
                        HorizontalDivider(height: 2,),
                        SizedBox(height: 8.h,),
                      ],
                    ),
                  ),

                  providerOrders.responseOrdersReport?.data==null?const SliverToBoxAdapter(): SliverList(
                    delegate: SliverChildBuilderDelegate((_, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        elevation: 12,
                        shadowColor: AppColors.grey400.withOpacity(.3),
                        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Name: ",
                                              style: theme.textTheme.bodySmall,
                                            ),
                                            Flexible(
                                              child: Text(
                                                providerOrders.responseOrdersReport?.data?[index].customer?.name ?? "",
                                                style: theme.textTheme.titleSmall,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Phone Number: ",
                                              style: theme.textTheme.bodySmall,
                                            ),
                                            Text(
                                              providerOrders.responseOrdersReport?.data?[index].customer?.phoneNumber ?? "",
                                              style: theme.textTheme.titleSmall,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Ordered On: ",
                                              style: theme.textTheme.bodySmall?.copyWith(
                                                  color: AppColors.grey500,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            Text(
                                              providerOrders.responseOrdersReport?.data?[index].createdAt ?? "",
                                              style: theme.textTheme.bodySmall?.copyWith(
                                                  color: AppColors.grey500,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuButton<EnumOrderAction>(
                                    constraints: const BoxConstraints(),
                                    padding: EdgeInsets.zero,
                                    iconSize: 18,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.h)),
                                    onSelected: (EnumOrderAction action) async {
                                      switch (action) {
                                        case EnumOrderAction.update:
                                          {
                                            providerOrders.requestUpdateOrder = providerOrders.ordersByPhoneNumber[index];
                                            Navigator.pushNamed(context, Routes.orderUpdateFromHistoryScreen());
                                            return;
                                          }
                                        case EnumOrderAction.delete:
                                          {
                                            WidgetHelper.showDialogForConfirmation(
                                              title: "Confirmation",
                                              description: "Do you want to delete this order?",
                                              onPositiveAction: (){
                                                //confirm delete
                                                providerOrders.deleteOrder(providerOrders.responseOrdersReport?.data?[index].id);
                                                providerOrders.viewOrdersReport();
                                              }
                                            );
                                            return;
                                          }
                                        default:
                                      }
                                    },
                                    itemBuilder: (_) => <PopupMenuEntry<EnumOrderAction>>[
                                      const PopupMenuItem<EnumOrderAction>(
                                        value: EnumOrderAction.update,
                                        child: CommonPopupMenuWidget(
                                          iconData: Icons.edit,
                                          name: "Update Order",
                                        ),
                                      ),
                                      const PopupMenuItem<EnumOrderAction>(
                                        value: EnumOrderAction.delete,
                                        child: CommonPopupMenuWidget(
                                          iconData: Icons.delete_rounded,
                                          name: "Delete Order",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Amount",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  Text(
                                    "${providerOrders.responseOrdersReport?.data?[index].total ?? 0}",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Paid",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  Text(
                                    "${providerOrders.responseOrdersReport?.data?[index].paid ?? 0}",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Discount",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  Text(
                                    "${providerOrders.responseOrdersReport?.data?[index].discount ?? 0}",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              const HorizontalDivider(),
                              SizedBox(
                                height: 4.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Due",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  Text(
                                    "${providerOrders.responseOrdersReport?.data?[index].due ?? 0}",
                                    style: theme.textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }, childCount: providerOrders.responseOrdersReport?.data?.length),
                  ),

                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: kToolbarHeight,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
