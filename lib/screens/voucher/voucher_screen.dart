import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_food_delivery_app/bloc/blocs.dart';
import 'package:max_food_delivery_app/models/models.dart';
import 'package:max_food_delivery_app/repositories/repositories.dart';

class VoucherScreen extends StatelessWidget {
  static const String routeName = '/voucher';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const VoucherScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const VoucherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Basket'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Apply'),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter a Voucher Code',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Voucher Code',
                          contentPadding: EdgeInsets.all(10),
                        ),
                        onChanged: (value) async {
                          print(VoucherRepository().searchVoucher(value));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Your Vouchers',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              BlocBuilder<VoucherBloc, VoucherState>(
                builder: (context, state) {
                  if (state is VoucherLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is VoucherLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.vouchers.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          margin: const EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '1x',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  state.vouchers[index].code,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<VoucherBloc>().add(
                                        SelectVouchers(
                                          voucher: state.vouchers[index],
                                        ),
                                      );
                                  Navigator.pop(context);
                                },
                                child: const Text('Apply'),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
