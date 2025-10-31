import 'package:prueba_jun/library.dart';

class FilterRowWidget extends StatelessWidget {
  const FilterRowWidget({
    super.key,
    this.onEdittingComplete,
    this.onSelected,
    required this.nameController,
    required this.statusController,
    this.hintName,
    this.hintStatus,
  });
  final VoidCallback? onEdittingComplete;
  final Function(String)? onSelected;
  final TextEditingController nameController;
  final TextEditingController statusController;
  final String? hintName;
  final String? hintStatus;
  @override
  Widget build(BuildContext context) {
    final theme = UIThemes.of(context);
    BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(
        GeneralConstants.borderRadiusSnackBar,
      ),
      border: Border.all(color: theme.primaryColor),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: boxDecoration,
          width: MediaQuery.sizeOf(context).width / 2,
          child: TextFormField(
            onEditingComplete: () =>
                onEdittingComplete != null ? onEdittingComplete!() : null,
            controller: nameController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(right: 12, left: 12),
              hintText: hintName ?? "Поиск по любимым героям",
              prefixIcon: Icon(Icons.search, color: theme.primaryColor),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              border: InputBorder.none,
            ),
            style: theme.medium15.copyWith(color: theme.primaryColor),
          ),
        ),
        Container(
          decoration: boxDecoration,
          width: MediaQuery.sizeOf(context).width / 2 - 40,
          child: DropdownMenuSimple(
            onSelected: (String label) {
              onSelected != null ? onSelected!(label) : null;
            },
            hint: hintStatus ?? "Поиск по статусу",
            controller: statusController,
            width: MediaQuery.sizeOf(context).width / 2 - 40,
          ),
        ),
      ],
    );
  }
}
