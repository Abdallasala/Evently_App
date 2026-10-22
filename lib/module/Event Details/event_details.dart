import 'package:evently_app_c13_sun_7_pm/core/extensions/extensions.dart';
import 'package:evently_app_c13_sun_7_pm/core/routes/pages_routes_name.dart';
import 'package:evently_app_c13_sun_7_pm/core/services/firebase_firestore_serivce.dart';
import 'package:evently_app_c13_sun_7_pm/core/services/snack_bar_service.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_sun_7_pm/models/event_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final eventData = ModalRoute.of(context)?.settings.arguments as EventDataModel?;

    if (eventData == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Event Details'),
        ),
        body: const Center(
          child: Text('No Event Data Found'),
        ),
      );
    }

    var theme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    final imagePath = eventData.eventImage.isNotEmpty
        ? eventData.eventImage
        : "assets/images/book_club_img.png";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            size: 24,
            color: ColorPalette.primaryColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Event Details',
          style: theme.titleLarge?.copyWith(
            color: ColorPalette.primaryColor,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                RoutesName.edit_event,
                arguments: eventData,
              );
            },
            child: const Icon(
              Icons.edit,
              size: 24,
              color: ColorPalette.primaryColor,
            ),
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () async {
              EasyLoading.show();
              bool success = await FirebaseFirestoreService.deleteEvent(eventData);
              EasyLoading.dismiss();
              if (success) {
                SnackBarService.showSuccessMessage("Event deleted successfully");
                if (context.mounted) {
                  Navigator.pop(context);
                }
              } else {
                SnackBarService.showErrorMessage("Failed to delete event");
              }
            },
            child: const Icon(
              Icons.restore_from_trash,
              size: 24,
              color: Colors.red,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
              height: size.height * 203 / 909,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              eventData.eventTitle,
              style: theme.titleLarge?.copyWith(
                color: ColorPalette.primaryColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorPalette.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  width: 1.5,
                  color: ColorPalette.primaryColor,
                ),
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
                      Icons.calendar_month,
                      color: ColorPalette.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat("dd MMM yyyy").format(eventData.eventDate),
                        style: theme.titleMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.primaryColor,
                        ),
                      ),
                      Text(
                        eventData.eventTime.format(context),
                        style: theme.titleMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorPalette.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  width: 1.5,
                  color: ColorPalette.primaryColor,
                ),
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
                  const SizedBox(width: 12),
                  Text(
                    "Cairo, Egypt",
                    style: theme.titleMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.primaryColor,
                    ),
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
            Container(
              height: size.height * 200 / 909,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/Location_temp.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Description",
              style: theme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              eventData.eventDescription,
              style: theme.titleSmall?.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ).setHorizontalPadding(context, .04),
      ),
    );
  }
}
