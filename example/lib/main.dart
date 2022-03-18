import 'package:flutter/material.dart';
import 'package:rate_trip/rate_trip.dart';

void main() {
  runApp(const Example());
}

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExampleHome(),
    );
  }
}

class ExampleHome extends StatelessWidget {
  const ExampleHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Trip trip = Trip();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.green, primary: Colors.white),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) {
                        return RateTrip(trip: trip);
                      },
                      fullscreenDialog: true,
                    ),
                  ),
              child: const Text('Rate Us')),
        ),
      ),
    );
  }
}
