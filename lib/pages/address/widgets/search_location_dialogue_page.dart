
import 'package:e_commercee_app/controllers/location_controller.dart';
import 'package:e_commercee_app/untils/dimenstions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_search/mapbox_search.dart';


class LocationDialogue extends StatelessWidget {
  final GoogleMapController mapController;

  const LocationDialogue({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimenstions.width10),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimenstions.radius20 / 2),
        ),
        child: SizedBox(
          width: Dimenstions.screenWidth,
          child: TypeAheadField(
            builder: (context, controller, focusNode) =>
                TextField(
                  controller: controller,
                  focusNode: focusNode,
                  autofocus: true,
                  textInputAction: TextInputAction.search,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    hintText: "Search location",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            style: BorderStyle.none, width: 0
                        )
                    ),
                    hintStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).disabledColor,
                        fontSize: Dimenstions.font20
                    ),
                  ),
                ),
            onSelected: (Suggestion value) {
              Get.find<LocationController>().setLocation(value.mapboxId, value.name, mapController);
              Get.back();
              },
            suggestionsCallback: (String search) async {
              return await Get.find<LocationController>().searchLocation(
                  context, search);
            },
            itemBuilder: (BuildContext context, Suggestion suggestion) {
              return Padding(
                padding: EdgeInsets.all(Dimenstions.width10),
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    Expanded(
                        child: Text(
                          suggestion.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                            fontSize: Dimenstions.font20
                          ),
                        ))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
