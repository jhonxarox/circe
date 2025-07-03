import 'package:circe/data/models/book_model.dart';
import 'package:circe/presentation/providers/connectivity_provider.dart';
import 'package:circe/presentation/viewmodels/saved_books_provider.dart';
import 'package:circe/presentation/views/book_detail_view.dart';
import 'package:circe/presentation/widgets/book_card.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedView extends ConsumerWidget {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ConnectivityResult> connectivity =
        ref.watch(connectivityProvider);

    return connectivity.when(
      data: (connectivityResult) {
        if (connectivityResult == ConnectivityResult.none) {
          return Scaffold(
            appBar: AppBar(title: const Text('Saved Books')),
            body: const Center(
                child: Text('Please check your internet connection.')),
          );
        }
        final AsyncValue<List<BookModel>> booksAsync =
            ref.watch(savedBookListProvider);

        return Scaffold(
          appBar: AppBar(title: const Text('Saved Books')),
          body: booksAsync.when(
            data: (books) {
              if (books.isEmpty) {
                return const Center(child: Text('No saved books yet.'));
              }

              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 250,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: books.length,
                itemBuilder: (_, i) => BookCard(
                  book: books[i],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookDetailView(book: books[i]),
                    ),
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('Error: $error')),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const Scaffold(
        body: Center(child: Text('Failed to check connection')),
      ),
    );
  }
}
