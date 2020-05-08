import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/screens/main/timer_panel.dart';
import 'package:flutter_whirlpool/shared/colors.dart';
import 'package:flutter_whirlpool/shared/consts.dart';
import 'package:flutter_whirlpool/shared/widgets.dart';
import 'package:flutter_whirlpool/view_models/dev_view_model.dart';
import 'package:flutter_whirlpool/view_models/language_view_model.dart';
import 'package:provider/provider.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.fromSTEB(
          GLOBAL_EDGE_MARGIN_VALUE, DRAWER_BUTTON_MARGIN_TOP, 18, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Consumer<DevViewModel>(builder: (context, viewModel, _) {
            return NeumorphicIconButton(
              pressed: viewModel.devMode,
              icon: Icon(
                viewModel.devMode ? Icons.blur_off : Icons.blur_on,
                color: CustomColors.textColor,
              ),
              onTap: () {
                viewModel.devMode = !viewModel.devMode;
              },
            );
          }),
          SizedBox(
            width: 25,
          ),
          Consumer<LanguageViewModel>(builder: (context, viewModel, _) {
            return NeumorphicIconButton(
              icon: Icon(
                Icons.translate,
                color: CustomColors.textColor,
              ),
              onTap: () {
                viewModel.appLocal = viewModel.appLocal;
              },
            );
          }),
          Expanded(
            child: Container(),
          ),
          TimerPanel()
        ],
      ),
    );
  }
}
