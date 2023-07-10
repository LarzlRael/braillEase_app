part of '../widgets.dart';

class PickColorButton extends StatefulWidget {
  const PickColorButton({super.key});

  @override
  State<PickColorButton> createState() => _PickColorButtonState();
}

class _PickColorButtonState extends State<PickColorButton> {
  late BraileProvider braileProvider;
  @override
  void initState() {
    super.initState();
    braileProvider = context.read<BraileProvider>();
  }

  void changeColor(Color color) {
    braileProvider.setPickerTextColor = color;
  }

  @override
  Widget build(BuildContext context) {
    final globalProvider = context.watch<BraileProvider>();
    return GestureDetector(
      onTap: () {
        showPickerColorDialog();
      },
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: globalProvider.getPickerTextColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  showPickerColorDialog() {
    final globalProvider = context.read<BraileProvider>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Escoge un color'),
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: globalProvider.getPickerTextColor,
              onColorChanged: changeColor,
              /* showLabel: true,
                                    pickerAreaHeightPercent: 0.8, */
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
