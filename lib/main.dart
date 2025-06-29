import 'package:circe/presentation/viewmodels/book_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TestHome(),
    );
  }
}

class TestHome extends ConsumerWidget {
  const TestHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksState = ref.watch(bookListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Books Test')),
      body: booksState.when(
        data: (books) => ListView.builder(
          itemCount: books.length,
          itemBuilder: (_, i) => ListTile(
            title: Text(books[i].title),
            subtitle: Text(books[i].authors.join(', ')),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
