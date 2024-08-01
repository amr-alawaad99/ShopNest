import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopnest/cubit/main_cubit.dart';
import 'package:shopnest/cubit/main_state.dart';
import '../widgets/banner_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state is GetHomeDataSuccessState) {}
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GetHomeDataLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is GetHomeDataSuccessState
                  ? Column(
                      children: [
                        BannerWidget(
                            homeModel: context.read<MainCubit>().homeModel!)
                      ],
                    )
                  : Container(
                      child: Text("Hii_error"),
                    ),
        );
      },
    );
  }
}
