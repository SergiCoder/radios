import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_stations/features/radio/domain/entities/radio_station.dart';
import 'package:radio_stations/features/radio/presentation/cubit/radio_page_cubit.dart';

/// A widget that displays a radio station in a list
class RadioStationListItemWidget extends StatelessWidget {
  /// Creates a new instance of [RadioStationListItemWidget]
  const RadioStationListItemWidget({
    required this.station,
    required this.onTap,
    super.key,
  });

  /// The radio station to display
  final RadioStation station;

  /// Callback when the item is tapped
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 24,
        height: 24,
        child:
            station.favicon.isNotEmpty
                ? Image.network(
                  station.favicon,
                  errorBuilder:
                      (context, error, stackTrace) => const Icon(Icons.radio),
                )
                : const Icon(Icons.radio),
      ),
      title: Text(
        station.name,
        style: Theme.of(context).textTheme.titleMedium,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (station.broken)
            const Icon(Icons.error_outline, color: Colors.orange),
          IconButton(
            icon:
                (station.isFavorite)
                    ? Icon(
                      Icons.favorite,
                      color: Theme.of(context).colorScheme.primary,
                    )
                    : const Icon(Icons.favorite_border),
            onPressed:
                () => context.read<RadioPageCubit>().toggleStationFavorite(
                  station,
                ),
          ),
        ],
      ),
      onTap: () {
        dev.log('Selected station: $station');
        onTap();
      },
    );
  }
}
