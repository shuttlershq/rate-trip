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
    Trip trip = Trip(
        settings: Settings(
          driverAvatar: "assets/images/bus_icon.png",
          driverName: "Mufasa Bigson",
          userAvatar: "assets/images/user_icon.png",
          vehicleName: "Toyota Coaster Bus",
          vehicleNumber: "S21",
        ),
        categories: [
          RatingCategory(
            name: 'Driver',
            reference: '1',
            options: [
              RatingCategoryOptions(
                  name: 'Rude Driver',
                  ratingCategoryReference: '1',
                  reference: '1'),
              RatingCategoryOptions(
                  name: 'Over speeding',
                  ratingCategoryReference: '1',
                  reference: '4'),
              RatingCategoryOptions(
                  name: 'Inexperienced',
                  ratingCategoryReference: '1',
                  reference: '7'),
            ],
          ),
          RatingCategory(
            name: 'Vehicle',
            reference: '2',
            options: [
              RatingCategoryOptions(
                  name: 'Bad AC', ratingCategoryReference: '2', reference: '2'),
              RatingCategoryOptions(
                  name: 'Capacity issues',
                  ratingCategoryReference: '2',
                  reference: '5'),
              RatingCategoryOptions(
                  name: 'Dirty', ratingCategoryReference: '2', reference: '8'),
            ],
          ),
          RatingCategory(
            name: 'Marshals',
            reference: '3',
            options: [
              RatingCategoryOptions(
                  name: 'Poor communication',
                  ratingCategoryReference: '3',
                  reference: '3'),
              RatingCategoryOptions(
                  name: 'Abussive',
                  ratingCategoryReference: '3',
                  reference: '6'),
              RatingCategoryOptions(
                  name: 'Unfriendly',
                  ratingCategoryReference: '3',
                  reference: '9'),
            ],
          ),
        ]);
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
