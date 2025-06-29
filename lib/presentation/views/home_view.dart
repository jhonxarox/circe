import 'package:circe/data/models/book_model.dart';
import 'package:circe/presentation/viewmodels/book_list_viewmodel.dart';
import 'package:circe/presentation/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final double maxScroll = _scrollController.position.maxScrollExtent;
      final double currentScroll = _scrollController.position.pixels;

      if (currentScroll >= maxScroll - 300) {
        ref.read(bookListProvider.notifier).fetchBooks();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<BookModel>> booksState = ref.watch(bookListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('List Books'),
      ),
      body: booksState.when(
        data: (books) {
          return RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(bookListProvider.notifier)
                  .fetchBooks(isRefresh: true);
            },
            child: GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 250,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: books.length,
              itemBuilder: (_, i) => BookCard(book: books[i]),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
