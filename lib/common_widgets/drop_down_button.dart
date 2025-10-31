import 'package:prueba_jun/library.dart';

class MenuItem {
  final int id;
  final String label;

  MenuItem({required this.id, required this.label});
}

List<MenuItem> statusList = [
  MenuItem(id: 0, label: Status.ALL.name),
  MenuItem(id: 1, label: Status.ALIVE.name),
  MenuItem(id: 2, label: Status.DEAD.name),
  MenuItem(id: 3, label: Status.UNKNOWN.name),
];

class DropdownMenuSimple extends StatefulWidget {
  const DropdownMenuSimple({
    super.key,
    required this.controller,
    required this.width,
    required this.hint,
    this.onSelected,
  });
  final TextEditingController controller;
  final double width;
  final String hint;
  final Function(String itemLabel)? onSelected;
  @override
  State<StatefulWidget> createState() => _DropdownMenuSimple();
}

class _DropdownMenuSimple extends State<DropdownMenuSimple> {
  @override
  Widget build(BuildContext context) {
    final theme = UIThemes.of(context);
    return DropdownMenu<MenuItem>(
      controller: widget.controller,
      width: 200,
      hintText: statusList.first.label,
      textStyle: theme.medium10.copyWith(color: theme.primaryColor),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        contentPadding: EdgeInsets.only(right: 12, left: 12, bottom: 16),
      ),
      showTrailingIcon: false,
      leadingIcon: Icon(
        Icons.keyboard_arrow_down_sharp,
        color: theme.primaryColor,
      ),
      onSelected: (MenuItem? menu) {
        setState(() {
          widget.onSelected != null
              ? widget.onSelected!(menu?.label ?? Status.ALL.name)
              : null;
        });
      },
      dropdownMenuEntries: statusList.map<DropdownMenuEntry<MenuItem>>((menu) {
        return DropdownMenuEntry(value: menu, label: menu.label);
      }).toList(),
    );
  }
}
