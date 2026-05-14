import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/components/app_bar/custom_app_bar.dart';
import 'package:staynia/components/container/container_body.dart';
import 'package:staynia/components/media/app_asset_icon.dart';
import 'package:staynia/components/title_column_content.dart';
import 'package:staynia/core/base/base_screen.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/providers/manager/category/manager/category_cubit.dart';
import 'package:staynia/providers/manager/category/manager/category_state.dart';
import 'package:staynia/service/loading_service.dart';

class CommonScreen extends StatefulWidget {
  const CommonScreen({super.key});

  @override
  State<CommonScreen> createState() => _CommonScreenState();
}

class _CommonScreenState extends BaseScreen<CommonScreen> {
  @override
  Map<Type, BaseCubit Function()> get cubitFactories => {
    CategoryCubit: () => sl<CategoryCubit>(),
  };
  late final CategoryCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getCubit<CategoryCubit>();
    cubit.onInit(arg: 2);
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
              TitleColumnContent(title: "Commons"),
              BlocBuilder<CategoryCubit, CategoryState>(
                bloc: cubit,
                builder: (_, state) {
                  if (state.loading) {
                    return LoadingService.loading();
                  } else if (state.commons != null) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 10),
                      itemCount: state.commons?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                          ),
                      itemBuilder: (context, index) {
                        final item = state.commons?[index];
                        return GestureDetector(
                          onTap: () =>
                              cubit.onCategoryClick(category: item, type: 2),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(
                                    defaultBorderRadious,
                                  ),
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 1.5,
                                  ),
                                ),
                                child: AppAssetIcon(
                                  item!.icon!,
                                  size: 50,
                                  color: Colors.black,
                                ),
                              ),
                              Box.s14,
                              Text(
                                item.name!,
                                style: const TextStyle(fontSize: 11),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
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
