import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/components/button/on_click_button.dart';
import 'package:staynia/components/container/my_container.dart';
import 'package:staynia/components/media/app_cache_image.dart';
import 'package:staynia/components/section/title_with_action.dart';
import 'package:staynia/components/widgets/auto_size_text.dart';
import 'package:staynia/components/widgets/room_card.dart';
import 'package:staynia/core/base/base_screen.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/data/entity/enum/screen_type.dart';
import 'package:staynia/data/entity/model/category.dart' show Category;
import 'package:staynia/data/entity/model/room.dart';
import 'package:staynia/extension/app_extension.dart';
import 'package:staynia/extension/context_extension.dart';
import 'package:staynia/extension/navigator_extension.dart';
import 'package:staynia/extension/theme_extension.dart';
import 'package:staynia/router/router_path.dart';
import 'package:staynia/screens/home/manager/room_cubit.dart';
import 'package:staynia/screens/home/manager/room_state.dart';

class RoomListContent extends StatefulWidget {
  const RoomListContent({
    super.key,
    required this.title,
    required this.onClick,
    this.category,
    this.style = 0,
  });
  final String title;
  final VoidCallback onClick;
  final Category? category;
  final int style;

  @override
  State<RoomListContent> createState() => _RoomListContentState();
}

class _RoomListContentState extends BaseScreen<RoomListContent>
    with AutomaticKeepAliveClientMixin {
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
        "ScreenType": ScreenType.homeScreen,
        "categoryId": widget.category?.id,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildScreen(context);
  }

  @override
  Widget buildScreen(BuildContext context) {
    final cardWidth = context.sizeWidth * 0.44;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithAction(
          title: "${widget.title}  $randomIcon",
          onClick: widget.onClick,
        ),
        BlocBuilder<RoomCubit, RoomState>(
          bloc: roomCubit,
          builder: (_, state) {
            if (state.loading) {
              return SizedBox.shrink();
            } else if (state.data != null) {
              final data = state.data!;
              if (widget.style == 0) {
                return SizedBox(
                  height: 250,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 14),
                    itemBuilder: (context, index) {
                      final p = data[index];
                      return _PropertyCard(property: p, width: cardWidth);
                    },
                    padding: const EdgeInsets.only(right: 8),
                  ),
                );
              } else if (widget.style == 1) {
                return ListView.builder(
                  itemCount: state.data!.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 10),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final item = state.data![index];
                    return OnClickButton(
                      onClick: () {
                        context.pushTo(RoutePaths.detailRoom, arguments: item);
                      },
                      child: RoomCard(room: item),
                    );
                  },
                );
              } else if (widget.style == 2) {
                return ListView.builder(
                  itemCount: state.data!.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (BuildContext context, int index) {
                    final item = state.data![index];
                    return OnClickButton(
                      onClick: () {
                        context.pushTo(RoutePaths.detailRoom, arguments: item);
                      },
                      child: MyContainer(
                        borderRadius: 25,
                        margin: EdgeInsets.only(bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: AppCacheImage(
                                radius: 25,
                                images: item.documents,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    item.title ?? '-',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.headlineSmall!.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    '${item.pricePerNight.toVND}VND /Night',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.titleMedium!.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    item.subTitle ?? '-',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.bodySmall!.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '4.9 (1,092 Reviews)',
                                  style: context.bodySmall!.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return ListView.builder(
                  itemCount: state.data!.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(bottom: 10),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final item = state.data![index];
                    return OnClickButton(
                      onClick: () {
                        context.pushTo(RoutePaths.detailRoom, arguments: item);
                      },
                      child: RoomCard(room: item),
                    );
                  },
                );
              }
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _PropertyCard extends StatelessWidget {
  final Room property;
  final double width;
  const _PropertyCard({required this.property, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: () {
          context.pushTo(RoutePaths.detailRoom, arguments: property);
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(defaultBorderRadious),
              child: Container(
                color: Colors.grey[300],
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AppCacheImage(images: property.documents!),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacitySafe(0.65),
                          ],
                          stops: const [0.45, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacitySafe(0.95),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(6),
                child: const Icon(
                  Icons.favorite_border,
                  color: Colors.redAccent,
                  size: 18,
                ),
              ),
            ),
            Positioned(
              left: 5,
              right: 5,
              bottom: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (property.subTitle != null)
                    Text(
                      property.title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        shadows: [Shadow(blurRadius: 2, color: Colors.black26)],
                      ),
                    ),
                  if (property.subTitle != null)
                    Text(
                      property.subTitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        shadows: [Shadow(blurRadius: 2, color: Colors.black26)],
                      ),
                    ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      AutoSizeText(
                        text: property.pricePerNight.toVND,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
