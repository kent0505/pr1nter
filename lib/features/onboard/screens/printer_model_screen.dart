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

  double progress = 0.0;
  int status = 0;

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

  bool finished = false;

  void onModel(String value) {
    setState(() {
      model == value ? model = '' : model = value;
    });
    if (model == 'Other') focusNode.requestFocus();
  }

  void onContinue() async {
    if (progress == 0) {
      while (progress < 1) {
        await Future.delayed(const Duration(milliseconds: 80));
        if (mounted) {
          setState(() {
            progress += 0.01;
            if (progress > 0.3) status = 1;
            if (progress > 0.5) status = 2;
            if (progress > 0.7) status = 3;
          });
        }
      }
      setState(() {
        finished = true;
      });
    } else {
      context.read<OnboardRepository>()
        ..removeOnboard()
        ..savePrinter(
          model == 'Other' ? modelController.text : model,
        );
      if (mounted) {
        context.replace(HomeScreen.routePath);
      }
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
                if (progress != 0) ...[
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
                  AnimatedOpacity(
                    opacity: finished ? 1 : 0,
                    duration: const Duration(
                      milliseconds: Constants.milliseconds,
                    ),
                    child: const SvgWidget(
                      Assets.checkbox,
                      height: 78,
                    ),
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
              if (progress > 0 && progress < 1) ...[
                Text(
                  '${(progress * 100).round()}%',
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
                        duration: const Duration(milliseconds: 80),
                        width:
                            (MediaQuery.sizeOf(context).width - 32) * progress,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: colors.gradient),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        switch (status) {
                          0 => 'Searching for printers',
                          1 => 'Searching for printers',
                          2 => 'Optimizing',
                          3 => 'Optimizing',
                          _ => '',
                        },
                        style: TextStyle(
                          color: colors.text3,
                          fontSize: 12,
                          fontFamily: AppFonts.w500,
                        ),
                      ),
                      if (status == 1 || status == 3)
                        const Padding(
                          padding: EdgeInsetsGeometry.only(left: 4),
                          child: SvgWidget(
                            Assets.checkbox,
                            height: 16,
                          ),
                        ),
                    ],
                  ),
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
