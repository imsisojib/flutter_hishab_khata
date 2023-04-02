import 'package:flutter/material.dart';
import 'package:flutter_hishab_khata/src/core/presentation/widgets/common_appbar.dart';
import 'package:flutter_hishab_khata/src/features/home/presentation/providers/provider_customers.dart';
import 'package:flutter_hishab_khata/src/resources/app_colors.dart';
import 'package:flutter_hishab_khata/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenCustomers extends StatefulWidget{
  const ScreenCustomers({super.key});

  @override
  State<ScreenCustomers> createState() => _ScreenCustomersState();
}

class _ScreenCustomersState extends State<ScreenCustomers> {

  @override
  void initState() {
    super.initState();

    Provider.of<ProviderCustomers>(context,listen: false).fetchAllCustomers();

  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CommonAppBar(
        tittle: "Customers",
        preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
        actionWidgets: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.customerCreateScreen,);
            },
            icon: Text(
              "Add New",
              style: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<ProviderCustomers>(
          builder: (_, providerCustomers, child){
            if(providerCustomers.loading){
              return const Center(child: CircularProgressIndicator(),);
            }

            if(providerCustomers.allCustomers.isEmpty){
              return const Center(child: Text("No customers found!"),);
            }

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(height: 16.h,),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((_, index){
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      title: Text(
                          providerCustomers.allCustomers[index].phoneNumber??"",
                        style: theme.textTheme.headlineSmall,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            providerCustomers.allCustomers[index].name??"",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h,),
                          Text(
                            providerCustomers.allCustomers[index].companyName??"",
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            providerCustomers.allCustomers[index].address??"",
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      trailing: Column(
                        children: [
                          Text(
                            "Created on",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.grey600,
                            ),
                          ),
                          Text(
                            providerCustomers.allCustomers[index].createdAt??"N/A",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.grey600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                    childCount: providerCustomers.allCustomers.length
                  ),
                ),
              ],
            );

          },
        ),
      ),
    );
  }
}