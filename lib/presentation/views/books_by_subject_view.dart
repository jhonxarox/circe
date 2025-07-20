import 'package:circe/data/models/book_model.dart';
import 'package:circe/data/models/book_query_params.dart';
import 'package:circe/presentation/viewmodels/book_list_viewmodel.dart';
import 'package:circe/presentation/views/book_detail_view.dart';
import 'package:circe/presentation/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooksBySubjectView extends ConsumerStatefulWidget {
  final String? subject;

  const BooksBySubjectView({
    super.key,
    required this.subject,
  });

  @override
  ConsumerState<BooksBySubjectView> createState() => _BooksBySubjectViewState();
}

class _BooksBySubjectViewState extends ConsumerState<BooksBySubjectView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        ref.read(bookListProvider.notifier).setQuery(
              query: BookQueryParams(
                topic: widget.subject,
              ),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<BookModel>> booksState = ref.watch(bookListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Books: ${widget.subject}'),
      ),
      body: booksState.when(
        data: (books) => books.isEmpty
            ? const Center(child: Text('No books found.'))
            : GridView.builder(
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
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
