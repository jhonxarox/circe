import 'package:circe/core/constants.dart';
import 'package:circe/data/datasources/book_api_service.dart';
import 'package:circe/data/models/book_model.dart';
import 'package:circe/data/models/book_query_params.dart';
import 'package:circe/data/models/book_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedBooksProvider extends StateNotifier<Set<int>> {
  SavedBooksProvider() : super({}) {
    _loadSavedBookIds();
  }

  Future<void> _loadSavedBookIds() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? idStrings =
        prefs.getStringList(SharedPreferencesKeys.savedBookIds);

    if (idStrings != null) {
      final Set<int> ids = idStrings.map(int.parse).toSet();
      state = ids;
    }
  }

  bool isSaved(int bookId) => state.contains(bookId);

  Future<void> toggle(int bookId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Set<int> newState = {...state};

    if (newState.contains(bookId)) {
      newState.remove(bookId);
    } else {
      newState.add(bookId);
    }

    state = newState;
    await prefs.setStringList(
      SharedPreferencesKeys.savedBookIds,
      newState.map((id) => id.toString()).toList(),
    );
  }
}

final StateNotifierProvider<SavedBooksProvider, Set<int>> savedBooksProvider =
    StateNotifierProvider<SavedBooksProvider, Set<int>>(
  (ref) => SavedBooksProvider(),
);

final FutureProvider<List<BookModel>> savedBookListProvider =
    FutureProvider<List<BookModel>>(
  (ref) async {
    final Set<int> savedIds = ref.watch(savedBooksProvider);
    if (savedIds.isEmpty) return [];

    final BookApiService api = BookApiService();
    final BookResponseModel response = await api.fetchBooks(
      query: BookQueryParams(ids: savedIds.toList()),
    );

    return response.results;
  },
);
