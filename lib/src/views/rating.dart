import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/model.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../viewmodels/rating_vm.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/rating_bar.dart';
import '../widgets/separator.dart';

import 'base_view.dart';

class RateTrip extends StatelessWidget {
  final Trip trip;

  const RateTrip({Key? key, required this.trip}) : super(key: key);

  Widget serviceschip(RatingCategoryOptions option, RatingVm model) {
    return GestureDetector(
      onTap: () {
        model.addIssues(option);
      },
      child: Chip(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        label: Text(
          option.name!,
          style: GoogleFonts.heebo(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            height: 18 / 12,
          ),
        ),
        backgroundColor:
            model.issues.containsKey(option.reference) ? lightGreen : grey,
      ),
    );
  }

  Widget wrapServicesWidget(List<RatingCategoryOptions>? list, RatingVm model) {
    List<Widget> cs = [];
    if (list == null) return Container();
    for (int i = 0; i < list.length; i++) {
      cs.add(serviceschip(list[i], model));
    }
    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: cs,
      alignment: WrapAlignment.center,
    );
  }

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
              bottomNavigationBar: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, 0, 20, MediaQuery.of(context).padding.bottom),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor:
                        model.canSend() ? btnGreen : const Color(0xFFC7D1CC),
                    primary: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: GoogleFonts.heebo(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                    elevation: 0.0,
                  ),
                  onPressed: (!model.canSend() ||
                          model.state == RatingState.loading)
                      ? null
                      : () async {
                          await model.rateTrip();
                          if (model.state == RatingState.loaded) {
                            CustomBottomSheet.showBottomSheet(
                                context,
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    children: [
                                      const BottomSheetHandle(),
                                      const SizedBox(height: 44),
                                      DetailsTile(widget: this),
                                      const SizedBox(height: 25),
                                      Text(
                                        "Thanks for your feedback",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.heebo(
                                          fontSize: 18,
                                          height: 24 / 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        model.starRating! >
                                                (model.trip.serviceSettings
                                                        ?.threshold ??
                                                    3)
                                            ? "We are glad you had a pleasant experience. Your feedback will help us improve our service. Thank you for riding with Shuttlers."
                                            : "We are really sorry you had an unpleasant experience. Your feedback will help us improve our service. Thank you for riding with Shuttlers.",
                                        style: GoogleFonts.heebo(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          height: 24 / 14,
                                          color: grey5,
                                        ),
                                      ),
                                      const SizedBox(height: 36),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: btnGreen,
                                              primary: Colors.black,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              textStyle: GoogleFonts.heebo(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                              ),
                                              elevation: 0.0,
                                            ),
                                            onPressed: () => Navigator.popUntil(
                                                context,
                                                (route) => route.isFirst),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.0),
                                              child: Text('Close'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                    ],
                                  ),
                                ),
                                heightfactor: 0.43596);
                          }

                          if (model.state == RatingState.error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text(model.error ?? "Could not rate trip"),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          }
                        },
                  child: model.state == RatingState.loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      : Text(
                          'Send',
                          style: GoogleFonts.heebo(
                            fontSize: 16,
                            height: 24 / 16,
                            color: (!model.canSend() ||
                                    model.state == RatingState.loading)
                                ? Colors.white
                                : black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 40, left: 20, right: 20),
                  child: Column(
                    children: [
                      Text(
                        "Thank You!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.heebo(
                          fontSize: 18,
                          height: 24 / 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      DetailsTile(widget: this),
                      const SizedBox(height: 41),
                      Text(
                        "How was your trip?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.heebo(
                            fontSize: 18,
                            color: black,
                            height: 24 / 18,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 249,
                        child: Text(
                          'Your feedback will help us improve your experience.',
                          style: GoogleFonts.heebo(
                              fontSize: 14,
                              height: 21 / 18,
                              color: grey5,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Ratings(
                        vm: model,
                        size: 50,
                        onChanged: (newValue) {
                          if (newValue >=
                              (model.trip.serviceSettings?.threshold ?? 4)) {
                            model.clearIssues();
                          }
                          model.starRating = newValue;
                        },
                      ),
                      if (model.starRating != null)
                        Column(
                          children: [
                            if (model.starRating! <=
                                (model.trip.serviceSettings?.threshold ?? 3))
                              const SizedBox(height: 28),
                            if (model.starRating! <=
                                (model.trip.serviceSettings?.threshold ?? 3))
                              Text(
                                "Please select an Issue",
                                style: GoogleFonts.heebo(
                                  fontSize: 14,
                                  height: 21 / 14,
                                  color: grey3,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            if (model.starRating! <=
                                (model.trip.serviceSettings?.threshold ?? 3))
                              const SizedBox(height: 4),
                            if (model.starRating! <=
                                (model.trip.serviceSettings?.threshold ?? 3))
                              Text(
                                "Please note that you can choose a maximum of ${model.trip.serviceSettings?.maxValue ?? 5} issues",
                                style: GoogleFonts.heebo(
                                  fontSize: 12,
                                  height: 21 / 12,
                                  color: grey3,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            if (model.starRating! <=
                                (model.trip.serviceSettings?.threshold ?? 3))
                              const SizedBox(height: 8),
                            if (model.starRating! <=
                                (model.trip.serviceSettings?.threshold ?? 3))
                              wrapServicesWidget(
                                  model.options.sublist(
                                      0,
                                      model.options.length > 5
                                          ? 5
                                          : model.options.length),
                                  model),
                            if (model.starRating! <=
                                (model.trip.serviceSettings?.threshold ?? 3))
                              const SizedBox(height: 18),
                            if (model.starRating! <=
                                (model.trip.serviceSettings?.threshold ?? 3))
                              InkWell(
                                  onTap: () {
                                    CustomBottomSheet.showBottomSheet(
                                        context,
                                        BaseView<RatingVm>(
                                            model: model,
                                            builder: (context, model, _) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                child: Column(
                                                  children: [
                                                    const BottomSheetHandle(),
                                                    const SizedBox(height: 32),
                                                    Text(
                                                      'Your rating',
                                                      style: GoogleFonts.heebo(
                                                          fontSize: 14,
                                                          height: 21 / 18,
                                                          color: grey5,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Ratings(
                                                      vm: model,
                                                      size: 50,
                                                      onChanged: (newValue) {},
                                                    ),
                                                    const Divider(),
                                                    ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount: trip
                                                          .categories?.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Theme(
                                                          data: Theme.of(
                                                                  context)
                                                              .copyWith(
                                                                  dividerColor:
                                                                      Colors
                                                                          .transparent),
                                                          child: ExpansionTile(
                                                            textColor:
                                                                Colors.black,
                                                            title: Text(
                                                              trip
                                                                  .categories![
                                                                      index]
                                                                  .name!,
                                                              style: GoogleFonts
                                                                  .heebo(
                                                                color: black,
                                                                fontSize: 16,
                                                                height: 28 / 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                            children: [
                                                              wrapServicesWidget(
                                                                  model.options
                                                                      .where((element) =>
                                                                          element
                                                                              .ratingCategoryReference ==
                                                                          trip.categories![index]
                                                                              .reference)
                                                                      .toList(),
                                                                  model),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    const SizedBox(height: 151),
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: SizedBox(
                                                        width: double.infinity,
                                                        child: TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                btnGreen,
                                                            primary:
                                                                Colors.black,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        16),
                                                            textStyle:
                                                                GoogleFonts
                                                                    .heebo(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                            ),
                                                            elevation: 0.0,
                                                          ),
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: Text(
                                                            'Done',
                                                            style: GoogleFonts.heebo(
                                                                fontSize: 16,
                                                                height: 24 / 16,
                                                                color:
                                                                    neutral900,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 40),
                                                  ],
                                                ),
                                              );
                                            }));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "View more issues",
                                        style: GoogleFonts.heebo(
                                          color: darkGreen,
                                          fontSize: 13,
                                          height: 21 / 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: darkGreen,
                                        size: 11,
                                      )
                                    ],
                                  )),
                          ],
                        ),
                      const SizedBox(height: 36),
                      TextField(
                        onChanged: (v) {
                          model.comment = v;
                        },
                        style: GoogleFonts.heebo(
                          color: black,
                          fontSize: 14,
                          height: 20 / 14,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(16),
                          hintText: "Enter message here",
                          hintStyle: GoogleFonts.heebo(
                            fontSize: 12,
                            height: 20 / 12,
                            fontWeight: FontWeight.w500,
                            color: grey6,
                          ),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFE5E9F2), width: 2.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFE5E9F2), width: 2.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFE5E9F2), width: 2.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        maxLines: 5,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              try {
                                var result = await model.getFileGallery(
                                    context: context);
                                if (!result) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Uploaded file should be less than 5mb'),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(model.error ?? e.toString()),
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 3),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFE5E9F2).withOpacity(0.62),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                              ),
                              height: 32,
                              width: 32,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.camera_alt,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Upload supporting media (picture)',
                                style: GoogleFonts.heebo(
                                  color: grey5,
                                  fontSize: 13,
                                  height: 21 / 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Max. of 5 MB',
                                style: GoogleFonts.heebo(
                                  color: grey5.withOpacity(0.62),
                                  fontSize: 11,
                                  height: 18 / 11,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (model.images.isNotEmpty)
                        Column(
                          children: [
                            const SizedBox(height: 16),
                            const LineSeparator(color: Color(0xFFE5E9F2)),
                            const SizedBox(height: 22),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: model.images.length,
                              itemBuilder: (BuildContext context, int index) {
                                final file = model.images[index];
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(Icons.image_rounded),
                                  trailing: GestureDetector(
                                    onTap: () => model.deleteImage(file),
                                    child: const Icon(
                                      Icons.close_rounded,
                                      color: Colors.red,
                                    ),
                                  ),
                                  title: Text(
                                    file.path.split('/').last,
                                    style: GoogleFonts.heebo(
                                      color: grey5,
                                      fontSize: 13,
                                      height: 21 / 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class DetailsTile extends StatelessWidget {
  const DetailsTile({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final RateTrip widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 65,
          height: 40,
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFFEDFDF5),
                  child: Image(
                    image: AssetImage(widget.trip.settings!.busAvatar!),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: CachedNetworkImage(
                  imageUrl: widget.trip.settings?.driverAvatar ?? '',
                  imageBuilder: (context, imageProvider) => Container(
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[200]!),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color(0xFFEDFDF5),
                    child: Image(
                      image: AssetImage(
                          widget.trip.settings?.driverFallbackAvatar ?? ''),
                      width: 14,
                      height: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 11),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.trip.settings!.driverName!,
              style: GoogleFonts.heebo(
                fontSize: 12,
                height: 20 / 12,
                color: black,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '${widget.trip.settings?.vehicleName ?? ''} • ${widget.trip.settings?.vehicleNumber ?? ''}',
              style: GoogleFonts.heebo(
                fontSize: 10,
                color: grey5,
                height: 18 / 10,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        )
      ],
    );
  }
}

class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 48,
        height: 4,
        margin: const EdgeInsets.only(top: 8),
        decoration: const BoxDecoration(
          color: Color(0xFFEFF2F7),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }
}
