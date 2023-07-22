import 'dart:math';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../common/services/notification_services.dart';

import '../common/utils/theme.dart';
import '../common/utils/colors.dart';

import '../common/widgets/button.dart';
import '../common/widgets/input_field.dart';

import '../controllers/item_controller.dart';

import '../models/item.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String _notifyTime = "12:00 AM";

  int _selectedRemind = 0;
  List<int> remindList = [
    0,
    1,
    2,
    5,
    15,
    30,
    60,
  ];

  String _selectedRepeat = "None";
  List<String> repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];

  int _selectedColor = 0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descpController = TextEditingController();

  final ItemController _itemController = Get.put(ItemController());

  NotifyHelper notifyHelper = NotifyHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: context.theme.appBarTheme.backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Item",
                style: headingStyle,
              ),
              MyInputField(
                title: "Name",
                placeholder: "Enter item name",
                controller: _nameController,
              ),
              MyInputField(
                title: "Description",
                placeholder: "Enter item description",
                controller: _descpController,
              ),
              MyInputField(
                title: "Date",
                placeholder: DateFormat("dd / MM / yyyy").format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    color: greyClr,
                  ),
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Notification Time",
                      placeholder: _notifyTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser();
                        },
                        icon: const Icon(
                          Icons.access_time_outlined,
                          color: greyClr,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MyInputField(
                title: "Remind",
                placeholder: "$_selectedRemind days early",
                widget: DropdownButton(
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: greyClr,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0),
                  items: remindList.map<DropdownMenuItem<String>>(
                    (int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    },
                  ).toList(),
                ),
              ),
              MyInputField(
                title: "Repeat",
                placeholder: _selectedRepeat,
                widget: DropdownButton(
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: greyClr,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0),
                  items: repeatList.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: greyClr),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  MyButton(
                    label: "Create Task",
                    onTap: () {
                      _validateItem();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.appBarTheme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 25,
          color: Get.isDarkMode ? whiteClr : blackClr,
        ),
      ),
      actions: const [
        Icon(
          Icons.person,
          size: 25,
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
      });
    }
  }

  _getTimeFromUser() async {
    var pickedTime = await _showTimePicker();

    String formattedTime;

    if (pickedTime == null) {
      return;
    }

    DateTime currentTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      pickedTime.hour,
      pickedTime.minute,
    );
    formattedTime = DateFormat('hh:mm a').format(currentTime);

    setState(() {
      _notifyTime = formattedTime;
    });
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_notifyTime.split(":")[0]),
        minute: int.parse(_notifyTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? primaryClrMaterial
                        : (index == 1 ? pinkClr : yellowClr),
                    child: _selectedColor == index
                        ? const Icon(
                            Icons.done,
                            color: whiteClr,
                            size: 16,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _validateItem() {
    if (_nameController.text.isNotEmpty && _descpController.text.isNotEmpty) {
      _addItemToDb();
      _setNotificationSchedule();
      Get.back();
    } else if (_nameController.text.isEmpty || _descpController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "All fields are required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? whiteClr : blackClr,
        colorText: Get.isDarkMode ? blackClr : whiteClr,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        duration: const Duration(seconds: 3),
      );
    }
  }

  _addItemToDb() async {
    await _itemController.addItem(
      item: Item(
        name: _nameController.text,
        descp: _descpController.text,
        date: DateFormat("dd/MM/yyyy").format(_selectedDate),
        notifyTime: _notifyTime,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
        color: _selectedColor,
        isCompleted: 0,
      ),
    );
  }

  _setNotificationSchedule() {
    DateTime dateWith24HrTimeFormat =
        DateFormat("HH:mm a").parse(_notifyTime.toString());

    var myTime = DateFormat("HH:mm").format(dateWith24HrTimeFormat);

    if (_selectedRemind == 0) {
      // if "NO REMINDER" is selected then schedule notification at "12:00 am" ONLY on the "selected date"
      notifyHelper.scheduledNotification(
        Item(
          id: _itemController.itemList.length,
          name: _nameController.text,
          descp: _descpController.text,
          date: DateFormat("dd/MM/yyyy").format(_selectedDate),
          notifyTime: _notifyTime,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
          color: _selectedColor,
          isCompleted: 0,
        ),
        int.parse(
            DateFormat('dd/MM/yyyy').format(_selectedDate).substring(6, 10)),
        int.parse(
            DateFormat('dd/MM/yyyy').format(_selectedDate).substring(3, 5)),
        int.parse(
            DateFormat('dd/MM/yyyy').format(_selectedDate).substring(0, 2)),
        int.parse(myTime.toString().split(":")[0]),
        int.parse(myTime.toString().split(":")[1]),
      );
    } else {
      // if "REMINDER" is selected then schedule notification at "12:00 am" "REMINDER" days before the "selected date" and also schedule notification at "12:00 am" on the "selected date"

      // calculating reminder date
      DateTime reminderDate = _selectedDate.subtract(
        Duration(days: _selectedRemind),
      );

      // schedule notification at "12:00 am", "REMINDER" days before the "selected date"
      notifyHelper.scheduledNotification(
        Item(
          id: Random().nextInt(1000000),
          name: _nameController.text,
          descp: _descpController.text,
          date: DateFormat("dd/MM/yyyy").format(_selectedDate),
          notifyTime: _notifyTime,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
          color: _selectedColor,
          isCompleted: 0,
        ),
        int.parse(
            DateFormat('dd/MM/yyyy').format(reminderDate).substring(6, 10)),
        int.parse(
            DateFormat('dd/MM/yyyy').format(reminderDate).substring(3, 5)),
        int.parse(
            DateFormat('dd/MM/yyyy').format(reminderDate).substring(0, 2)),
        int.parse(myTime.toString().split(":")[0]),
        int.parse(myTime.toString().split(":")[1]),
      );

      // schedule notification at "12:00 am" on the "selected date"
      notifyHelper.scheduledNotification(
        Item(
          id: Random().nextInt(1000000),
          name: _nameController.text,
          descp: _descpController.text,
          date: DateFormat("dd/MM/yyyy").format(_selectedDate),
          notifyTime: _notifyTime,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
          color: _selectedColor,
          isCompleted: 0,
        ),
        int.parse(
            DateFormat('dd/MM/yyyy').format(_selectedDate).substring(6, 10)),
        int.parse(
            DateFormat('dd/MM/yyyy').format(_selectedDate).substring(3, 5)),
        int.parse(
            DateFormat('dd/MM/yyyy').format(_selectedDate).substring(0, 2)),
        int.parse(myTime.toString().split(":")[0]),
        int.parse(myTime.toString().split(":")[1]),
      );
    }
  }
}
