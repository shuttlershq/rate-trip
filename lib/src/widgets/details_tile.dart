import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../rate_trip.dart';
import '../utils/colors.dart';

class DetailsTile extends StatelessWidget {
  const DetailsTile({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final RateTrip widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 56,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: CachedNetworkImage(
                  imageUrl: widget.trip.settings.userAvatar ?? '',
                  imageBuilder: (context, imageProvider) => Container(
                    width: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: 28,
                    backgroundColor: const Color(0xFFEDFDF5),
                    child: Image(
                      image:
                          AssetImage(widget.trip.settings.userFallbackAvatar),
                      width: 20,
                      height: 24,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: -30,
                child: Image(
                  image: AssetImage(widget.trip.settings.busAvatar),
                  width: 22,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          widget.trip.settings.driverName!,
          style: GoogleFonts.heebo(
            fontSize: 18,
            height: 24 / 18,
            color: black,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.02,
          ),
        ),
        const SizedBox(height: 6),
        Table(
          children: [
            TableRow(children: [
              Text(
                'Vehicle Type',
                style: GoogleFonts.heebo(
                  fontSize: 13,
                  height: 20 / 13,
                  color: neutral600,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Plate Number',
                style: GoogleFonts.heebo(
                  fontSize: 13,
                  height: 20 / 13,
                  color: neutral600,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Route Code',
                style: GoogleFonts.heebo(
                  fontSize: 13,
                  height: 20 / 13,
                  color: neutral600,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ]),
            TableRow(children: [
              Text(
                widget.trip.settings.vehicleName ?? 'N/A',
                style: GoogleFonts.heebo(
                  fontSize: 15,
                  height: 24 / 15,
                  color: black,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.trip.settings.vehicleNumber ?? 'N/A',
                style: GoogleFonts.heebo(
                  fontSize: 15,
                  height: 24 / 15,
                  color: black,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.trip.settings.routeCode ?? 'N/A',
                style: GoogleFonts.heebo(
                  fontSize: 15,
                  height: 24 / 15,
                  color: black,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ])
          ],
        ),
        const SizedBox(height: 20),
        const Divider(height: 1, color: Color(0xFFC6C8C7))
      ],
    );
  }
}
