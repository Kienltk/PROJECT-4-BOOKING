import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/components/app_bar/custom_app_bar.dart';
import 'package:staynia/components/button/blur_button.dart';
import 'package:staynia/components/container/container_body.dart';
import 'package:staynia/core/base/base_screen.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/constants/app_svg.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/providers/manager/category/manager/category_cubit.dart';
import 'package:staynia/providers/manager/category/manager/category_state.dart';
import 'package:staynia/service/loading_service.dart';

class TagScreen extends StatefulWidget {
  const TagScreen({super.key});

  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends BaseScreen<TagScreen> {
  @override
  Map<Type, BaseCubit Function()> get cubitFactories => {
    CategoryCubit: () => sl<CategoryCubit>(),
  };
  late final CategoryCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getCubit<CategoryCubit>();
    cubit.onInit(arg: 3);
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(shadow: true, title: 'Tags', divider: true),
      body: SingleChildScrollView(
        child: ContainerBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<CategoryCubit, CategoryState>(
                bloc: cubit,
                builder: (_, state) {
                  if (state.loading) {
                    return LoadingService.loading();
                  } else if (state.tags != null) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 30),
                      itemCount: state.tags?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                          ),
                      itemBuilder: (context, index) {
                        final item = state.tags?[index];
                        return GestureDetector(
                          onTap: () =>
                              cubit.onCategoryClick(category: item!, type: 3),
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
                                child: Text(
                                  item?.name ?? '-',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
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
      floatingActionButton: BlurButton(
        onClick: () => cubit.create('TAG'),
        icon: AppSvg.add,
        size: 60,
      ),
    );
  }
}
