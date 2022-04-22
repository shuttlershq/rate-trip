import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/model.dart';
import '../utils/colors.dart';
import '../utils/size_manager.dart';
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
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: SizeMg.text(12),
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
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(375, 812),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return GestureDetector(
      onTap: () => Util.offKeyboard(context),
      child: BaseView<RatingVm>(
          model: RatingVm(token: trip.token),
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
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                automaticallyImplyLeading: false,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: SizeMg.width(20)),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeMg.text(16)),
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeMg.width(20)),
                  child: SizedBox(
                    width: double.infinity,
                    height: SizeMg.height(40),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: model.canSend()
                              ? btnGreen
                              : const Color(0xFFC7D1CC),
                          primary: Colors.white),
                      onPressed: (!model.canSend() ||
                              model.state == RatingState.loading)
                          ? null
                          : () async {
                              await model.rateTrip();
                              if (model.state == RatingState.loaded) {
                                CustomBottomSheet.showBottomSheet(
                                    context,
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: SizeMg.width(20)),
                                      child: Column(
                                        children: [
                                          const BottomSheetHandle(),
                                          SizedBox(height: SizeMg.height(44)),
                                          DetailsTile(widget: this),
                                          SizedBox(height: SizeMg.height(25)),
                                          Text(
                                            "Thanks for your feedback",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: SizeMg.text(18),
                                                fontWeight: FontWeight.w700),
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            "Your feedback will help us improve our service.\nThank you for riding with Shuttlers.",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: SizeMg.text(14),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: SizeMg.height(36)),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                    backgroundColor: btnGreen,
                                                    primary: Colors.white),
                                                onPressed: () =>
                                                    Navigator.popUntil(
                                                        context,
                                                        (route) =>
                                                            route.isFirst),
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
                                    content: Text(
                                        model.error ?? "Could not rate trip"),
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 3),
                                  ),
                                );
                              }
                            },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: model.state == RatingState.loading
                            ? SizedBox(
                                width: SizeMg.width(20),
                                height: double.infinity,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Send',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: SizeMg.height(40),
                        left: SizeMg.width(20),
                        right: SizeMg.width(20)),
                    child: Column(
                      children: [
                        const Text(
                          "Thank You!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        DetailsTile(widget: this),
                        const SizedBox(height: 41),
                        const Text(
                          "How was your trip?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                            'Your feedback will help us improve your experience.',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center),
                        const SizedBox(height: 20),
                        Ratings(
                          vm: model,
                          size: SizeMg.width(50),
                          onChanged: (newValue) {
                            if (newValue > 3) {
                              model.clearIssues();
                            }
                            model.starRating = newValue;
                          },
                        ),
                        if (model.starRating <= 3) const SizedBox(height: 28),
                        if (model.starRating <= 3)
                          const Text(
                            "Please select an Issue",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        if (model.starRating <= 3) const SizedBox(height: 4),
                        if (model.starRating <= 3)
                          const Text(
                            "please choose Up to 5 Issue",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        if (model.starRating <= 3) const SizedBox(height: 8),
                        if (model.starRating <= 3)
                          wrapServicesWidget(
                              model.options.sublist(
                                  0,
                                  model.options.length > 5
                                      ? 5
                                      : model.options.length),
                              model),
                        if (model.starRating <= 3) const SizedBox(height: 18),
                        if (model.starRating <= 3)
                          InkWell(
                              onTap: () {
                                CustomBottomSheet.showBottomSheet(
                                    context,
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Column(
                                        children: [
                                          const BottomSheetHandle(),
                                          SizedBox(height: SizeMg.height(32)),
                                          const Text('Your rating'),
                                          Ratings(
                                            vm: model,
                                            size: SizeMg.width(50),
                                            onChanged: (newValue) {
                                              // setState(() {});
                                            },
                                          ),
                                          const Divider(),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: trip.categories?.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Theme(
                                                data: Theme.of(context)
                                                    .copyWith(
                                                        dividerColor:
                                                            Colors.transparent),
                                                child: ExpansionTile(
                                                  textColor: Colors.black,
                                                  leading:
                                                      const Icon(Icons.circle),
                                                  title: Text(
                                                    trip.categories![index]
                                                        .name!,
                                                    style: TextStyle(
                                                      fontSize: SizeMg.text(16),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  children: [
                                                    wrapServicesWidget(
                                                        model.options
                                                            .where((element) =>
                                                                element
                                                                    .ratingCategoryReference ==
                                                                trip
                                                                    .categories![
                                                                        index]
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
                                            alignment: Alignment.bottomCenter,
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                    backgroundColor: btnGreen,
                                                    primary: Colors.white),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                                  child: Text('Done'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 40),
                                        ],
                                      ),
                                    ));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "View more issues",
                                    style: TextStyle(
                                        color: darkGreen,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: darkGreen,
                                    size: 11,
                                  )
                                ],
                              )),
                        const SizedBox(height: 36),
                        TextField(
                          onChanged: (v) {
                            model.comment = v;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter message here",
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
                                            'Uploaded file should be less than 2mb'),
                                        backgroundColor: Colors.red,
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(model.error!),
                                      backgroundColor: Colors.red,
                                      duration: const Duration(seconds: 3),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
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
                              children: const [
                                Text('Upload supporting media (picture/video)'),
                                Text('Max. of 2 MB')
                              ],
                            ),
                          ],
                        ),
                        if (model.images.isNotEmpty)
                          Column(
                            children: [
                              const SizedBox(height: 16),
                              const LineSeparator(color: Colors.grey),
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
                                    title: Text(file.path.split('/').last),
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
          width: SizeMg.width(62),
          height: SizeMg.height(40),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Image(
                  image: NetworkImage(widget.trip.settings?.driverAvatar ?? ''),
                  width: SizeMg.width(31),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Image(
                  width: SizeMg.width(40),
                  image: NetworkImage(widget.trip.settings?.userAvatar ?? ''),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: SizeMg.width(11)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.trip.settings!.driverName!,
              style: TextStyle(
                  fontSize: SizeMg.text(12),
                  color: black,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              '${widget.trip.settings?.vehicleName ?? ''} • ${widget.trip.settings?.vehicleNumber ?? ''}',
              style: TextStyle(
                  fontSize: SizeMg.text(12), fontWeight: FontWeight.w400),
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
        width: SizeMg.width(48),
        height: SizeMg.height(4),
        margin: EdgeInsets.only(
          top: SizeMg.padV(8),
        ),
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
