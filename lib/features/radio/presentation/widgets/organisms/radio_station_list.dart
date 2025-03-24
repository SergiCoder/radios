import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_stations/features/radio/presentation/presentation.dart';

/// A widget that displays a list of radio stations
class RadioStationList extends StatelessWidget {
  /// Creates a new instance of [RadioStationList]
  const RadioStationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadioPageBloc, RadioPageState>(
      builder: (context, state) {
        if (state is! RadioPageLoaded) {
          return const SizedBox.shrink();
        }

        if (state.stations.isEmpty) {
          return const Center(
            child: Text(
              'No stations found,\n maybe try to sync?',
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          );
        }

        return ListView.builder(
          itemCount: state.stations.length,
          itemBuilder: (context, index) {
            final station = state.stations[index];
            return RadioStationListItemWidget(
              station: station,
              onTap:
                  () => context.read<RadioPageBloc>().add(
                    RadioStationSelected(station),
                  ),
            );
          },
        );
      },
    );
  }
}
