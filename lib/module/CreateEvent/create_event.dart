import 'package:evently_app_c13_sun_7_pm/core/extensions/extensions.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_sun_7_pm/module/CreateEvent/widget/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/custom_text_field.dart';
import '../../models/event_category.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  int selectedTap = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  List<EventCategory> eventCategories = [
    EventCategory(
      eventCategoryName: "Book Club",
      eventCategoryIcon: Icons.menu_book_outlined,
      eventCategoryImg: "assets/images/book_club_img.png",
    ),
    EventCategory(
        eventCategoryName: "Sport",
        eventCategoryIcon: Icons.directions_bike,
        eventCategoryImg: "assets/images/sport_img.png"),
    EventCategory(
        eventCategoryName: "BirthDay",
        eventCategoryIcon: Icons.cake_outlined,
        eventCategoryImg: "assets/images/birthday_img.png"),
    EventCategory(
        eventCategoryName: "Meeting",
        eventCategoryIcon: Icons.meeting_room_outlined,
        eventCategoryImg: "assets/images/meeting_img.png"),
    EventCategory(
        eventCategoryName: "Holiday",
        eventCategoryIcon: Icons.holiday_village_outlined,
        eventCategoryImg: "assets/images/holiday_img.png"),
  ];
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    var theme =Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.white,
        centerTitle: true,
        title: Text('create event',
        style: theme.titleLarge!.copyWith(
          color: ColorPalette.primaryColor
        ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: AssetImage(eventCategories[selectedTap].eventCategoryImg),
                    fit: BoxFit.cover)
              ),
            ).setHorizontalPadding(context,1.01),
            DefaultTabController(length: eventCategories.length,
              child:TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 6.0),
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  indicator: const BoxDecoration(),
                  onTap: (value) {
                    setState(() {
                      selectedTap = value;
                    });
                  },
                  tabs: eventCategories.map((item){
                    return TabWidget(eventCategory:item, isSelected: selectedTap == eventCategories.indexOf(item),);
                  }).toList()

              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Title",
              style: theme.titleMedium,
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _titleController,
              hint: "Event Title",
              hintColor: ColorPalette.generalGreyColor,
              prefixIcon: const Icon(
                Icons.edit_note_outlined,
                color: ColorPalette.generalGreyColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Description",
              style: theme.titleMedium,
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _descriptionController,
              hint: "Event Description",
              hintColor: ColorPalette.generalGreyColor,
              maxLines: 4,
            ),
            const SizedBox(height: 20),
        Row(
            children: [
            const Icon(Icons.calendar_month),
        const SizedBox(width: 10),
        Text(
          "Event Date",
          style: theme.titleMedium,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
          //  selectEventDate(context);
          },
          child: Text(
            selectedDate != null
                ? DateFormat("dd MMM yyy").format(selectedDate!)
                : "Choose Date",
            style: theme.titleMedium?.copyWith(
                color: ColorPalette.primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),

          ],

        ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.watch_later),
                const SizedBox(width: 10),
                Text(
                  "Event Date",
                  style: theme.titleMedium,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    //  selectEventDate(context);
                  },
                  child: Text(
                    selectedDate != null
                        ? DateFormat("dd MMM yyy").format(selectedDate!)
                        : "Choose Time",
                    style: theme.titleMedium?.copyWith(
                        color: ColorPalette.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),

              ],

            ),
            const SizedBox(height: 20),
            Text(
              "Location",
              style: theme.titleMedium?.copyWith(),
            ),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: (){},
                style:  ElevatedButton.styleFrom(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    side: const BorderSide(color: ColorPalette.primaryColor)),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: ColorPalette.primaryColor,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: const Icon(
                        Icons.my_location_outlined,
                        color: ColorPalette.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Choose Event Location",
                      style: theme.titleMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.primaryColor),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: ColorPalette.primaryColor,
                    ),
                  ],
                ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    elevation: 0,
                    backgroundColor: ColorPalette.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    side: const BorderSide(color: ColorPalette.primaryColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Add Event',
                                 // textAlign: TextAlign.center,
                      style: theme.titleMedium!.copyWith(
                        color: ColorPalette.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 2,
                      ),
                    ),
                  //  const SizedBox(height: 20,)
                  ],
                ),

            ).setHorizontalPadding(context, .05),
            SizedBox(height: 20,)
        ]
            ).setHorizontalPadding(context, .02),
      ),
    );
  }
}
