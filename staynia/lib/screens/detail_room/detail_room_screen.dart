import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/components/app_bar/custom_sliver_app_bar.dart';
import 'package:staynia/components/button/blur_button.dart';
import 'package:staynia/components/container/bottom_container.dart';
import 'package:staynia/components/item/column_content.dart';
import 'package:staynia/components/item/room_list_content.dart';
import 'package:staynia/components/media/app_cache_image.dart';
import 'package:staynia/components/media/image_gallery_view.dart';
import 'package:staynia/components/section/title_with_action.dart';
import 'package:staynia/components/widgets/custom_render_html.dart';
import 'package:staynia/components/widgets/facility_icon.dart';
import 'package:staynia/core/base/base_screen.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/constants/app_svg.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/data/entity/model/room.dart';
import 'package:staynia/extension/app_extension.dart';
import 'package:staynia/extension/context_extension.dart';
import 'package:staynia/extension/navigator_extension.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/providers/manager/document/document_cubit.dart';
import 'package:staynia/router/router_path.dart';
import 'package:staynia/screens/detail_room/manager/detailroom_cubit.dart';
import 'package:staynia/screens/detail_room/manager/detailroom_state.dart';
import 'package:staynia/service/loading_service.dart';

class DetailRoomScreen extends StatefulWidget {
  const DetailRoomScreen({super.key, required this.room});
  final Room room;

  @override
  DetailRoomScreenState createState() => DetailRoomScreenState();
}

class DetailRoomScreenState extends BaseScreen<DetailRoomScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Map<Type, BaseCubit Function()> get cubitFactories => {
    DetailRoomCubit: () => sl<DetailRoomCubit>(),
    DocumentCubit: () => sl<DocumentCubit>(),
  };
  late final DetailRoomCubit cubit;
  late final DocumentCubit documentCubit;

  @override
  void initState() {
    super.initState();
    cubit = getCubit<DetailRoomCubit>();
    documentCubit = getCubit<DocumentCubit>();
    cubit.onInit(arg: widget.room.id);
  }

  bool changeColor = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildScreen(context);
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailRoomCubit, DetailroomState>(
        bloc: cubit,
        builder: (_, state) {
          Room? data = state.data;
          return CustomScrollView(
            controller: cubit.scrollController,
            slivers: [
              CustomSliverAppBar(
                controller: cubit.scrollController,
                expandedHeight: context.sizeHeight * 0.36,
                callbackColor: (color) {
                  setState(() {
                    changeColor = color != Colors.white;
                  });
                },
                actions: [
                  BlurButton(
                    onClick: () {},
                    icon: AppSvg.favorite,
                    iconColor: changeColor ? null : Colors.white,
                    borderColor: !changeColor ? null : Colors.grey[300],
                  ),
                  Box.s8,
                  BlurButton(
                    onClick: () {},
                    icon: AppSvg.share,
                    iconColor: changeColor ? null : Colors.white,
                    borderColor: !changeColor ? null : Colors.grey[300],
                  ),
                  Box.s8,
                ],
                title: data?.title ?? "-",
                flexibleSpaceWidget: SizedBox(
                  width: context.sizeWidth,
                  child: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadiusGeometry.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          child: AppCacheImage(
                            fit: BoxFit.cover,
                            radius: 0,
                            images: data?.documents ?? [],
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      data?.title ?? "-",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    centerTitle: true,
                  ),
                ),
              ),
              if (state.data != null)
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                data?.subTitle ?? "-",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 18,
                                ),
                                SizedBox(width: 4),
                                Text("4.6"),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (data!.documents!.length > 1)
                          ImageGalleryView(
                            topWidget: Text(
                              "Galley",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            documents: data.documents,
                          ),
                        TitleWithAction(
                          title: 'Common Facilities ☀️',
                          onClick: cubit.showCategory,
                        ),
                        Box.s6,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ...(data.commons?.take(4).toList() ?? []).map((
                              item,
                            ) {
                              return FacilityIcon(
                                svg: item.icon!,
                                label: item.name!,
                                isAutoSizeText: false,
                                size: 25,
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 10),
                        MultyColumContent(
                          title: "Costs",
                          paddingTop: 10,
                          data: [
                            {
                              "title": "Per night",
                              "value": data.pricePerNight.toVND,
                            },
                            {
                              "title": "Cleaning fee",
                              "value": data.cleaningFee.toVND,
                            },
                            {
                              "title": "Service fee",
                              "value": data.serviceFee.toVND,
                            },
                          ],
                        ),

                        const SizedBox(height: 15),
                        const Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomRenderHtmlPreview(
                          html: data.description ?? '',
                          room: data,
                        ),
                        const SizedBox(height: 20),
                        RoomListContent(
                          title: 'Related',
                          style: 3,
                          onClick: () {
                            context.pushTo(RoutePaths.search);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverToBoxAdapter(child: LoadingService.loading()),
            ],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<DetailRoomCubit, DetailroomState>(
        bloc: cubit,
        builder: (_, state) {
          Room? data = state.data;
          return state.data != null
              ? BottomContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data?.pricePerNight.toVND} VND',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.pushTo(
                            RoutePaths.requestToBook,
                            arguments: data,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Booking Now",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
