// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:assign_khalti/common/widgets/search_list_view_widget.dart';
import 'package:assign_khalti/src/home/logic/bank_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_test/flutter_test.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route {}

void main() {
  late NavigatorObserver mockObserver;

  setUpAll(() {
    mockObserver = MockNavigatorObserver();
    registerFallbackValue(FakeRoute());
  });

  group("Search Field Test Cases", () {
    testWidgets("Search TextFormField Test", (WidgetTester tester) async {
      await tester.pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider<BankBloc>(
            create: (_) => BankBloc(),
          )
        ],
        child: const MaterialApp(
          home: SearchListWidget(),
        ),
      ));
      Finder cupertinoSearchField =
          find.byKey(const Key('Search Bank Field'), skipOffstage: false);

      expect(cupertinoSearchField, findsOneWidget);
      await tester.enterText(cupertinoSearchField, 'NSBL');
      expect(find.text('NSBL'), findsOneWidget);
    });

    testWidgets(
        "Cancel Button test case. When button is pressed the page is closed",
        (WidgetTester tester) async {
      await tester.pumpWidget(MultiBlocProvider(
        providers: [
          BlocProvider<BankBloc>(
            create: (_) => BankBloc(),
          )
        ],
        child: MaterialApp(
          home: const SearchListWidget(),
          navigatorObservers: [mockObserver],
        ),
      ));
      Finder cancelBtn =
          find.byKey(const Key('Cancel Button Pop'), skipOffstage: false);
      expect(cancelBtn, findsOneWidget);

      await tester.tap(find.byKey(const Key('Cancel Button Pop')));
      await tester.pumpAndSettle();

      verify(() => mockObserver.didPop(any(), any()));
    });
  });
}
