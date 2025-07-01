import 'package:circe/data/models/book_model.dart';
import 'package:circe/presentation/viewmodels/saved_books_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookDetailView extends ConsumerWidget {
  final BookModel book;

  const BookDetailView({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaved = ref.watch(likedBooksProvider).contains(book.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(likedBooksProvider.notifier).toggle(book);
        },
        child: Icon(
          isSaved ? Icons.bookmark : Icons.bookmark_border,
          color: isSaved ? Colors.blue : null,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(book.imageUrl!,
                    height: 250, fit: BoxFit.cover),
              ),
            const SizedBox(height: 16),
            Text(book.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(book.authors.join(', '),
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            if (book.summary != null)
              Text(book.summary!, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              children: book.subjects.map((s) => Chip(label: Text(s))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
