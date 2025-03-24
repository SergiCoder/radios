import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_stations/features/radio/presentation/presentation.dart';

/// A search field widget for filtering radio stations by name
class SearchField extends StatefulWidget {
  /// Creates a new instance of [SearchField]
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _controller = TextEditingController();
  final _debounce = Debouncer(milliseconds: 500);

  @override
  void dispose() {
    _controller.dispose();
    _debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.select<RadioPageBloc, RadioPageState>(
      (bloc) => bloc.state,
    );

    if (state is! RadioPageLoaded) {
      return const SizedBox.shrink();
    }

    // Set the controller text if it doesn't match the state
    if (_controller.text != state.selectedFilter.searchTerm &&
        state.selectedFilter.searchTerm.isNotEmpty) {
      _controller.text = state.selectedFilter.searchTerm;
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Search stations...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon:
              _controller.text.isNotEmpty
                  ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                      context.read<RadioPageBloc>().add(
                        const SearchTermChanged(''),
                      );
                    },
                  )
                  : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
        ),
        onChanged: (value) {
          _debounce.run(() {
            context.read<RadioPageBloc>().add(SearchTermChanged(value));
          });
        },
      ),
    );
  }
}

/// A utility class to debounce rapid text input events
class Debouncer {
  /// Creates a new instance of [Debouncer]
  Debouncer({required this.milliseconds});

  /// The delay duration in milliseconds
  final int milliseconds;

  Timer? _timer;

  /// Run the provided callback after the debounce period
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  /// Cancel any pending callbacks
  void dispose() {
    _timer?.cancel();
  }
}
