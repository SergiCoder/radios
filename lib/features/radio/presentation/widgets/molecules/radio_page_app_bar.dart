import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_stations/features/radio/presentation/bloc/bloc.dart';

/// A widget that displays the app bar for the radio page
class RadioPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a new instance of [RadioPageAppBar]
  const RadioPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.select<RadioPageBloc, RadioPageState>(
      (bloc) => bloc.state,
    );

    final isLoaded = state is RadioPageLoaded;
    final isSyncing = state is RadioPageSyncProgress;
    final stationCount = isLoaded ? state.stations.length : 0;

    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      scrolledUnderElevation: 0,
      title:
          isSyncing
              ? const Text('Radio Stations')
              : isLoaded
              ? Text('Radio Stations: $stationCount listed')
              : const Text('Radio Stations'),
      actions: [
        if (isLoaded)
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              context.read<RadioPageBloc>().add(
                const RadioStationsRequested(forceSync: true),
              );
            },
            tooltip: 'Sync stations',
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
