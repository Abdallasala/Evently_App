import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app_c13_sun_7_pm/core/custom_text_field.dart';
import 'package:evently_app_c13_sun_7_pm/core/extensions/extensions.dart';
import 'package:evently_app_c13_sun_7_pm/core/routes/pages_routes_name.dart';
import 'package:evently_app_c13_sun_7_pm/core/services/firebase_firestore_serivce.dart';
import 'package:evently_app_c13_sun_7_pm/core/theme/color_palette.dart';
import 'package:evently_app_c13_sun_7_pm/models/event_data_model.dart';
import 'package:evently_app_c13_sun_7_pm/module/layout/home/widget/event_card_widget.dart';
import 'package:flutter/material.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            CustomTextField(
              controller: _searchController,
              hint: "Search For Event",
              hintColor: ColorPalette.generalGreyColor,
              prefixIcon: const Icon(
                Icons.search,
                color: ColorPalette.primaryColor,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value?.trim().toLowerCase() ?? "";
                });
              },
            ).setHorizontalPadding(context, 0.03),
            SizedBox(
              height: mediaQuery.size.height * 0.02,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<EventDataModel>>(
                stream: FirebaseFirestoreService.getStreamFavoriteData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Something went wrong",
                            style: theme.textTheme.titleMedium,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.refresh_outlined,
                              color: ColorPalette.primaryColor,
                            ),
                          )
                        ],
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorPalette.primaryColor,
                      ),
                    );
                  }

                  List<EventDataModel> eventDataList = snapshot.data?.docs
                          .map((element) => element.data())
                          .where((event) {
                        if (searchQuery.isEmpty) return true;
                        return event.eventTitle.toLowerCase().contains(searchQuery) ||
                            event.eventDescription.toLowerCase().contains(searchQuery) ||
                            event.eventCategory.toLowerCase().contains(searchQuery);
                      }).toList() ??
                      [];

                  if (eventDataList.isEmpty) {
                    return Center(
                      child: Text(
                        searchQuery.isEmpty
                            ? "No Favorite Events Yet..!"
                            : "No Matching Events Found",
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: ColorPalette.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.event_details,
                          arguments: eventDataList[index],
                        );
                      },
                      child: EventCardWidget(
                        eventDataModel: eventDataList[index],
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: eventDataList.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
