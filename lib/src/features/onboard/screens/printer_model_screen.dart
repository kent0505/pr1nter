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
      if (model == 'Other') focusNode.requestFocus();
    });
    if (model == 'Other') focusNode.requestFocus();
  }

  void onContinue() async {
    context.read<OnboardRepository>()
      ..removeOnboard()
      ..savePrinterModel(
        model == 'Other' ? modelController.text : model,
      ).then((value) {
        if (mounted) {
          context.replace(HomeScreen.routePath);
        }
      });
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
              ],
            ),
          ),
          ButtonWrapper(
            children: [
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
