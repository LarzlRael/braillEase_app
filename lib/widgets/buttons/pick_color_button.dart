part of '../widgets.dart';

class PickColorButton extends ConsumerWidget {
  const PickColorButton({super.key});

  /* late BrailleProvider braileProvider;
  @override
  void initState() {
    super.initState();
    braileProvider = context.read<BrailleProvider>();
  } */

  @override
  Widget build(BuildContext context, ref) {
    final globalProvider = ref.watch(brailleProvider);
    return GestureDetector(
      onTap: () => showPickerColorDialog(context, ref),
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: globalProvider.pickerTextColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  showPickerColorDialog(BuildContext context, ref) {
    final brailleProviderState = ref.watch(brailleProvider);
    final brailleNotifier = ref.watch(brailleProvider.notifier);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Escoge un color'),
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: brailleProviderState.getPickerTextColor,
              onColorChanged: (color) {
                brailleNotifier.setPickerTextColor(color);
              },

              /* showLabel: true,
                                    pickerAreaHeightPercent: 0.8, */
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: context.pop,
            ),
          ],
        );
      },
    );
  }
}
