import 'package:circe/data/models/book_model.dart';
import 'package:circe/data/models/book_query_params.dart';
import 'package:circe/presentation/providers/connectivity_provider.dart';
import 'package:circe/presentation/viewmodels/book_list_viewmodel.dart';
import 'package:circe/presentation/views/book_detail_view.dart';
import 'package:circe/presentation/widgets/book_card.dart';
import 'package:circe/presentation/widgets/book_card_skeleton.dart';
import 'package:circe/presentation/widgets/book_filter_panel.dart';
import 'package:circe/presentation/widgets/search_bar_widget.dart';
import 'package:circe/utils/debounce.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final SlidingUpPanelController _panelController = SlidingUpPanelController();
  late Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer(milliseconds: 600);

    _scrollController.addListener(() {
      final double maxScroll = _scrollController.position.maxScrollExtent;
      final double currentScroll = _scrollController.position.pixels;
      if (currentScroll >= maxScroll - 300) {
        ref.read(bookListProvider.notifier).fetchNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<ConnectivityResult> connectivity =
        ref.watch(connectivityProvider);

    return connectivity.when(
      data: (connectivityResult) {
        if (connectivityResult == ConnectivityResult.none) {
          return Scaffold(
            appBar: AppBar(title: const Text('Book List')),
            body: const Center(
                child: Text('Please check your internet connection.')),
          );
        }
        return _buildMainContent(context);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    final AsyncValue<List<BookModel>> booksState = ref.watch(bookListProvider);
    final BookListViewModel booksNotifier = ref.read(bookListProvider.notifier);
    final bool isFetchingMore = booksNotifier.isFetchingMore;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text('List Books'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    _panelController.expand();
                  },
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: SearchBarWidget(
                    controller: _searchController,
                    onChanged: (value) {
                      _debouncer.run(() {
                        ref.read(bookListProvider.notifier).setQuery(
                              query: BookQueryParams(search: value),
                            );
                      });
                    },
                    onClear: () {
                      _searchController.clear();
                      ref.read(bookListProvider.notifier).setQuery();
                    },
                  ),
                ),
              ),
            ),
            body: _buildBookList(
              booksState: booksState,
              isFetchingMore: isFetchingMore,
            ),
          ),
          SlidingUpPanelWidget(
            controlHeight: 0,
            panelController: _panelController,
            onTap: () {
              if (SlidingUpPanelStatus.expanded == _panelController.status) {
                return;
              }
            },
            child: SafeArea(
              child: BookFilterPanel(
                onApplyFilters: () {
                  _panelController.collapse();
                  ref
                      .read(bookListProvider.notifier)
                      .fetchBooks(isRefresh: true);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBookList({
    required AsyncValue<List<BookModel>> booksState,
    required bool isFetchingMore,
  }) {
    return booksState.when(
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
            itemCount: books.length + (isFetchingMore ? 1 : 0),
            itemBuilder: (_, i) {
              if (i == books.length && isFetchingMore) {
                return const BookCardSkeleton();
              }
              return BookCard(
                book: books[i],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookDetailView(book: books[i]),
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
    );
  }
}
