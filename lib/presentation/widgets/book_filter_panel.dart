import 'package:circe/data/models/book_query_params.dart';
import 'package:circe/presentation/viewmodels/book_list_viewmodel.dart';
import 'package:circe/presentation/widgets/multi_select_dialog.dart';
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
  final Map<String, String> _languageLabels = {
    'en': 'English',
    'fr': 'French',
    'es': 'Spanish',
    'de': 'German',
    'it': 'Italian',
    'zh': 'Chinese',
    'ja': 'Japanese',
    'ru': 'Russian',
    'ar': 'Arabic',
    'pt': 'Portuguese',
    'ko': 'Korean',
  };

  String _authorYearStart = '';
  String _authorYearEnd = '';
  Set<bool> _selectedCopyrights = {};
  List<String> _selectedLanguages = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          const Center(child: Icon(Icons.drag_handle, color: Colors.grey)),
          const SizedBox(height: 12),
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
          const SizedBox(height: 4),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
            onPressed: () async {
              final List<String>? result = await showDialog<List<String>>(
                context: context,
                builder: (_) => MultiSelectDialog(
                  title: "Select Languages",
                  options: _languageLabels,
                  selected: _selectedLanguages,
                ),
              );
              if (result != null) {
                setState(() => _selectedLanguages = result);
              }
            },
            child: Text(
              _selectedLanguages.isEmpty
                  ? "Choose Languages"
                  : _selectedLanguages
                      .map((e) => _languageLabels[e])
                      .join(', '),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
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
