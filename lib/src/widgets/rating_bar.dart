import 'package:flutter/material.dart';
import '../viewmodels/rating_vm.dart';

class Ratings extends StatefulWidget {
  const Ratings({
    Key? key,
    required this.vm,
    required this.size,
    required this.onChanged,
  }) : super(key: key);

  final double size;
  final RatingVm vm;
  final ValueChanged<int> onChanged;

  @override
  State<Ratings> createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  List<Widget> ratings(int numOfStars) {
    final List<Widget> stars = [];
    for (var i = 1; i <= 5; i++) {
      if (i <= numOfStars) {
        stars.add(
          GestureDetector(
            onTap: () {
              setState(() {
                widget.vm.starRating = i;
              });
              widget.onChanged(i);
            },
            child: Icon(
              Icons.star_rounded,
              key: Key("$i"),
              color: Colors.amber,
              size: widget.size,
            ),
          ),
        );
      } else {
        stars.add(
          GestureDetector(
            onTap: () {
              setState(() {
                widget.vm.starRating = i;
              });
              widget.onChanged(i);
            },
            child: Icon(Icons.star_rate_rounded,
                color: const Color(0xFFE5E9F2), size: widget.size),
          ),
        );
      }
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: ratings(widget.vm.starRating ?? 0),
      );
    });
  }
}
