import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online/feature/dashboard/checkout_screen.dart';

class PuchaseInformationScreen extends StatefulWidget {
  final String image;
  final String title;
  const PuchaseInformationScreen(
      {super.key, required this.image, required this.title});

  @override
  State<PuchaseInformationScreen> createState() =>
      _PuchaseInformationScreenState();
}

bool _isSelected = false;
bool _isClickDate = false;
List<DateTime?> listDate = [];
String firstDate = '';
String lastDate = '';

class _PuchaseInformationScreenState extends State<PuchaseInformationScreen> {
  final List<int> amountofDays = [3, 6, 9, 12, 15, 30];
  late int amountDaySelected = 0;
  late String formattedDate = '';
  String elementDate = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text(
          'Puchase Information',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Amount of Days',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isSelected = !_isSelected;
                      });
                      setState(() {});
                      debugPrint(_isSelected.toString());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 0.5, color: Colors.grey.withOpacity(0.6))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            amountDaySelected == 0
                                ? 'Select amount of days'
                                : amountDaySelected.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_outlined,
                          )
                        ],
                      ),
                    ),
                  ),
                  if (_isSelected)
                    Container(
                      margin: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(amountofDays.length, (index) {
                          final int amounts = amountofDays[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: InkWell(
                              onTap: () {
                                amountDaySelected = amounts;
                                setState(() {});
                                _isSelected = false;
                              },
                              child: Text(
                                '$amounts days',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Select Date',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isClickDate = !_isClickDate;
                      });

                      debugPrint(_isClickDate.toString());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 0.5, color: Colors.grey.withOpacity(0.6))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            firstDate != ''
                                ? '$firstDate - $lastDate'
                                : 'Select Date',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_outlined,
                          )
                        ],
                      ),
                    ),
                  ),
                  if (_isClickDate)
                    CalendarDatePicker2WithActionButtons(
                      config: CalendarDatePicker2WithActionButtonsConfig(
                        firstDayOfWeek: 1,
                        calendarType: CalendarDatePicker2Type.range,
                        selectedDayTextStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                        selectedDayHighlightColor: Colors.purple[800],
                        centerAlignModePicker: true,
                        customModePickerIcon: const SizedBox(),
                        dayBuilder: null,
                        yearBuilder: null,
                      ),
                      value: const [],
                      onValueChanged: (value) {
                        listDate = value;
                        firstDate =
                            DateFormat('yyyy-MM-dd').format(listDate[0]!);
                        lastDate =
                            DateFormat('yyyy-MM-dd').format(listDate[1]!);
                        setState(() {});
                      },
                      onOkTapped: () {
                        _isClickDate = false;
                      },
                      onCancelTapped: () {
                        _isClickDate = false;
                      },
                    ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckOutScreen(
                            image: widget.image,
                            title: widget.title,
                          )));
            },
            child: Container(
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.green),
              child: const Center(
                child: Text(
                  'Add to Card',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
