

class FilterChipData {
  String label;
  bool isSelected;
  FilterChipData(this.label, this.isSelected);
}
List<FilterChipData> categories = [
  FilterChipData("Terror", false),
  FilterChipData("Acción", false),
  FilterChipData("MMO", false),
  FilterChipData("Todo", true)
];