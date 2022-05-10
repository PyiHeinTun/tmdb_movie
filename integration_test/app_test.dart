import 'package:easy_localization/easy_localization.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tmdb_movie/main.dart';
import 'package:flutter_tmdb_movie/persistence/hive_helper.dart';
import 'package:flutter_tmdb_movie/presentations/pages/home.dart';
import 'package:flutter_tmdb_movie/presentations/widgets/home/get_movie_from_genere.dart';
import 'package:integration_test/integration_test.dart';

import 'test_data/movie_test_data.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();
  await HiveHelper.registerAdapter();
  await HiveHelper.openBoxs();
  testWidgets('home screen all test', (WidgetTester tester) async {
    ///INITTIALIZE APP
    await tester.pumpWidget(EasyLocalization(
      child: const MyApp(),
      startLocale: const Locale('en'),
      supportedLocales: const [Locale('en'), Locale('my')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
    ));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    //Verify HomeScreen Is Displayed
    // BANNER SECTION DETAIL
    expect(find.byType(HomePage), findsOneWidget);

    //Scroll Screen
    await tester.dragUntilVisible(find.byType(GetMovieFromGenere),
        find.byType(HomePage), const Offset(0, 30));
    await tester.pump(const Duration(seconds: 5));

    /// ========== TAPPING ACTION ==========///
    //TEST GENERE TAP

    await tester.tap(find.byKey(const ValueKey(kTestMovieGenre1)));

    await tester.pump(const Duration(seconds: 3));

    await tester.tap(find.byKey(const ValueKey(kTestMovieGenre2)));

    await tester.pump(const Duration(seconds: 3));

    await tester.tap(find.byKey(const ValueKey(kTestMovieGenre3)));

    await tester.pump(const Duration(seconds: 5));

    //CHECK DETAIL 1
    await tester.tap(find.byKey(const ValueKey(kTestMovieId1)));

    await Future.delayed(const Duration(seconds: 3));
    await tester.pump(const Duration(seconds: 3));

    for (var i = 0; i < kTestMoviegenereList1.length; i++) {
      expect(
          find.byWidgetPredicate((element) =>
              element is Text && element.data == kTestMoviegenereList1[i]),
          findsOneWidget);
    }

    expect(
        find.byWidgetPredicate(
            (element) => element is Text && element.data == kTestMovieTitle1),
        findsOneWidget);

    expect(find.byKey(const ValueKey(kTestMovieRating1)), findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (element) => element is Text && element.data == kTestMovieDesc1),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (element) => element is Text && element.data == kTestMovieRating1),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (element) => element is Text && element.data == kTestMovieType1),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (element) => element is Text && element.data == kTestMovieTime1),
        findsOneWidget);

    await tester.tap(find.byIcon(
      EvaIcons.arrowIosBackOutline,
    ));

    await tester.pump(const Duration(seconds: 3));

    //CHECK DETAIL 2
    await tester.tap(find.byKey(const ValueKey(kTestMovieId2)));

    await Future.delayed(const Duration(seconds: 3));
    await tester.pump(const Duration(seconds: 3));

    for (var i = 0; i < kTestMoviegenereList2.length; i++) {
      expect(
          find.byWidgetPredicate((element) =>
              element is Text && element.data == kTestMoviegenereList2[i]),
          findsOneWidget);
    }

    expect(
        find.byWidgetPredicate(
            (element) => element is Text && element.data == kTestMovieTitle2),
        findsOneWidget);

    expect(find.byKey(const ValueKey(kTestMovieRating2)), findsOneWidget);

    expect(
        find.byWidgetPredicate(
            (element) => element is Text && element.data == kTestMovieDesc2),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (element) => element is Text && element.data == kTestMovieRating2),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (element) => element is Text && element.data == kTestMovieType2),
        findsOneWidget);
    expect(
        find.byWidgetPredicate(
            (element) => element is Text && element.data == kTestMovieTime2),
        findsOneWidget);

    await tester.tap(find.byIcon(
      EvaIcons.arrowIosBackOutline,
    ));

    await tester.pump(const Duration(seconds: 3));
  });
}
