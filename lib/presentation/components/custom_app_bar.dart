import 'package:bilal/bloc/login_bloc/login_bloc.dart';
import 'package:bilal/bloc/login_bloc/login_state.dart';
import 'package:bilal/utils/clear_nav.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

ShapeBorder kBackButtonShape = const RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(30),
  ),
);

Widget kBackBtn = const Icon(
  Icons.arrow_back_ios,
  // color: Colors.black54,
);

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  @override
  final Size preferredSize;

  const TopBar({super.key, required this.title})
      : preferredSize = const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogOutSuccess) {
          ClearNav.clearAndNavigate("/");
        } else if (state is LogOutFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("something went wrong"),
            ),
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                height: 50,
                minWidth: 50,
                elevation: 10,
                shape: kBackButtonShape,
                onPressed: () {
                  try {
                    GoRouter.of(context).pop();
                  } catch (_) {}
                },
                child: const Icon(Icons.arrow_back_ios_new_sharp),
              ),
              Hero(
                tag: 'title',
                transitionOnUserGestures: true,
                child: Card(
                  elevation: 10,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: 50,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            // color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              MaterialButton(
                height: 50,
                minWidth: 50,
                elevation: 10,
                shape: kBackButtonShape,
                onPressed: () {
                  if (kDebugMode) {
                    print("pressed");
                  }
                },
                child: const Icon(Icons.logout),
              ),
            ],
          ),
        );
      },
    );
  }
}
