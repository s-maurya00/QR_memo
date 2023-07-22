import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';
import '../utils/theme.dart';

import '../widgets/button.dart';

import '../../models/item.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({super.key, this.item, required this.onTapDelete});

  final Item? item;
  final Function(Item item) onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(item?.color ?? 0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.52),
                        child: Text(
                          item?.name ?? "",
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          print("Edit task");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey[200]!.withOpacity(0.7),
                            ),
                          ),
                          padding: const EdgeInsets.all(2),
                          child: Icon(
                            Icons.edit_note_rounded,
                            color: Colors.grey[200],
                            size: 26,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          _showAlertDialog(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey[200]!.withOpacity(0.7),
                            ),
                          ),
                          padding: const EdgeInsets.all(2),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.grey[200],
                            size: 26,
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Icon(
                  //       Icons.access_time_rounded,
                  //       color: Colors.grey[200],
                  //       size: 18,
                  //     ),
                  //     const SizedBox(width: 4),
                  //     Text(
                  //       "${task!.startTime} - ${task!.endTime}",
                  //       style: GoogleFonts.lato(
                  //         textStyle: TextStyle(
                  //           fontSize: 13,
                  //           color: Colors.grey[100],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Text(
                    item?.descp ?? "",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[100],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                item!.isCompleted == 1 ? "COMPLETED" : "TODO",
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      default:
        return bluishClr;
    }
  }

  _showAlertDialog(BuildContext context) {
    Widget cancelButton = MyButton(
      label: "Cancel",
      color: Colors.transparent,
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.grey[400] : greyClr,
      ),
      onTap: () {
        Get.back();
      },
    );
    Widget continueButton = MyButton(
      label: "Delete",
      color: Color.fromRGBO(255, 0, 0, 1),
      onTap: () {
        onTapDelete(item!);
        Get.back();
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Are you sure?",
        style: headingStyle,
      ),
      content:
          Text("Would you like to delete this item?", style: subTitleStyle),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
