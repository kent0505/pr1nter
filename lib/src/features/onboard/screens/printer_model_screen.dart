import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/field.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/svg_widget.dart';
import '../../home/screens/home_screen.dart';
import '../data/onboard_repository.dart';

class PrinterModelScreen extends StatefulWidget {
  const PrinterModelScreen({super.key});

  static const routePath = '/PrinterModelScreen';

  @override
  State<PrinterModelScreen> createState() => _PrinterModelScreenState();
}

class _PrinterModelScreenState extends State<PrinterModelScreen> {
  final modelController = TextEditingController();
  final focusNode = FocusNode();

  bool personalizing = false;
  bool finished = false;

  List<String> models = [
    'HP DesckJet',
    'HP OfficeJetPro',
    'HP Envy',
    'HP Laser Jet',
    'Canon MAXIFY',
    'Canon PIXMA',
    'Brother MFC',
    'Other',
  ];

  String model = '';

  void onModel(String value) {
    setState(() {
      model == value ? model = '' : model = value;
    });
    if (model == 'Other') focusNode.requestFocus();
  }

  void onContinue() async {
    setState(() {
      personalizing = true;
    });
    if (finished) {
      context.read<OnboardRepository>()
        ..removeOnboard()
        ..savePrinter(
          model == 'Other' ? modelController.text : model,
        ).then((value) {
          if (mounted) {
            context.replace(HomeScreen.routePath);
          }
        });
    }
  }

  @override
  void dispose() {
    modelController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    final canContinue =
        model == 'Other' ? modelController.text.isNotEmpty : model.isNotEmpty;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SizedBox(height: MediaQuery.of(context).viewPadding.top + 32),
                const SvgWidget(Assets.printer2),
                const SizedBox(height: 32),
                if (personalizing) ...[
                  Text(
                    finished
                        ? 'Everything is set up!'
                        : 'Personalizing the app',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: 24,
                      fontFamily: AppFonts.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    finished
                        ? 'Let’s print your files'
                        : 'It will just take a couple of seconds',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.text3,
                      fontSize: 16,
                      fontFamily: AppFonts.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SvgWidget(
                    Assets.checkbox,
                    height: 78,
                  ),
                ] else ...[
                  Text(
                    'Printer Model',
                    style: TextStyle(
                      color: colors.text,
                      fontSize: 32,
                      fontFamily: AppFonts.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please enter your printer model to continue',
                    style: TextStyle(
                      color: colors.text3,
                      fontSize: 16,
                      fontFamily: AppFonts.w500,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      models.length,
                      (index) {
                        return _ModelCard(
                          title: models[index],
                          model: model,
                          onPressed: onModel,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (model == 'Other')
                    Field(
                      controller: modelController,
                      focusNode: focusNode,
                      hintText: 'Enter your printer model',
                      fieldType: FieldType.text,
                      onChanged: (_) {
                        setState(() {});
                      },
                    ),
                ]
              ],
            ),
          ),
          ButtonWrapper(
            children: [
              if (personalizing) ...[
                Text(
                  '3%',
                  style: TextStyle(
                    color: colors.text,
                    fontSize: 16,
                    fontFamily: AppFonts.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: colors.text2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        width: finished ? MediaQuery.of(context).size.width : 0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: colors.gradient),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Searching for printers',
                      style: TextStyle(
                        color: colors.text3,
                        fontSize: 12,
                        fontFamily: AppFonts.w500,
                      ),
                    ),
                  ],
                )
              ] else
                MainButton(
                  title: 'Continue',
                  onPressed: canContinue ? onContinue : null,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ModelCard extends StatelessWidget {
  const _ModelCard({
    required this.title,
    required this.model,
    required this.onPressed,
  });

  final String title;
  final String model;
  final void Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return AnimatedContainer(
      duration: const Duration(milliseconds: Constants.milliseconds),
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colors.tertiary1,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
          color: title == model ? colors.accent : Colors.transparent,
        ),
      ),
      child: Button(
        onPressed: () {
          onPressed(title);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: colors.text,
                fontSize: 16,
                fontFamily: AppFonts.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
