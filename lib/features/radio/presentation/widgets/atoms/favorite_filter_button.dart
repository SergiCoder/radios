import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_stations/features/radio/presentation/bloc/radio_page_bloc.dart';
import 'package:radio_stations/features/radio/presentation/bloc/radio_page_events.dart';
import 'package:radio_stations/features/radio/presentation/bloc/radio_page_states.dart';

/// A simple button widget for toggling favorite filter
class FavoriteFilterButton extends StatelessWidget {
  /// Creates a new instance of [FavoriteFilterButton]
  const FavoriteFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select<RadioPageBloc, RadioPageState>(
      (bloc) => bloc.state,
    );

    if (state is! RadioPageLoaded) {
      return const SizedBox.shrink();
    }

    final showFavorites = state.selectedFilter.favorite;

    return IconButton(
      icon: Icon(
        showFavorites ? Icons.favorite : Icons.favorite_border,
        color: showFavorites ? Theme.of(context).colorScheme.primary : null,
      ),
      onPressed: () {
        context.read<RadioPageBloc>().add(const FavoritesFilterToggled());
      },
      tooltip:
          showFavorites ? 'Show Non-Favorites Only' : 'Show Favorites Only',
    );
  }
}
