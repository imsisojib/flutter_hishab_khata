import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/di_container.dart';
import 'package:flutter_hishab_khata/src/features/home/data/models/order.dart';
import 'package:flutter_hishab_khata/src/features/home/data/requests/request_order.dart';
import 'package:flutter_hishab_khata/src/features/home/domain/interface_orders_repository.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/providers/provider_customers.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/providers/provider_orders.dart';
import 'package:flutter_hishab_khata/src/resources/app_colors.dart';
import 'package:flutter_hishab_khata/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  bool loading = false;
  List<RequestOrder> requestList = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: kToolbarHeight,
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dashboard",
                    style: theme.textTheme.headlineSmall,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.ordersScreen,
                            );
                          },
                          child: Consumer<ProviderOrders>(
                            builder: (_, providerOrders, child) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                margin: EdgeInsets.zero,
                                elevation: 12,
                                shadowColor: AppColors.grey400.withOpacity(.3),
                                child: SizedBox(
                                  height: 180.h,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${providerOrders.totalOrdersCount ?? 0}",
                                        style: theme.textTheme.headlineMedium,
                                      ),
                                      SizedBox(
                                        height: 24.h,
                                      ),
                                      Text(
                                        "Orders",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 24.w,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.customersScreen,
                            );
                          },
                          child: Consumer<ProviderCustomers>(
                            builder: (_, providerCustomers, child) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                margin: EdgeInsets.zero,
                                elevation: 12,
                                shadowColor: AppColors.grey400.withOpacity(.3),
                                child: SizedBox(
                                  height: 180.h,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${providerCustomers.totalCustomerCount}",
                                        style: theme.textTheme.headlineMedium,
                                      ),
                                      SizedBox(
                                        height: 24.h,
                                      ),
                                      Text(
                                        "Customers",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

}
