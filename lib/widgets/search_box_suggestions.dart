import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_food_delivery_app/bloc/blocs.dart';

class SearchBoxSuggestions extends StatelessWidget {
  const SearchBoxSuggestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutoCompleteBloc, AutoCompleteState>(
      builder: (context, state) {
        if (state is AutoCompleteLoading) {
          return const SizedBox();
        }
        if (state is AutoCompleteLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: state.autoComplete.length,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.black.withOpacity(0.6),
                child: ListTile(
                  title: Text(
                    state.autoComplete[index].description,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  onTap: () {
                    context.read<LocationBloc>().add(
                          SearchLocation(
                            placeId: state.autoComplete[index].placeId,
                          ),
                        );
                    context.read<AutoCompleteBloc>().add(ClearAutoComplete());
                  },
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
