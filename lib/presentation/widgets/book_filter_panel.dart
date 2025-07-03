import 'package:circe/data/models/book_query_params.dart';
import 'package:circe/presentation/viewmodels/book_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookFilterPanel extends ConsumerStatefulWidget {
  final VoidCallback onApplyFilters;

  const BookFilterPanel({
    super.key,
    required this.onApplyFilters,
  });

  @override
  ConsumerState<BookFilterPanel> createState() => _BookFilterPanelState();
}

class _BookFilterPanelState extends ConsumerState<BookFilterPanel> {
  final List<String> _allLanguages = ['en', 'fr', 'es', 'de', 'it'];

  String _authorYearStart = '';
  String _authorYearEnd = '';
  Set<bool> _selectedCopyrights = {};
  List<String> _selectedLanguages = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          const Center(child: Icon(Icons.drag_handle, color: Colors.grey)),
          const SizedBox(height: 8),
          const Text('Filter Books',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text('Copyright'),
          Wrap(
            spacing: 8,
            children: [true, false].map((option) {
              final label = option ? 'Yes' : 'No';
              return FilterChip(
                label: Text(label),
                selected: _selectedCopyrights.contains(option),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedCopyrights.add(option);
                    } else {
                      _selectedCopyrights.remove(option);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          const Text('Languages'),
          Wrap(
            spacing: 8,
            children: _allLanguages.map((lang) {
              final isSelected = _selectedLanguages.contains(lang);
              return FilterChip(
                label: Text(lang),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    selected
                        ? _selectedLanguages.add(lang)
                        : _selectedLanguages.remove(lang);
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.filter_alt),
            label: const Text('Apply Filters'),
            onPressed: () {
              final BookQueryParams query = BookQueryParams(
                authorYearStart: int.tryParse(_authorYearStart),
                authorYearEnd: int.tryParse(_authorYearEnd),
                copyright: _selectedCopyrights.isEmpty
                    ? null
                    : _selectedCopyrights.toList(),
                languages:
                    _selectedLanguages.isEmpty ? null : _selectedLanguages,
              );
              ref.read(bookListProvider.notifier).setQuery(query: query);
              FocusScope.of(context).unfocus();
              widget.onApplyFilters.call();
            },
          ),
        ],
      ),
    );
  }
}
