import 'package:flutter/material.dart';
import 'package:staynia/components/container/container_body.dart';
import 'package:staynia/components/title_column_content.dart';
import 'package:staynia/core/base/base_screen.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/screens/admin/dashboard/manager/dashboard_cubit.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends BaseScreen<DashboardScreen> {
  @override
  Map<Type, BaseCubit Function()> get cubitFactories => {
    DashboardCubit: () => sl<DashboardCubit>(),
  };
  late final DashboardCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getCubit<DashboardCubit>();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: ContainerBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Box.s60,
            TitleColumnContent(title: "Dashboard"),
          ],
        ),
      ),
    );
  }
}
