import 'package:flutter/material.dart';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../common/services/notification_services.dart';
import '../common/services/theme_services.dart';

import '../common/utils/colors.dart';
import '../common/utils/theme.dart';

import '../common/widgets/button.dart';
import '../common/widgets/item_tile.dart';

import '../pages/add_item_page.dart';

import '../controllers/item_controller.dart';

import '../models/item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  final _itemController = Get.put(ItemController());

  NotifyHelper notifyHelper = NotifyHelper();

  @override
  void initState() {
    super.initState();
    _itemController.getItem();
    notifyHelper.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.appBarTheme.backgroundColor,
      body: Column(
        children: [
          _appTaskBar(),
          _appDateBar(),
          const SizedBox(
            height: 20,
          ),
          _showItems(),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: context.theme.appBarTheme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeController().switchTheme();
          notifyHelper.displayNotification(
            title: "Theme Changed",
            body: Get.isDarkMode
                ? "Activated Light Theme"
                : "Activated Dark Theme",
          );
        },
        child: Get.isDarkMode
            ? const Icon(
                Icons.wb_sunny_outlined,
                size: 25,
                color: whiteClr,
              )
            : const Icon(
                Icons.nightlight_round_rounded,
                size: 25,
                color: blackClr,
              ),
      ),
      actions: [
        Icon(
          Icons.person,
          size: 25,
          color: Get.isDarkMode ? whiteClr : blackClr,
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }

  _appTaskBar() {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                "Today",
                style: headingStyle,
              ),
            ],
          ),
          MyButton(
            label: "+ Add Item",
            onTap: () async {
              await Get.to(() => const AddItemPage());
              _itemController.getItem();
            },
          ),
        ],
      ),
    );
  }

  _appDateBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: DatePicker(
        DateTime.now().add(const Duration(days: 1)),
        height: 100,
        width: 80,
        initialSelectedDate: _selectedDate,
        selectionColor: primaryClrMaterial,
        selectedTextColor: whiteClr,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        onDateChange: (date) {
          setState(
            () {
              _selectedDate = date;
            },
          );
        },
      ),
    );
  }

  _showItems() {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
            itemCount: _itemController.itemList.length,
            itemBuilder: (_, index) {
              if (_itemController.itemList[index].repeat == "Daily") {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(
                                context,
                                _itemController.itemList[index],
                              );
                            },
                            child: ItemTile(
                              item: _itemController.itemList[index],
                              onTapDelete: _itemController.removeItem,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (_itemController.itemList[index].date ==
                  DateFormat("dd/MM/yyyy").format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(
                                context,
                                _itemController.itemList[index],
                              );
                            },
                            child: ItemTile(
                              item: _itemController.itemList[index],
                              onTapDelete: _itemController.removeItem,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }

  _showBottomSheet(BuildContext context, Item item) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        width: MediaQuery.of(context).size.width,
        height: item.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.20
            : MediaQuery.of(context).size.height * 0.28,
        color: Get.isDarkMode ? darkGreyClr : whiteClr,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
            const Spacer(),
            item.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    context: context,
                    label: "Item Consumed",
                    onTap: () {
                      _itemController.markItemConsumed(item.id!);
                      Get.back();
                    },
                    clr: primaryClrMaterial,
                  ),
            _bottomSheetButton(
              context: context,
              label: "Remove Item",
              onTap: () {
                _itemController.removeItem(item);
                Get.back();
              },
              clr: pinkClr,
            ),
            const SizedBox(
              height: 20,
            ),
            _bottomSheetButton(
              context: context,
              label: "Close",
              onTap: () {
                Get.back();
              },
              clr: Colors.transparent,
              isClosed: true,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  _bottomSheetButton({
    required BuildContext context,
    required String label,
    required Function() onTap,
    required Color clr,
    bool isClosed = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClosed
                ? (Get.isDarkMode ? Colors.grey[600]! : Colors.grey[300]!)
                : clr,
          ),
          color: isClosed ? Colors.transparent : clr,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: isClosed
                ? titleStyle
                : titleStyle.copyWith(
                    color: whiteClr,
                  ),
          ),
        ),
      ),
    );
  }
}
