import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/components/app_bar/custom_app_bar.dart';
import 'package:staynia/components/button/on_click_button.dart';
import 'package:staynia/components/container/container_body.dart';
import 'package:staynia/components/input/custom_input.dart';
import 'package:staynia/components/title_column_content.dart';
import 'package:staynia/components/widgets/room_card.dart';
import 'package:staynia/core/base/base_screen.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/constants/app_svg.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/data/entity/enum/screen_type.dart';
import 'package:staynia/data/entity/model/category.dart';
import 'package:staynia/extension/navigator_extension.dart';
import 'package:staynia/router/router_path.dart';
import 'package:staynia/screens/home/manager/room_cubit.dart';
import 'package:staynia/screens/home/manager/room_state.dart';
import 'package:staynia/service/loading_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.categrory});
  final Category? categrory;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends BaseScreen<SearchScreen> {
  @override
  Map<Type, BaseCubit Function()> get cubitFactories => {
    RoomCubit: () => sl<RoomCubit>(),
  };
  late final RoomCubit roomCubit;

  @override
  void initState() {
    super.initState();
    roomCubit = getCubit<RoomCubit>();
    roomCubit.onInit(
      arg: {
        "ScreenType": ScreenType.searchScreen,
        "categoryId": widget.categrory?.id,
      },
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.categrory == null ? "Search" : null),
      body: ContainerBody(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Box.s6,
              if (widget.categrory != null)
                TitleColumnContent(title: widget.categrory?.name),
              CustomInput(
                label: "",
                hintText: "Search....",
                padding: EdgeInsets.only(bottom: 10),
                svgPath: AppSvg.search,
                controller: roomCubit.searchController,
                iconOnClick: () {
                  roomCubit.search();
                },
              ),
              BlocBuilder<RoomCubit, RoomState>(
                bloc: roomCubit,
                builder: (_, state) {
                  if (state.loading) {
                    return LoadingService.loading();
                  } else if (state.data != null) {
                    return ListView.builder(
                      itemCount: state.data!.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 10),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final item = state.data![index];
                        return OnClickButton(
                          onClick: () {
                            context.pushTo(
                              RoutePaths.detailRoom,
                              arguments: item,
                            );
                          },
                          child: RoomCard(room: item),
                        );
                      },
                    );
                  } else {
                    return SizedBox(height: 250);
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
