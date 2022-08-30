import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rate_trip/src/model/model.dart';

import '../utils/colors.dart';
import '../utils/utils.dart';
import '../viewmodels/rating_vm.dart';
import '../widgets/btns.dart';
import '../widgets/widgets.dart';
import 'base_view.dart';

class IssueView extends StatefulWidget {
  const IssueView({Key? key, required this.model}) : super(key: key);

  final RatingVm model;

  @override
  State<IssueView> createState() => _IssueViewState();
}

class _IssueViewState extends State<IssueView> {
  @override
  void initState() {
    widget.model.addListener(() {
      if (mounted) setState(() {});
    });

    super.initState();
  }

  Widget serviceschip(RatingCategoryOptions option, RatingVm model) {
    return GestureDetector(
      onTap: () {
        model.addIssues(option);
      },
      child: Chip(
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            side: model.issues.containsKey(option.reference)
                ? BorderSide.none
                : const BorderSide(color: neutral300)),
        label: Text(
          option.name!,
          style: GoogleFonts.heebo(
            color: model.issues.containsKey(option.reference)
                ? neutral900
                : const Color(0xFF595E5C),
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 20 / 14,
          ),
        ),
        backgroundColor: model.issues.containsKey(option.reference)
            ? const Color(0xFF5CF2A6)
            : Colors.white,
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
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: const Color(0xFFFFFFFF),
          leading: BackButton(
            color: const Color(0xFF000000),
            onPressed: () => Navigator.pop(context, widget.model),
          ),
          title: Text(
            'Select an issue',
            style: GoogleFonts.heebo(
              color: neutral900,
              fontSize: 17,
              height: 24 / 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height -
                    kToolbarHeight -
                    MediaQuery.of(context).padding.top,
                child: SingleChildScrollView(
                  child: BaseView<RatingVm>(
                    model: widget.model,
                    builder: (context, model, _) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 32),
                            Text(
                              'You can choose up to ${model.trip.serviceSettings.maxValue ?? 5} issues across all categories.',
                              style: GoogleFonts.heebo(
                                  fontSize: 17,
                                  height: 24 / 17,
                                  color: const Color(0xFF575A65),
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 40),
                            ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: model.trip.categories.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    leading: Image(
                                      image: AssetImage(
                                          model.trip.settings.busAvatar),
                                      width: 20,
                                    ),
                                    tilePadding: EdgeInsets.zero,
                                    iconColor: const Color(0xFF444854),
                                    collapsedIconColor: const Color(0xFF444854),
                                    textColor: Colors.black,
                                    title: Text(
                                      model.trip.categories[index].name!,
                                      style: GoogleFonts.heebo(
                                        color: black,
                                        fontSize: 18,
                                        height: 28 / 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    expandedCrossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    expandedAlignment: Alignment.topLeft,
                                    children: [
                                      Text(
                                        'What went wrong?',
                                        style: GoogleFonts.heebo(
                                          color: neutral600,
                                          fontSize: 13,
                                          height: 20 / 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      wrapServicesWidget(
                                          model.options
                                              .where((element) =>
                                                  element
                                                      .ratingCategoryReference ==
                                                  model.trip.categories[index]
                                                      .reference)
                                              .toList(),
                                          model),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 40),
                            if (model.issues.isNotEmpty)
                              Text(
                                'Selected issues:',
                                style: GoogleFonts.heebo(
                                    fontSize: 14,
                                    height: 20 / 14,
                                    color: neutral700,
                                    fontWeight: FontWeight.w500),
                              ),
                            IgnorePointer(
                              child: Wrap(
                                spacing: 4.0,
                                runSpacing: 4.0,
                                children: [
                                  ...model.issues.values
                                      .map((e) => serviceschip(e, model))
                                ],
                                alignment: WrapAlignment.center,
                              ),
                            ),
                            const SizedBox(height: 300),
                          ],
                        ),
                      );
                    },
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
                      children: [
                        TextField(
                          textInputAction: TextInputAction.done,
                          controller: widget.model.commentField,
                          onChanged: (v) {
                            widget.model.comment = v;
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
                          loading: widget.model.state == RatingState.loading,
                          label: 'Send',
                          onPressed: (widget.model.state ==
                                      RatingState.loading ||
                                  (!widget.model.canSend()))
                              ? null
                              : () async {
                                  await widget.model.rateTrip();
                                  if (widget.model.state ==
                                      RatingState.loaded) {
                                    CustomBottomSheet.showBottomSheet(
                                        context,
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              const BottomSheetHandle(),
                                              const SizedBox(height: 24),
                                              Text(
                                                "Thanks for your feedback 👍🏽",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.heebo(
                                                  fontSize: 18,
                                                  height: 24 / 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Text(
                                                widget.model.starRating! >
                                                        (widget
                                                                .model
                                                                .trip
                                                                .serviceSettings
                                                                .threshold ??
                                                            3)
                                                    ? "We are glad you had a pleasant experience. Your feedback will help us improve our service. Thank you for riding with Shuttlers."
                                                    : "We are really sorry you had an unpleasant experience. Your feedback will help us improve our service. Thank you for riding with Shuttlers.",
                                                style: GoogleFonts.heebo(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                  height: 24 / 15,
                                                  color: grey5,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 32),
                                              AppButtonAction(
                                                label: 'Close',
                                                onPressed: () =>
                                                    Navigator.popUntil(
                                                        context,
                                                        (route) =>
                                                            route.isFirst),
                                              ),
                                              const SizedBox(height: 40),
                                            ],
                                          ),
                                        ),
                                        heightfactor: 0.43596);
                                  }

                                  if (widget.model.state == RatingState.error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(widget.model.error ??
                                            "Could not rate trip"),
                                        backgroundColor: Colors.red,
                                        duration: const Duration(seconds: 3),
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
      ),
    );
  }
}
