import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/components/app_bar/custom_app_bar.dart';
import 'package:staynia/components/button/app_button.dart';
import 'package:staynia/components/button/on_click_button.dart';
import 'package:staynia/components/container/bottom_container.dart';
import 'package:staynia/components/container/container_body.dart';
import 'package:staynia/components/container/dashed_border.dart';
import 'package:staynia/components/filter/option_filter.dart';
import 'package:staynia/components/input/app_quill_editor.dart';
import 'package:staynia/components/input/custom_input.dart';
import 'package:staynia/components/input/read_only_input.dart';
import 'package:staynia/components/media/app_asset_icon.dart';
import 'package:staynia/components/media/image_gallery_view.dart';
import 'package:staynia/components/title_column_content.dart';
import 'package:staynia/components/widgets/facility_icon.dart';
import 'package:staynia/core/base/base_screen.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/constants/app_svg.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/data/entity/enum/app_button_type.dart';
import 'package:staynia/extension/theme_extension.dart';
import 'package:staynia/providers/manager/category/manager/category_cubit.dart';
import 'package:staynia/providers/manager/document/document_cubit.dart';
import 'package:staynia/providers/manager/document/document_state.dart';
import 'package:staynia/screens/admin/room/manager/create_room_cubit.dart';
import 'package:staynia/screens/admin/room/manager/create_room_state.dart';
import 'package:staynia/service/loading_service.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends BaseScreen<CreateRoomScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Map<Type, BaseCubit Function()> get cubitFactories => {
    CreateRoomCubit: () => sl<CreateRoomCubit>(),
    DocumentCubit: () => sl<DocumentCubit>(),
    CategoryCubit: () => sl<CategoryCubit>(),
  };
  late final CreateRoomCubit cubit;
  late final DocumentCubit documentCubit;
  late final CategoryCubit categoryCubit;

  @override
  void initState() {
    super.initState();
    cubit = getCubit<CreateRoomCubit>();
    documentCubit = getCubit<DocumentCubit>();
    categoryCubit = getCubit<CategoryCubit>();
    categoryCubit.onInit();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildScreen(context);
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(shadow: true),
      body: BlocBuilder<CreateRoomCubit, CreateRoomState>(
        bloc: cubit,
        builder: (_, state) {
          if (state.loading) {
            return LoadingService.loading();
          }
          return SingleChildScrollView(
            child: ContainerBody(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleColumnContent(
                    title: "Create Room",
                    text: "Create your Room!",
                  ),
                  CustomInput(
                    label: "Title",
                    hintText: "Enter Title",
                    isRequired: true,
                    padding: const EdgeInsets.only(bottom: 10),
                    controller: cubit.titleController,
                  ),
                  CustomInput(
                    label: "SubTitle",
                    hintText: "Enter SubTitle",
                    isRequired: true,
                    padding: const EdgeInsets.only(bottom: 10),
                    controller: cubit.subTitleController,
                  ),
                  CustomInput(
                    label: "Price PerNight",
                    hintText: "Enter Price PerNight",
                    isRequired: true,
                    currency: true,
                    padding: const EdgeInsets.only(bottom: 10),
                    controller: cubit.pricePerNightController,
                  ),
                  CustomInput(
                    label: "Cleaning Fee",
                    hintText: "Enter Cleaning Fee",
                    isRequired: true,
                    currency: true,
                    padding: const EdgeInsets.only(bottom: 10),
                    controller: cubit.cleaningFeeController,
                  ),
                  CustomInput(
                    label: "Service Fee",
                    currency: true,
                    hintText: "Enter Service Fee",
                    isRequired: true,
                    padding: const EdgeInsets.only(bottom: 10),
                    controller: cubit.serviceFeeController,
                  ),
                  Box.s10,
                  Row(
                    children: [
                      Expanded(
                        child: ReadOnlyInput(
                          onClick: cubit.showMaxGuests,
                          isRequired: true,
                          label: "Max Guests",
                          hintText: '${state.maxGuests ?? "Select"}',
                          svgPath: AppSvg.arrowDown,
                          padding: const EdgeInsets.all(0).copyWith(bottom: 10),
                        ),
                      ),
                      Box.s10,
                      Expanded(
                        child: ReadOnlyInput(
                          onClick: cubit.showRoomCount,
                          isRequired: true,
                          label: "Room Count",
                          hintText: '${state.roomCount ?? "Select"}',
                          svgPath: AppSvg.arrowDown,
                          padding: const EdgeInsets.all(0).copyWith(bottom: 10),
                        ),
                      ),
                    ],
                  ),
                  ReadOnlyInput(
                    onClick: cubit.showBathRoomCount,
                    isRequired: true,
                    label: "Bath Room Count",
                    hintText: '${state.bathroomCount ?? "Select"}',
                    svgPath: AppSvg.arrowDown,
                    padding: const EdgeInsets.all(0).copyWith(bottom: 10),
                  ),
                  BlocBuilder<DocumentCubit, DocumentState>(
                    bloc: documentCubit,
                    builder: (_, state) {
                      return ImageGalleryView(
                        documents: state.data,
                        callBack: (documents) {
                          cubit.documents = documents;
                        },
                        callBackUpdate: cubit.updateDocument,
                        documentCubit: documentCubit,
                        isEdit: true,
                        topWidget: RichText(
                          text: TextSpan(
                            text: 'Image',
                            style: TextStyle(
                              fontSize: 12.3,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              const TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Box.s16,
                  DashedBorder(
                    title: "Tags",
                    isRequired: true,
                    color: state.tags == null ? Colors.grey : null,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: OptionFilter(
                        grid: state.tags == null ? 1 : 4,
                        aspectRatio: state.tags == null ? 5 : 1.5,
                        widgetItems: [
                          ...(state.tags ?? []).asMap().entries.map((item) {
                            return OnClickButton(
                              onClick: () =>
                                  cubit.removeCategory(3, item.value),
                              child: Container(
                                padding: const EdgeInsets.all(defaultPadding),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(
                                    defaultBorderRadious,
                                  ),
                                  border: Border.all(
                                    color: context.primaryColor,
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  item.value.name ?? '-',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          }),
                          GestureDetector(
                            onTap: () {
                              categoryCubit.showIcons(
                                data: state.tags,
                                type: 3,
                                callBack: (data) =>
                                    cubit.callBackCategory(type: 3, data: data),
                              );
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              padding: EdgeInsets.all(20),
                              child: Center(
                                child: AppAssetIcon(AppSvg.add, size: 40),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Box.s16,
                  DashedBorder(
                    title: "Categories",
                    isRequired: true,
                    color: state.categories == null ? Colors.grey : null,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: OptionFilter(
                        grid: state.categories == null ? 1 : 4,
                        aspectRatio: state.categories == null ? 5 : 1.5,
                        widgetItems: [
                          ...(state.categories ?? []).asMap().entries.map((
                            item,
                          ) {
                            return OnClickButton(
                              onClick: () =>
                                  cubit.removeCategory(1, item.value),
                              child: Container(
                                padding: const EdgeInsets.all(defaultPadding),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(
                                    defaultBorderRadious,
                                  ),
                                  border: Border.all(
                                    color: context.primaryColor,
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  item.value.name ?? '-',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          }),
                          GestureDetector(
                            onTap: () {
                              categoryCubit.showIcons(
                                data: state.categories,
                                type: 1,
                                callBack: (data) =>
                                    cubit.callBackCategory(type: 1, data: data),
                              );
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              padding: EdgeInsets.all(20),
                              child: Center(
                                child: AppAssetIcon(AppSvg.add, size: 40),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Box.s16,
                  DashedBorder(
                    title: "Commons",
                    isRequired: true,
                    color: state.commons == null ? Colors.grey : null,
                    child: Padding(
                      padding: const EdgeInsets.all(
                        10.0,
                      ).copyWith(top: state.commons == null ? 10 : 20),
                      child: OptionFilter(
                        grid: state.commons == null ? 1 : 4,
                        aspectRatio: state.commons == null ? 5 : 1.2,
                        widgetItems: [
                          ...(state.commons ?? []).asMap().entries.map((item) {
                            return OnClickButton(
                              onClick: () =>
                                  cubit.removeCategory(2, item.value),
                              child: FacilityIcon(
                                svg: item.value.icon!,
                                label: item.value.name!,
                                size: 25,
                              ),
                            );
                          }),
                          GestureDetector(
                            onTap: () {
                              categoryCubit.showIcons(
                                data: state.commons,
                                type: 2,
                                callBack: (data) =>
                                    cubit.callBackCategory(type: 2, data: data),
                              );
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              padding: EdgeInsets.all(20),
                              child: Center(
                                child: AppAssetIcon(AppSvg.add, size: 40),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                    ).copyWith(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultBorderRadious),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: QuillTextEditor(onChanged: cubit.setDescription),
                  ),
                  Box.s10,
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomContainer(
        child: AppButton(
          content: "Create",
          type: AppButtonType.primary,
          onClick: cubit.create,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
