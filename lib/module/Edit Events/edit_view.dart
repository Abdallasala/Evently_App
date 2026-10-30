import 'package:evently_app_c13_sun_7_pm/core/extensions/extensions.dart';
import 'package:evently_app_c13_sun_7_pm/core/services/firebase_firestore_serivce.dart';
import 'package:evently_app_c13_sun_7_pm/core/services/snack_bar_service.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_sun_7_pm/models/event_data_model.dart';
import 'package:evently_app_c13_sun_7_pm/module/CreateEvent/widget/event_location_picker.dart';
import 'package:evently_app_c13_sun_7_pm/module/CreateEvent/widget/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../core/custom_text_field.dart';
import '../../models/event_category.dart';

class EditView extends StatefulWidget {
  const EditView({super.key});

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  int selectedTap = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  double latitude = 0.0;
  double longitude = 0.0;
  String selectedLocationAddress = "Choose Event Location";
  EventDataModel? eventDataModel;
  bool isInitialized = false;

  List<EventCategory> eventCategories = [
    EventCategory(
      eventCategoryName: "Book Club",
      eventCategoryIcon: Icons.menu_book_outlined,
      eventCategoryImg: "assets/images/book_club_img.png",
    ),
    EventCategory(
      eventCategoryName: "Sport",
      eventCategoryIcon: Icons.directions_bike,
      eventCategoryImg: "assets/images/sport_img.png",
    ),
    EventCategory(
      eventCategoryName: "BirthDay",
      eventCategoryIcon: Icons.cake_outlined,
      eventCategoryImg: "assets/images/birthday_img.png",
    ),
    EventCategory(
      eventCategoryName: "Meeting",
      eventCategoryIcon: Icons.meeting_room_outlined,
      eventCategoryImg: "assets/images/meeting_img.png",
    ),
    EventCategory(
      eventCategoryName: "Holiday",
      eventCategoryIcon: Icons.holiday_village_outlined,
      eventCategoryImg: "assets/images/holiday_img.png",
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      eventDataModel = ModalRoute.of(context)?.settings.arguments as EventDataModel?;
      if (eventDataModel != null) {
        _titleController = TextEditingController(text: eventDataModel!.eventTitle);
        _descriptionController = TextEditingController(text: eventDataModel!.eventDescription);
        selectedDate = eventDataModel!.eventDate;
        selectedTime = eventDataModel!.eventTime;
        latitude = eventDataModel!.latitude;
        longitude = eventDataModel!.longitude;

        int categoryIdx = eventCategories.indexWhere(
          (c) => c.eventCategoryName == eventDataModel!.eventCategory,
        );
        if (categoryIdx != -1) {
          selectedTap = categoryIdx;
        }
      } else {
        _titleController = TextEditingController();
        _descriptionController = TextEditingController();
      }
      isInitialized = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    if (eventDataModel == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Edit Event')),
        body: const Center(child: Text('No Event Selected')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.white,
        centerTitle: true,
        title: Text(
          'Edit Event',
          style: theme.titleLarge!.copyWith(
            color: ColorPalette.primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Form(
          key: formKey,
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
                    fit: BoxFit.cover,
                  ),
                ),
              ).setHorizontalPadding(context, .02),
              const SizedBox(height: 10),
              DefaultTabController(
                length: eventCategories.length,
                child: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  dividerColor: Colors.transparent,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 6.0),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  indicator: const BoxDecoration(),
                  onTap: (value) {
                    setState(() {
                      selectedTap = value;
                    });
                  },
                  tabs: eventCategories.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return TabWidget(
                      eventCategory: item,
                      isSelected: selectedTap == index,
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10),
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
                onValidate: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Title cannot be empty";
                  }
                  return null;
                },
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
                onValidate: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Description cannot be empty";
                  }
                  return null;
                },
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
                    onTap: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (newDate != null) {
                        setState(() {
                          selectedDate = newDate;
                        });
                      }
                    },
                    child: Text(
                      selectedDate != null
                          ? DateFormat("dd MMM yyy").format(selectedDate!)
                          : "Choose Date",
                      style: theme.titleMedium?.copyWith(
                        color: ColorPalette.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Icon(Icons.watch_later_outlined),
                  const SizedBox(width: 10),
                  Text(
                    "Event Time",
                    style: theme.titleMedium,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: selectedTime ?? TimeOfDay.now(),
                      );
                      if (newTime != null) {
                        setState(() {
                          selectedTime = newTime;
                        });
                      }
                    },
                    child: Text(
                      selectedTime != null
                          ? selectedTime!.format(context)
                          : "Choose Time",
                      style: theme.titleMedium?.copyWith(
                        color: ColorPalette.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Location",
                style: theme.titleMedium,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  final LocationResult? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventLocationPicker(
                        initialLat: latitude,
                        initialLng: longitude,
                      ),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      latitude = result.latitude;
                      longitude = result.longitude;
                      selectedLocationAddress = result.address;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  side: const BorderSide(color: ColorPalette.primaryColor),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorPalette.primaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Icon(
                        Icons.my_location_outlined,
                        color: ColorPalette.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        selectedLocationAddress,
                        style: theme.titleMedium?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: ColorPalette.primaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    var updatedData = EventDataModel(
                      eventID: eventDataModel!.eventID,
                      userID: eventDataModel!.userID,
                      eventTitle: _titleController.text.trim(),
                      eventDescription: _descriptionController.text.trim(),
                      eventCategory: eventCategories[selectedTap].eventCategoryName,
                      eventImage: eventCategories[selectedTap].eventCategoryImg,
                      eventDate: selectedDate ?? eventDataModel!.eventDate,
                      eventTime: selectedTime ?? eventDataModel!.eventTime,
                      latitude: latitude,
                      longitude: longitude,
                      isFavorite: eventDataModel!.isFavorite,
                    );

                    EasyLoading.show();
                    bool success = await FirebaseFirestoreService.updateEvent(updatedData);
                    EasyLoading.dismiss();
                    if (success) {
                      SnackBarService.showSuccessMessage("Event Updated Successfully");
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    } else {
                      SnackBarService.showErrorMessage("Failed to update event");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  elevation: 0,
                  backgroundColor: ColorPalette.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  side: const BorderSide(color: ColorPalette.primaryColor),
                ),
                child: Text(
                  'Update Event',
                  style: theme.titleMedium!.copyWith(
                    color: ColorPalette.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).setHorizontalPadding(context, .05),
              const SizedBox(height: 20),
            ],
          ).setHorizontalPadding(context, .02),
        ),
      ),
    );
  }
}
