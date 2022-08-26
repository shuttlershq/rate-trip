import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rate_trip/src/utils/extensions.dart';
import 'package:rate_trip/src/views/issue_view.dart';
import '../model/model.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../viewmodels/rating_vm.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/btns.dart';
import '../widgets/details_tile.dart';
import '../widgets/rating_bar.dart';

import 'base_view.dart';

class RateTrip extends StatelessWidget {
  final Trip trip;

  const RateTrip({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Util.offKeyboard(context),
      child: BaseView<RatingVm>(
        model: RatingVm(trip: trip),
        onModelReady: (model) async {
          model.trip = trip;
          trip.categories?.forEach((element) {
            element.options?.forEach((element) {
              model.options.add(element);
            });
          });
        },
        builder: (context, model, _) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'Skip',
                      style: GoogleFonts.heebo(
                        color: black,
                        fontWeight: FontWeight.w500,
                        height: 24 / 16,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        MediaQuery.of(context).padding.top,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 40, left: 20, right: 20),
                            child: Column(
                              children: [
                                DetailsTile(widget: this),
                                const SizedBox(height: 32),
                                Text(
                                  "How was your trip?",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.heebo(
                                      fontSize: 24,
                                      color: black,
                                      height: 32 / 24,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: 293,
                                  child: Text(
                                    'Your feedback will help us improve your experience.',
                                    style: GoogleFonts.heebo(
                                        fontSize: 14,
                                        height: 20 / 14,
                                        color: grey5,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 36),
                                Ratings(
                                  vm: model,
                                  size: 60,
                                  onChanged: (newValue) {
                                    if (newValue >=
                                        (model.trip.serviceSettings
                                                ?.threshold ??
                                            4)) {
                                      model.clearIssues();
                                    }
                                    model.starRating = newValue;
                                  },
                                ),
                                if ((model.starRating ?? 0) >= 1)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      (model.starRating ?? 0).name(),
                                      style: GoogleFonts.heebo(
                                          fontSize: 13,
                                          height: 20 / 13,
                                          color: const Color(0xFF575A65),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: MediaQuery.of(context).size.height * 0.65,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            blurStyle: BlurStyle.outer,
                            color: const Color(0xFF5E5E5E).withOpacity(0.2),
                            offset: const Offset(0, -1),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              textInputAction: TextInputAction.done,
                              onChanged: (v) {
                                model.comment = v;
                              },
                              maxLines: 2,
                              style: GoogleFonts.heebo(
                                color: black,
                                fontSize: 14,
                                height: 20 / 14,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(16),
                                hintText: "Leave a comment (Optional)",
                                hintStyle: GoogleFonts.heebo(
                                  fontSize: 15,
                                  height: 24 / 15,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF8D918F),
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF4F5F4),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFFF4F5F4), width: 2.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFFF4F5F4), width: 2.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFFF4F5F4), width: 2.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            AppButtonAction(
                              loading: model.state == RatingState.loading,
                              label:
                                  (model.canPickIssues()) ? 'Continue' : 'Done',
                              onPressed: (model.state == RatingState.loading ||
                                      (!model.canPickIssues() &&
                                          !model.canSend()))
                                  ? null
                                  : model.canPickIssues()
                                      ? () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    IssueView(model: model)),
                                          )
                                      : () async {
                                          await model.rateTrip();
                                          if (model.state ==
                                              RatingState.loaded) {
                                            CustomBottomSheet.showBottomSheet(
                                                context,
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      const BottomSheetHandle(),
                                                      const SizedBox(
                                                          height: 24),
                                                      Text(
                                                        "Thanks for your feedback 👍🏽",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.heebo(
                                                          fontSize: 18,
                                                          height: 24 / 18,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 12),
                                                      Text(
                                                        model.starRating! >
                                                                (model
                                                                        .trip
                                                                        .serviceSettings
                                                                        ?.threshold ??
                                                                    3)
                                                            ? "We are glad you had a pleasant experience. Your feedback will help us improve our service. Thank you for riding with Shuttlers."
                                                            : "We are really sorry you had an unpleasant experience. Your feedback will help us improve our service. Thank you for riding with Shuttlers.",
                                                        style:
                                                            GoogleFonts.heebo(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 15,
                                                          height: 24 / 15,
                                                          color: grey5,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      const SizedBox(
                                                          height: 32),
                                                      AppButtonAction(
                                                        label: 'Close',
                                                        onPressed: () =>
                                                            Navigator.popUntil(
                                                                context,
                                                                (route) => route
                                                                    .isFirst),
                                                      ),
                                                      const SizedBox(
                                                          height: 40),
                                                    ],
                                                  ),
                                                ),
                                                heightfactor: 0.43596);
                                          }

                                          if (model.state ==
                                              RatingState.error) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(model.error ??
                                                    "Could not rate trip"),
                                                backgroundColor: Colors.red,
                                                duration:
                                                    const Duration(seconds: 3),
                                              ),
                                            );
                                          }
                                        },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
