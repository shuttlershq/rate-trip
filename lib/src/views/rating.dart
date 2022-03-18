import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rate_trip/src/model/model.dart';
import 'package:rate_trip/src/utils/colors.dart';
import 'package:rate_trip/src/utils/size_manager.dart';
import 'package:rate_trip/src/viewmodels/rating_vm.dart';
import 'package:rate_trip/src/widgets/bottom_sheet.dart';
import 'package:rate_trip/src/widgets/rating_bar.dart';

class RateTrip extends StatefulWidget {
  final Trip trip;

  const RateTrip({Key? key, required this.trip}) : super(key: key);

  @override
  _RateTripState createState() => _RateTripState();
}

class _RateTripState extends State<RateTrip> {
  late RatingVm model;

  @override
  void initState() {
    model = RatingVm();
    super.initState();
  }

  Widget serviceschip(RatingCategoryOptions option) {
    return GestureDetector(
      onTap: () {
        model.addIssues(option);
        setState(() {});
      },
      child: Chip(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        label: Text(
          option.name!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
        backgroundColor:
            model.issues.containsKey(option.reference) ? lightGreen : grey,
      ),
    );
  }

  Widget wrapServicesWidget(List<RatingCategoryOptions>? list) {
    List<Widget> cs = [];
    if (list == null) return Container();
    for (int i = 0; i < list.length; i++) {
      cs.add(serviceschip(list[i]));
    }
    return Wrap(spacing: 4.0, runSpacing: 4.0, children: cs);
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
    return Scaffold(
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
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text('Skip'),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Thank You!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: SizeMg.width(75),
                      height: SizeMg.height(47),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: CachedNetworkImage(
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              imageUrl:
                                  'https://avatars.githubusercontent.com/u/53065184?v=4',
                              errorWidget: (context, url, error) => const Image(
                                  image:
                                      AssetImage("assets/icons/user_icon.png")),
                              placeholder: (context, url) => const Image(
                                  image:
                                      AssetImage("assets/icons/user_icon.png")),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: CachedNetworkImage(
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              imageUrl:
                                  'https://avatars.githubusercontent.com/u/31275429?v=4',
                              errorWidget: (context, url, error) => const Image(
                                  image:
                                      AssetImage("assets/icons/user_icon.png")),
                              placeholder: (context, url) => const Image(
                                  image:
                                      AssetImage("assets/icons/user_icon.png")),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 11),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Mufasa Bigson'),
                        Text('Toyota Coaster Bus • S21')
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 41),
                const Text(
                  "How was your trip?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                    'Your feedback will help us improve your experience.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
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
                    setState(() {});
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
                    model.options
                        .where((element) => element.name != null)
                        .toList()
                        .sublist(
                            0,
                            model.options.length > 5
                                ? 5
                                : model.options.length),
                  ),
                if (model.starRating <= 3) const SizedBox(height: 18),
                if (model.starRating <= 3)
                  InkWell(
                      onTap: () {
                        CustomBottomSheet.showBottomSheet(
                            context,
                            Container(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  const Text('Your rating'),
                                  Ratings(
                                    vm: model,
                                    size: SizeMg.width(50),
                                    onChanged: (newValue) {
                                      setState(() {});
                                    },
                                  ),
                                  const Divider(),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: model.categories.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                            dividerColor: Colors.transparent),
                                        child: ExpansionTile(
                                          leading: const Icon(Icons.circle),
                                          title: Text(
                                              model.categories[index].name!),
                                          children: [
                                            wrapServicesWidget(
                                              model.options
                                                  .where((element) =>
                                                      element
                                                          .ratingCategoryReference ==
                                                      model.categories[index]
                                                          .reference)
                                                  .toList(),
                                            ),
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
                                        onPressed: () {},
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
                    Container(
                      decoration: const BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.camera_alt,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Upload supporting media (picture/video)'),
                        Text('Max. of 2 MB')
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: btnGreen, primary: Colors.white),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Send'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
