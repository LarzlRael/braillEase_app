part of '../widgets.dart';

double fontSize = 20;

class CustomTextFormSpeechButton extends HookConsumerWidget {
  final Function(SpeechRecognitionResult res) onSpeechResult;
  final Function(String onchange) onTextChange;
  final FocusNode focusNode;
  const CustomTextFormSpeechButton({
    super.key,
    required this.onSpeechResult,
    required this.onTextChange,
    required this.focusNode,
  });
  @override
  Widget build(BuildContext context, ref) {
    final textController = useTextEditingController();
    final textTheme = Theme.of(context).textTheme;
    final globalProviderS = ref.watch(globalProvider);

    return Row(
      children: [
        Expanded(
          child: Card(
            child: TextField(
              focusNode: focusNode,
              controller: textController,
              minLines: 1,
              maxLines: 3,
              style: textTheme.bodySmall!.copyWith(
                fontSize: fontSize,
                /* color: braileProvider.getPickerTextColor, */
                color: globalProviderS.pickerColor,
                fontWeight: FontWeight.normal,
              ),
              decoration: InputDecoration(
                hintText: "Ingrese su texto aquí",
                hintStyle: TextStyle(fontSize: 14),
                border: InputBorder.none,
                suffixIcon: textController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          textController.text = "";
                          textController.clear();

                          ref.read(brailleProvider.notifier).setNormalText("");
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: globalProviderS.pickerColor,
                        ),
                      )
                    : null,
              ),
              onChanged: (value) {
                /* ref.read(brailleProvider.notifier).setNormalText(value); */
                onTextChange(value);
              },
            ),
          ),
        ),
        /* IconButton(
                        onPressed: () async {
                          await _speechToText.isNotListening
                              ? _startListening()
                              : _stopListening();
                        },
                        icon: Icon(
                          _speechToText.isNotListening
                              ? Icons.mic_off
                              : Icons.mic,
                        ),
                      ), */
        SpeechButton(
          onSpeechResult: onSpeechResult,
        ),
      ],
    );
  }
}
