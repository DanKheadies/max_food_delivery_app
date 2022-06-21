import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:max_food_delivery_app/bloc/blocs.dart';
import 'package:max_food_delivery_app/widgets/location_search_box.dart';

class Location extends StatelessWidget {
  const Location({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 40,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 8,
                ),
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  height: 50,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    const LocationSearchBox(),
                    BlocBuilder<AutoCompleteBloc, AutoCompleteState>(
                      builder: (context, state) {
                        if (state is AutoCompleteLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is AutoCompleteLoaded) {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            height: 300,
                            color: state.autoComplete.isNotEmpty
                                ? Colors.black.withOpacity(0.6)
                                : Colors.transparent,
                            child: ListView.builder(
                              itemCount: state.autoComplete.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    state.autoComplete[index].description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                  onTap: () {
                                    print(state.autoComplete[index].placeId);
                                    context.read<PlaceBloc>().add(
                                          LoadPlace(
                                            placeId: state
                                                .autoComplete[index].placeId,
                                          ),
                                        );
                                  },
                                );
                              },
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
