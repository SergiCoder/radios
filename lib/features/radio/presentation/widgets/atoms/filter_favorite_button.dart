import 'package:flutter/material.dart';
import 'package:radio_stations/core/design_system/theme/app_sizes.dart';
import 'package:radio_stations/core/utils/input_utils.dart';

/// A simple button widget for toggling favorite filter
class FilterFavoriteButton extends StatelessWidget {
  /// Creates a new instance of [FilterFavoriteButton]
  ///
  /// [showFavorites] indicates whether the favorites filter is active
  /// [onToggled] is called when the button is toggled
  const FilterFavoriteButton({
    required this.showFavorites,
    required this.onToggled,
    super.key,
  });

  /// Whether favorites filter is currently active
  final bool showFavorites;

  /// Callback when the button is toggled
  final VoidCallback onToggled;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        showFavorites ? Icons.favorite : Icons.favorite_border,
        color: showFavorites ? Theme.of(context).colorScheme.primary : null,
        size: AppSizes.iconMedium,
      ),
      onPressed: () {
        // Unfocus before toggling filter
        InputUtils.unfocusAndThen(context, onToggled);
      },
      tooltip:
          showFavorites ? 'Show Non-Favorites Only' : 'Show Favorites Only',
    );
  }
}
