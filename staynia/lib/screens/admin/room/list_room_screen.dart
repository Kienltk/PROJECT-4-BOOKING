import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/components/app_bar/custom_app_bar.dart';
import 'package:staynia/components/button/blur_button.dart';
import 'package:staynia/components/button/on_click_button.dart';
import 'package:staynia/components/container/container_body.dart';
import 'package:staynia/components/title_column_content.dart';
import 'package:staynia/components/widgets/room_card.dart';
import 'package:staynia/core/base/base_screen.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/constants/app_svg.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/extension/navigator_extension.dart';
import 'package:staynia/router/router_path.dart';
import 'package:staynia/screens/admin/room/manager/list_room/list_room_cubit.dart';
import 'package:staynia/screens/admin/room/manager/list_room/list_room_state.dart';
import 'package:staynia/service/loading_service.dart';

class ListRoomScreen extends StatefulWidget {
  const ListRoomScreen({super.key});

  @override
  State<ListRoomScreen> createState() => _ListRoomScreenState();
}

class _ListRoomScreenState extends BaseScreen<ListRoomScreen> {
  @override
  Map<Type, BaseCubit Function()> get cubitFactories => {
    ListRoomCubit: () => sl<ListRoomCubit>(),
  };
  late final ListRoomCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getCubit<ListRoomCubit>();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(shadow: true),
      body: SingleChildScrollView(
        child: ContainerBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleColumnContent(title: "Rooms"),
              BlocBuilder<ListRoomCubit, ListRoomState>(
                bloc: cubit,
                builder: (_, state) {
                  if (state.loading) {
                    return LoadingService.loading();
                  } else if (state.data != null) {
                    return ListView.builder(
                      itemCount: state.data?.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var item = state.data?[index];
                        return OnClickButton(
                          onClick: () {
                            context.pushTo(
                              RoutePaths.updateRoom,
                              arguments: item,
                            );
                          },
                          child: RoomCard(room: item!),
                        );
                      },
                    );
                  } else {
                    return SizedBox.fromSize();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BlurButton(
        onClick: () => context.pushTo(RoutePaths.createRoom),
        icon: AppSvg.add,
        size: 60,
      ),
    );
  }
}
