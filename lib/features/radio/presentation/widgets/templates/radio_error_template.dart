import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_stations/features/radio/presentation/cubit/radio_page_cubit.dart';

/// A template widget for displaying the error state
class RadioErrorTemplate extends StatelessWidget {
  /// Creates a new instance of [RadioErrorTemplate]
  const RadioErrorTemplate({required this.errorMessage, super.key});

  /// The error message to display
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error: $errorMessage',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<RadioPageCubit>().loadStations();
            },
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}
