import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tmdb_movie/presentations/bloc/genere_bloc/genere_bloc.dart';
import 'package:flutter_tmdb_movie/presentations/bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_tmdb_movie/presentations/bloc/person_bloc/person_bloc.dart';
import 'package:flutter_tmdb_movie/res/app_theme.dart';
import 'package:flutter_tmdb_movie/utlity/app_router.dart';
import 'package:flutter_tmdb_movie/utlity/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectionContainer.init();
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(EasyLocalization(
    child: const MyApp(),
    startLocale: const Locale('en'),
    supportedLocales: const [Locale('en'), Locale('my')],
    fallbackLocale: const Locale('en'),
    path: 'assets/translations',
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Theme.of(context).colorScheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(create: (context) => InjectionContainer.sl()),
        BlocProvider<GenereBloc>(create: (context) => InjectionContainer.sl()),
        BlocProvider<PersonBloc>(create: (context) => InjectionContainer.sl()),
      ],
      child: ScreenUtilInit(
        splitScreenMode: true,
        minTextAdapt: true,
        builder: () {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            onGenerateRoute: AppRouter.genereateRoute,
          );
        },
      ),
    );
  }
}
