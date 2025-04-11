import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:voltify/core/database/cache_helper.dart';
import 'package:voltify/features/Authentication/presentation/views/login_view.dart';
import 'package:voltify/features/Home/presentation/cubit/balance_cubit.dart';
import 'package:voltify/features/Home/presentation/widgets/circle_percent_widget.dart';
import 'package:voltify/features/Home/presentation/widgets/consumption_card.dart';
import 'package:voltify/features/Home/presentation/widgets/recharge_button.dart';
import 'package:voltify/features/const_themes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static String routeName = 'homeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String lastUpdate = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<BalanceCubit>().loadBalance();
    });
  }

  Future<void> _refreshData() async {
    await context.read<BalanceCubit>().loadBalance();
    setState(() {
      lastUpdate = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kPrimaryColor,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: AppTheme.kSecondaryColor,
        strokeWidth: 2.5,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: ScreenSize.width,
                  height: ScreenSize.height / 5,
                  decoration: BoxDecoration(
                    color: AppTheme.kThirdColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(ScreenSize.width / 20),
                      bottomRight: Radius.circular(ScreenSize.width / 20),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: ScreenSize.height / 20),
                      Text(
                        "Voltify",
                        style: TextStyle(
                          color: AppTheme.kSecondaryColor,
                          fontSize: ScreenSize.width / 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: ScreenSize.height / 50),
                      Row(
                        children: [
                          SizedBox(width: ScreenSize.width / 30),
                          Text(
                            "Welcome ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenSize.width / 25,
                            ),
                          ),
                          SizedBox(
                            width: ScreenSize.width / 3,
                            child: Text(
                              "${CacheHelper.getData(key: 'name')} !",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenSize.width / 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushReplacementNamed(
                                  context, LoginView.routeName);
                            },
                            icon: Icon(
                              Icons.logout,
                              color: AppTheme.kSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: ScreenSize.height / 4.5 - 10,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ScreenSize.width / 20),
                    topRight: Radius.circular(ScreenSize.width / 20),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    CirclePercentWidget(),
                    SizedBox(height: ScreenSize.height / 20),
                    Row(
                      children: [
                        SizedBox(width: ScreenSize.width / 30),
                        Text(
                          "Your Plan",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenSize.width / 20,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '''                                 Last Update:
                           $lastUpdate''',
                          style: TextStyle(
                            fontSize: ScreenSize.width / 30,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: ScreenSize.width / 30),
                      ],
                    ),
                    Expanded(
                      child: BlocBuilder<BalanceCubit, BalanceState>(
                        builder: (context, state) {
                          if (state is BalanceUpdated) {
                            return ListView(
                              children: [
                                ConsumptionCard(
                                  title: "Balance",
                                  data: "${state.balance.toStringAsFixed(2)} EGP",
                                  icon: Icons.attach_money,
                                ),
                                ConsumptionCard(
                                  title: "Electricity",
                                  data: "${state.electricityConsumption.toStringAsFixed(2)} KWh",
                                  icon: Icons.lightbulb_outline,
                                ),
                                ConsumptionCard(
                                  title: "Renewal Date",
                                  data: "${state.renewalDate}",
                                  icon: Icons.date_range,
                                ),
                              ],
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
             RechargeButton(),
          ],
        ),
      ),
      // floatingActionButton: RechargeButton(),
    );
  }
}