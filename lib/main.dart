import 'package:bilal/bloc/admin_parent/admin_parent_bloc.dart';
import 'package:bilal/bloc/bloc_observer.dart';
import 'package:bilal/bloc/login_bloc/login_bloc.dart';
import 'package:bilal/bloc/login_bloc/login_event.dart';
import 'package:bilal/firebase_options.dart';
import 'package:bilal/repository/auth_repository.dart';
import 'package:bilal/routes/routes_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  AuthRepository authRepository =
      AuthRepository(firebaseAuth: FirebaseAuth.instance);
  Bloc.observer = SimpleBlocObserver();
  runApp(Bilal(
    authRepository: authRepository,
  ));
}

class Bilal extends StatelessWidget {
  final AuthRepository authRepository;

  const Bilal({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) =>
                LoginBloc(authRepository: authRepository)..add(LoadLogin()),
          ),
          BlocProvider<AdminParentBloc>(
            create: (context) => AdminParentBloc()..add(const GetParents()),
          )
        ],
        child: MaterialApp.router(
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("ar", "AE"), // OR Locale('ar', 'AE') OR Other RTL locales
          ],
          locale: const Locale("ar", "AE"),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: "Cairo", useMaterial3: true),
          routerConfig: AppRoute.getRouter(authRepository),
        ));
  }
}
