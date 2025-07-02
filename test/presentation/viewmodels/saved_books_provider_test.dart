import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:circe/presentation/viewmodels/saved_books_provider.dart';

void main() {
  group('SavedBooksProvider', () {
    late SavedBooksProvider provider;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      provider = SavedBooksProvider();
      await Future.delayed(
          const Duration(milliseconds: 10)); // wait for _loadSavedBookIds
    });

    test('initial state is empty', () {
      expect(provider.state, isEmpty);
    });

    test('toggle adds and removes book ID', () async {
      await provider.toggle(42);
      expect(provider.state.contains(42), true);

      await provider.toggle(42);
      expect(provider.state.contains(42), false);
    });

    test('isSaved returns correct state', () async {
      await provider.toggle(7);
      expect(provider.isSaved(7), true);

      await provider.toggle(7);
      expect(provider.isSaved(7), false);
    });
  });
}
