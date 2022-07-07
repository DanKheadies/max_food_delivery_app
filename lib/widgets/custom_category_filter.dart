import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_food_delivery_app/bloc/blocs.dart';
// import 'package:max_food_delivery_app/models/models.dart';

class CustomCategoryFilter extends StatelessWidget {
  // final List<Category> categories;

  const CustomCategoryFilter({
    Key? key,
    // required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        if (state is FilterLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is FilterLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            // itemCount: categories.length,
            itemCount: state.filter.categoryFilters.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // categories[index].name,
                      state.filter.categoryFilters[index].category.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 25,
                      child: Checkbox(
                        value: state.filter.categoryFilters[index].value,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (bool? newValue) {
                          context.read<FilterBloc>().add(
                                UpdateCategoryFilter(
                                  categoryFilter: state
                                      .filter.categoryFilters[index]
                                      .copyWith(
                                          value: !state.filter
                                              .categoryFilters[index].value),
                                ),
                              );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }
}
