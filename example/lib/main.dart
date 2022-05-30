import 'package:flutter/material.dart' hide showDatePicker;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rate_trip/rate_trip.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Example());
}

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        //add this line
        return MediaQuery(
          //Setting font does not change with system font size
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: widget!,
        );
      },
      home: const ExampleHome(),
    );
  }
}

class ExampleHome extends StatefulWidget {
  const ExampleHome({Key? key}) : super(key: key);

  @override
  State<ExampleHome> createState() => _ExampleHomeState();
}

class _ExampleHomeState extends State<ExampleHome> {
  Trip trip = Trip(
    baseUrl: "https://api.test.shuttlers.africa/rating",
    tripId: '23',
    token:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mzg2LCJjb3Jwb3JhdGVfaWQiOjEsImZuYW1lIjoiRGFvZHUiLCJsbmFtZSI6IkFqaXQiLCJlbWFpbCI6ImRhb2R1YWppdC10ZXN0QGdtYWlsLmNvbSIsInBob25lIjoiMDkwNTIyMjI4NTYiLCJwYXNzd29yZCI6IiQyYSQxMCQyNExHN2VQRmdnRG90VGY1RXVBWS5ldHVldDk3T2UwZ2g4RTdQMHBzcGdsa2I2R0NLNU94RyIsImFjdGl2ZSI6IjEiLCJhdmF0YXIiOiJodHRwczovL3NodXR0bGVycy1hdmF0YXJzLnMzLnVzLWVhc3QtMi5hbWF6b25hd3MuY29tL3VzZXItMzg2LWJuWGJNNWdEekUuanBlZyIsImNvZGUiOiJhOWJmODQ4MC00MDY4LTExZWMtOThhYy00YmI0YTM4NDFmMDMtMzg2IiwiY3JlYXRlZF9hdCI6IjIwMTgtMDYtMDlUMTU6MjY6MTguMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTAzLTE2VDA3OjIxOjMzLjAwMFoiLCJnZW5kZXIiOiJtYWxlIiwiZG9iIjpudWxsLCJjYXJfb3duZXIiOiIwIiwibmZjX2lkIjoiMGE1Y2JiNjAtMmQ4Yy00YzM5LTg2MzktNTYxNzBlOGU3YWM1Iiwic3RhZmZfaWQiOm51bGwsImNsaWVudF9pZCI6bnVsbCwibG9jYXRpb24iOm51bGwsInZlcmlmaWVkX2F0IjpudWxsLCJjaXR5X2lkIjpudWxsLCJsb2dpbl9yZW1vdGVfYWRkcmVzcyI6IjE3Mi4yMC40Ni4yOSIsImxvZ2luX2RhdGVfdGltZSI6IjIwMjItMDMtMTZUMDA6MDA6MDAuMDAwWiIsImxvZ2luX2lzX3N1Y2Nlc3NmdWwiOjEsImJsb2NrZWRfcmVhc29uIjpudWxsLCJpc19ibG9ja2VkIjowLCJibG9ja2VkX2F0IjpudWxsLCJzaWduX3VwX3NvdXJjZSI6Imd1ZXN0X21vZGUiLCJjb3VudHJ5X2NvZGUiOiJORyIsInBob25lX3ZlcmlmaWVkX2F0IjpudWxsLCJ1c2VyVHlwZSI6bnVsbCwiaWF0IjoxNjQ3NDMzNzk0LCJleHAiOjE2Nzg5Njk3OTR9.a3AQVUcsS2FwNvFqEn5TBgggnDvl3QeDkKdQwxiYi70',
    settings: Settings(
        driverFallbackAvatar: 'assets/images/user.png',
        busAvatar: 'assets/images/bus_icon.png',
        settingId: 'fdc3f58d-ddfe-41fa-a344-873f0c56d768',
        driverAvatar:
            "https://shuttlers-avatars.s3.us-east-2.amazonaws.com/user-386-bnXbM5gDzE.jpeg",
        driverName: "Mufasa Bigson",
        vehicleName: "Toyota Coaster Bus",
        vehicleNumber: "S21",
        metadata: {
          "trip_id": "23",
          "vehicle_id": "1",
          "driver_id": "1",
        }),
    categories: [
      RatingCategory(
        name: 'Test Category 1',
        reference: '4639ca18-8702-4e09-aac5-2ab313c2f70a',
        options: [
          RatingCategoryOptions(
              name: 'Cat 1 Option 1',
              ratingCategoryReference: '4639ca18-8702-4e09-aac5-2ab313c2f70a',
              reference: '58f44845-cec2-4971-a254-2ba867ef73b0'),
          RatingCategoryOptions(
              name: 'Cat 1 Option 2',
              ratingCategoryReference: '4639ca18-8702-4e09-aac5-2ab313c2f70a',
              reference: 'aa85e53c-7f2b-4474-9557-b8da41d52643'),
          RatingCategoryOptions(
              name: 'Cat 1 Option 3',
              ratingCategoryReference: '4639ca18-8702-4e09-aac5-2ab313c2f70a',
              reference: 'c9ba73d4-a8b9-4105-97bd-b098b4f533a4'),
        ],
      ),
      RatingCategory(
        name: 'Test Category',
        reference: '485c76f4-adf5-4d77-be46-b5b9efa2cf0d',
        options: [
          RatingCategoryOptions(
              name: 'Cat Option 1',
              ratingCategoryReference: '485c76f4-adf5-4d77-be46-b5b9efa2cf0d',
              reference: '5699045a-b799-4a7e-aecd-bb7929eed638'),
          RatingCategoryOptions(
              name: 'Cat Option 2',
              ratingCategoryReference: '485c76f4-adf5-4d77-be46-b5b9efa2cf0d',
              reference: '955eb9d7-8788-432a-9bea-8c50d582da6b'),
          RatingCategoryOptions(
              name: 'Cat Option 3',
              ratingCategoryReference: '485c76f4-adf5-4d77-be46-b5b9efa2cf0d',
              reference: '9ca1a8e1-f353-4514-a167-64d2057d4c56'),
        ],
      ),
      RatingCategory(
        name: 'Test Category 2',
        reference: 'f7b92bba-9e27-4957-a34a-1fb0aec62609',
        options: [
          RatingCategoryOptions(
              name: 'Cat 2 Option 2',
              ratingCategoryReference: 'f7b92bba-9e27-4957-a34a-1fb0aec62609',
              reference: '0ed9b653-11ee-446e-942e-57cca24414ed'),
          RatingCategoryOptions(
              name: 'Cat 2 Option 3',
              ratingCategoryReference: 'f7b92bba-9e27-4957-a34a-1fb0aec62609',
              reference: '30888d7e-8a35-472f-8999-9b6b88b508d6'),
          RatingCategoryOptions(
              name: 'Cat 2 Option 1',
              ratingCategoryReference: 'f7b92bba-9e27-4957-a34a-1fb0aec62609',
              reference: '6492acbc-6b5f-4fa8-b16b-195446f8a5a4'),
        ],
      ),
    ],
    serviceSettings: ServiceSettings(
      createdAt: DateTime.now().toIso8601String(),
      incrementsBy: 1,
      maxValue: 5,
      minValue: 1,
      threshold: 3,
      name: 'some settings',
      reference: 'some-settings-reference',
      serviceId: 'trip_rating_service',
      parameters: 'some parameters',
    ),
  );

  _handleRateApp() async {
    final RatingService ratingService = RatingService(
      context: context,
      trip: trip,
    );
    await ratingService.rate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                key: const Key('rate'),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.green, primary: Colors.white),
                onPressed: _handleRateApp,
                child: const Text('Rate Us'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
