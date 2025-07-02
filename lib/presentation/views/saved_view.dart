import 'package:circe/data/models/book_model.dart';
import 'package:circe/presentation/viewmodels/saved_books_provider.dart';
import 'package:circe/presentation/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedView extends ConsumerWidget {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Set<BookModel> savedBooks = ref.watch(savedBooksProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Books')),
      body: savedBooks.isEmpty
          ? const Center(child: Text('No saved books yet.'))
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 250,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: savedBooks.length,
              itemBuilder: (_, i) => BookCard(book: savedBooks.elementAt(i)),
            ),
    );
  }
}
