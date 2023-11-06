import 'package:bilal/bloc/login_bloc/login_bloc.dart';
import 'package:bilal/bloc/login_bloc/login_event.dart';
import 'package:bilal/bloc/login_bloc/login_state.dart';
import 'package:bilal/presentation/components/menu_card.dart';
import 'package:bilal/utils/clear_nav.dart';
import 'package:bilal/utils/homepage_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final tabsList = HomepagesList.getList("admin");

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogOutSuccess) {
          ClearNav.clearAndNavigate("/");
        } else if (state is LogOutFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.toString()),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LogOutLoading:
            return const LinearProgressIndicator();
          default:
            return HomePageMain(tabsList: tabsList);
        }
      },
    );
  }
}

class HomePageMain extends StatelessWidget {
  const HomePageMain({
    super.key,
    required this.tabsList,
  });

  final List<List> tabsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("مرحبا"),
          actions: [
            IconButton(
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(LogOut());
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemCount: tabsList.length,
            itemBuilder: (BuildContext context, int index) {
              return MenuCard(
                name: tabsList[index][0],
                icon: tabsList[index][1],
                routeName: tabsList[index][2],
              );
            }));
  }
}
