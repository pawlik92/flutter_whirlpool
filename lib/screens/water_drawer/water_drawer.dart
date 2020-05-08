import 'package:flutter/material.dart';
import 'package:flutter_whirlpool/core/lang/app_localizations.dart';
import 'package:flutter_whirlpool/screens/water_drawer/water_slider.dart';
import 'package:flutter_whirlpool/shared/colors.dart';
import 'package:flutter_whirlpool/shared/consts.dart';
import 'package:flutter_whirlpool/shared/widgets.dart';
import 'package:flutter_whirlpool/view_models/language_view_model.dart';
import 'package:flutter_whirlpool/view_models/main_view_model.dart';
import 'package:flutter_whirlpool/view_models/service_locator.dart';
import 'package:provider/provider.dart';

class WaterDrawer extends StatelessWidget {
  const WaterDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isRtl = ServiceLocator.get<LanguageViewModel>()?.isRTL ?? false;

    return Consumer<MainViewModel>(
      builder: (context, viewModel, _) {
        return Container(
          color: CustomColors.primaryColor,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                start: GLOBAL_EDGE_MARGIN_VALUE,
                top: DRAWER_BUTTON_MARGIN_TOP,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  NeumorphicIconButton(
                    color: Colors.white,
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                      color: CustomColors.textColor,
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  SizedBox(height: 35),
                  Text(
                    AppLocalizations.of(context).translate("choose_water"),
                    style: TextStyle(
                      fontSize: 28,
                      color: CustomColors.headerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    AppLocalizations.of(context).translate("tip_save"),
                    style: TextStyle(
                      fontSize: 16,
                      color: CustomColors.headerColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 40),
                  Expanded(
                    child: WaterSlider(
                      minValue: 200,
                      maxValue: 1200,
                      initValue: viewModel.waterValue,
                      onValueChanged: (newValue) =>
                          viewModel.waterValue = newValue,
                    ),
                  ),
                  SizedBox(height: 80),
                  Row(
                    children: <Widget>[
                      Text(
                          '${AppLocalizations.of(context).translate("current")}  ',
                          style: TextStyle(
                            color: CustomColors.headerColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          )),
                      Text(viewModel.waterValue.toStringAsFixed(0),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ))
                    ],
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
