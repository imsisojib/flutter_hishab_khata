import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/common_appbar.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/horizontal_divider.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/providers/provider_orders.dart';
import 'package:flutter_hishab_khata/src/resources/app_colors.dart';
import 'package:flutter_hishab_khata/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenOrders extends StatefulWidget {
  const ScreenOrders({super.key});

  @override
  State<ScreenOrders> createState() => _ScreenOrdersState();
}

class _ScreenOrdersState extends State<ScreenOrders> {

  @override
  void initState() {
    super.initState();
    Provider.of<ProviderOrders>(context,listen: false).fetchAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CommonAppBar(
        tittle: "Orders",
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
        actionWidgets: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.orderCreateScreen,
              );
            },
            icon: Text(
              "New",
              style: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<ProviderOrders>(
          builder: (_, providerOrders, child) {
            if (providerOrders.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (providerOrders.allOrders.isEmpty) {
              return const Center(
                child: Text("No orders found!"),
              );
            }

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 16.h,
                  ),
                ),
                SliverList(
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
                                Text(
                                  "Name: ",
                                  style: theme.textTheme.bodySmall,
                                ),
                                Flexible(
                                  child: Text(
                                    providerOrders.allOrders[index].name ?? "",
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
                                  providerOrders.allOrders[index].phoneNumber ?? "",
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
                                    fontStyle: FontStyle.italic
                                  ),
                                ),
                                Text(
                                  providerOrders.allOrders[index].createdAt ?? "",
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: AppColors.grey500,
                                      fontStyle: FontStyle.italic
                                  ),
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
                                  "${providerOrders.allOrders[index].total ?? 0}",
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
                                  "${providerOrders.allOrders[index].paid ?? 0}",
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
                                  "${providerOrders.allOrders[index].discount ?? 0}",
                                  style: theme.textTheme.titleSmall,
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h,),
                            const HorizontalDivider(),
                            SizedBox(height: 4.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Due",
                                  style: theme.textTheme.bodySmall,
                                ),
                                Text(
                                  "${providerOrders.allOrders[index].due ?? 0}",
                                  style: theme.textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }, childCount: providerOrders.allOrders.length),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: kToolbarHeight,
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
