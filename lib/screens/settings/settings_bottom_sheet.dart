import 'package:flutter/material.dart';
import 'package:flutter_whirlpool/shared/colors.dart';
import 'package:flutter_whirlpool/shared/widgets/neumorphic_icon_button.dart';
import 'package:flutter_whirlpool/view_models/settings_view_model.dart';
import 'package:flutter_whirlpool/view_models/theme_view_model.dart';
import 'package:provider/provider.dart';

class SettingsBottomSheet extends StatefulWidget {
  const SettingsBottomSheet({super.key});

  @override
  SettingsBottomSheetState createState() => SettingsBottomSheetState();
}

class SettingsBottomSheetState extends State<SettingsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: CustomColors.primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<ThemeViewModel>(
            builder: (context, viewModel, _) {
              return NeumorphicIconButton(
                icon: Icon(
                  Icons.brightness_low,
                  color: CustomColors.icon,
                ),
                pressed: viewModel.darkMode,
                onTap: () {
                  // to update bottomSheet, we need to setState
                  setState(() {
                    viewModel.darkMode = !viewModel.darkMode;
                  });
                },
              );
            },
          ),
          const SizedBox(width: 50),
          Consumer<SettingsViewModel>(builder: (context, viewModel, _) {
            return NeumorphicIconButton(
              icon: Icon(
                viewModel.devMode ? Icons.blur_off : Icons.blur_on,
                color: CustomColors.icon,
              ),
              onTap: () {
                viewModel.devMode = !viewModel.devMode;
              },
            );
          }),
        ],
      ),
    );
  }
}
