import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/components/container/container_body.dart';
import 'package:staynia/components/item/room_list_content.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/base/refresh_indicator_wrapper.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/extension/navigator_extension.dart';
import 'package:staynia/providers/manager/category/manager/category_cubit.dart';
import 'package:staynia/providers/manager/category/manager/category_state.dart';
import 'package:staynia/router/router_path.dart';
import 'package:staynia/screens/home/widgets/home_app_bar.dart';
import 'package:staynia/core/base/base_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreen<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Map<Type, BaseCubit Function()> get cubitFactories => {
    CategoryCubit: () => sl<CategoryCubit>(),
  };
  late final CategoryCubit categoryCubit;

  @override
  void initState() {
    super.initState();
    categoryCubit = getCubit<CategoryCubit>();
    categoryCubit.onInit(arg: 1);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildScreen(context);
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(user: categoryCubit.user),
      body: ContainerBody(
        child: RefreshIndicatorWrapper<CategoryCubit>(
          controller: categoryCubit,
          child: Column(
            children: [
              BlocBuilder<CategoryCubit, CategoryState>(
                bloc: categoryCubit,
                builder: (_, state) {
                  if (state.data != null) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = state.data![index];
                        return RoomListContent(
                          title: item.name ?? '-',
                          category: item,
                          style: index,
                          onClick: () {
                            context.pushTo(RoutePaths.search, arguments: item);
                          },
                        );
                      },
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
