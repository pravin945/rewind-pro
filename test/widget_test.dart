import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:motorshop_manager/core/database/app_database.dart';
import 'package:motorshop_manager/core/providers/database_providers.dart';
import 'package:motorshop_manager/main.dart';

void main() {
  testWidgets('MotorShop Manager app launches successfully with home dashboard', (WidgetTester tester) async {
    final testDb = AppDatabase(NativeDatabase.memory());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(testDb),
        ],
        child: const MotorShopManagerApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(MotorShopManagerApp), findsOneWidget);
    await testDb.close();
  });
}
