import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/core/lang/app_localizations.dart';
import 'package:flutter_whirlpool/models/mode_item_model.dart';
import 'package:flutter_whirlpool/screens/main/mode_tile.dart';
import 'package:flutter_whirlpool/screens/main/top_bar.dart';
import 'package:flutter_whirlpool/screens/main/washing_machine/washing_machine_case.dart';
import 'package:flutter_whirlpool/screens/water_drawer/water_drawer.dart';
import 'package:flutter_whirlpool/shared/colors.dart';
import 'package:flutter_whirlpool/shared/consts.dart';
import 'package:flutter_whirlpool/shared/widgets.dart';
import 'package:flutter_whirlpool/view_models/language_view_model.dart';
import 'package:flutter_whirlpool/view_models/main_view_model.dart';
import 'package:flutter_whirlpool/view_models/service_locator.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static const margin = EdgeInsetsDirectional.only(
    start: GLOBAL_EDGE_MARGIN_VALUE,
  );

  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isRtl = ServiceLocator.get<LanguageViewModel>()?.isRTL ?? false;

    return Container(
      color: CustomColors.primaryColor,
      child: Scaffold(
        backgroundColor: CustomColors.primaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: SafeArea(
            child: TopBar(),
          ),
        ),
        drawer: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: _isRtl ? Radius.circular(0) : Radius.circular(45),
            bottomRight: _isRtl ? Radius.circular(0) : Radius.circular(45),
            bottomLeft: _isRtl ? Radius.circular(45) : Radius.circular(0),
            topLeft: _isRtl ? Radius.circular(45) : Radius.circular(0),
          ),
          child: Drawer(
            child: WaterDrawer(),
          ),
        ),
        drawerScrimColor: Colors.black.withAlpha(50),
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: [
                PositionedDirectional(
                  end: 0,
                  child: Transform.translate(
                    offset: Offset(_isRtl ? -100 : 100, 120),
                    child: WashingMachineCase(
                      width: 380,
                      height: 380,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 25),
                    Padding(
                      padding: margin,
                      child: Text(
                        AppLocalizations.of(context).translate("home_title"),
                        style: TextStyle(
                          fontSize: _isRtl ? 22 : 28,
                          color: CustomColors.headerColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    Padding(
                      padding: margin,
                      child: Text(
                        AppLocalizations.of(context)
                            .translate("home_sub_title"),
                        style: TextStyle(
                          fontSize: _isRtl ? 20 : 26,
                          color: CustomColors.headerColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 70),
                    Padding(
                      padding: margin,
                      child: _FunctionButtonsList(),
                    ),
                    SizedBox(height: 60),
                    _ModesList(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FunctionButtonsList extends StatelessWidget {
  const _FunctionButtonsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var margin = EdgeInsets.only(bottom: 28);
    return Consumer<MainViewModel>(
      builder: (context, viewModel, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: margin,
              child: _Indicator(
                color: viewModel?.selectedMode?.color,
                blink: viewModel.modeStatus == ModeStatus.running,
              ),
            ),
            NeumorphicIconButton(
              margin: margin,
              icon: Icon(
                Icons.power_settings_new,
                color: CustomColors.textColor,
              ),
              onTap: () => viewModel.stop(),
            ),
            NeumorphicIconButton(
              margin: margin,
              icon: Icon(
                Icons.opacity,
                color: CustomColors.textColor,
              ),
              onTap: () => Scaffold.of(context).openDrawer(),
            ),
            NeumorphicIconButton(
              margin: margin,
              icon: Icon(
                viewModel.modeStatus == ModeStatus.running
                    ? Icons.pause
                    : Icons.play_arrow,
                color: CustomColors.textColor,
              ),
              pressed: viewModel.modeStatus == ModeStatus.running,
              onTap: () => viewModel.runOrPause(),
            )
          ],
        );
      },
    );
  }
}

class _Indicator extends StatefulWidget {
  const _Indicator({
    Key key,
    this.color,
    this.blink,
  }) : super(key: key);

  final Color color;
  final bool blink;

  @override
  _IndicatorState createState() => _IndicatorState();
}

class _IndicatorState extends State<_Indicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _colorTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );

    setupAnimation();
  }

  @override
  void didUpdateWidget(_Indicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.color != oldWidget.color || widget.blink != oldWidget.blink) {
      setupAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setupAnimation() {
    Color startColor = CustomColors.textColor.withAlpha(150);
    Color endColor = CustomColors.textColor.withAlpha(150);
    if (widget.color != null) {
      startColor = widget.color;
    }

    _controller.reset();
    _colorTween =
        ColorTween(begin: startColor, end: endColor).animate(_controller);
    if (widget.blink == true) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      padding: EdgeInsets.all(8.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 7,
            offset: -Offset(6, 6),
            color: Colors.white,
          ),
          BoxShadow(
            blurRadius: 7,
            offset: Offset(6, 6),
            color: Colors.black.withAlpha(18),
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: _colorTween,
        builder: (context, child) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: _colorTween.value,
            ),
          );
        },
      ),
    );
  }
}

class _ModesList extends StatelessWidget {
  const _ModesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: MainScreen.margin,
            child: Text(
              AppLocalizations.of(context).translate("mode"),
              style: TextStyle(
                fontSize: 23,
                color: CustomColors.headerColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 14),
          Flexible(
            child: Consumer<MainViewModel>(
              builder: (context, viewModel, _) {
                return ListView.builder(
                    itemBuilder: (context, index) {
                      if (index > viewModel.nodes.length - 1) {
                        return null;
                      }
                      ModeItemModel item = viewModel.nodes[index];

                      return ModeTile(
                        pressed: viewModel?.selectedMode == item,
                        indicatorColor: item.color,
                        name: AppLocalizations.of(context).translate(item.name),
                        minutes: item.minutes,
                        disabled: viewModel.modeStatus == ModeStatus.running,
                        onTap: () => viewModel.selectMode(item),
                      );
                    },
                    scrollDirection: Axis.horizontal);
              },
            ),
          ),
        ],
      ),
    );
  }
}
