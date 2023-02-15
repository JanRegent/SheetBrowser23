import 'package:card_swiper/card_swiper.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

List<Widget> getActions(
    int pagesCount, SwiperController controller, BuildContext context) {
  Widget move2pageDropdown() {
    List<String> list = [for (var i = 0; i < pagesCount; i += 10) i.toString()];
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
        showSelectedItems: true,
        disabledItemFn: (String s) => s.startsWith('I'),
      ),
      items: list,
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: "Menu mode",
          hintText: "country in menu mode",
        ),
      ),
      onChanged: (value) {
        int? page = int.tryParse(value!);
        Navigator.pop(context);
        controller.move(page!);
      },
      selectedItem: list[0],
    );
  }

  List<Widget> actions = [
    PopupMenuButton(
        // add icon, by default "3 dot" icon
        // icon: Icon(Icons.book)
        itemBuilder: (context) {
      return [
        PopupMenuItem<int>(
          value: 0,
          child: move2pageDropdown(),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: Text("Settings"),
        ),
        const PopupMenuItem<int>(
          value: 2,
          child: Text("Logout"),
        ),
      ];
    }, onSelected: (value) {
      // if (value == 0) {
      //   print("My account menu is selected.");
      // } else if (value == 1) {
      //   print("Settings menu is selected.");
      // } else if (value == 2) {
      //   print("Logout menu is selected.");
      // }
    })
  ];

  return actions;
}
