import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/models/mode_item_model.dart';
import 'package:flutter_whirlpool/screens/main/mode_tile.dart';
import 'package:flutter_whirlpool/screens/main/top_bar.dart';
import 'package:flutter_whirlpool/screens/main/whirlpool/whirlpool.dart';
import 'package:flutter_whirlpool/screens/water_drawer/water_drawer.dart';
import 'package:flutter_whirlpool/shared/colors.dart';
import 'package:flutter_whirlpool/shared/consts.dart';
import 'package:flutter_whirlpool/shared/widgets.dart';
import 'package:flutter_whirlpool/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static const margin = EdgeInsets.only(
    left: GLOBAL_EDGE_MARGIN_VALUE,
  );

  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            topRight: Radius.circular(45),
            bottomRight: Radius.circular(45),
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
                Positioned(
                  right: 0,
                  child: Transform.translate(
                    offset: Offset(95, 105),
                    child: Whirlpool(
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
                        'Smart Washing',
                        style: TextStyle(
                          fontSize: 28,
                          color: CustomColors.headerColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    Padding(
                      padding: margin,
                      child: Text(
                        'Machine',
                        style: TextStyle(
                          fontSize: 26,
                          color: CustomColors.headerColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 70),
                    Padding(
                      padding: margin,
                      child: _ButtonList(),
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

class _ButtonList extends StatelessWidget {
  const _ButtonList({Key key}) : super(key: key);

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
                color: viewModel.selectedMode?.color,
              ),
            ),
            NeumorphicIconButton(
              margin: margin,
              icon: Icon(
                Icons.power_settings_new,
                color: CustomColors.textColor,
              ),
            ),
            NeumorphicIconButton(
              margin: margin,
              icon: Icon(
                Icons.opacity,
                color: CustomColors.textColor,
              ),
            ),
            NeumorphicIconButton(
              margin: margin,
              icon: Icon(
                Icons.pause,
                color: CustomColors.textColor,
              ),
            )
          ],
        );
      },
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({Key key, @required this.color}) : super(key: key);

  final Color color;

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
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
      ),
    );
  }
}

class _ModesList extends StatelessWidget {
  const _ModesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, viewModel, _) {
        return Container(
          height: 205,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: MainScreen.margin,
                child: Text(
                  'Mode',
                  style: TextStyle(
                    fontSize: 23,
                    color: CustomColors.headerColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 14),
              Flexible(
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (index > viewModel.nodes.length - 1) {
                        return null;
                      }
                      ModeItemModel item = viewModel.nodes[index];

                      return ModeTile(
                        pressed: viewModel.selectedMode == item,
                        indicatorColor: item.color,
                        name: item.name,
                        minutes: item.minutes,
                        onTap: () => viewModel.selectedMode = item,
                      );
                    },
                    scrollDirection: Axis.horizontal),
              ),
            ],
          ),
        );
      },
    );
  }
}
