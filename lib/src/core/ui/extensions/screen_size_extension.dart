import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ScreenSizeExtension on num {
  ScreenUtil get _screenUtil => ScreenUtil();

  double get w => _screenUtil.setWidth(this);
  double get h => _screenUtil.setHeight(this);
  double get r => _screenUtil.radius(this);
  double get sp => _screenUtil.setSp(this);
  double get sw => _screenUtil.screenWidth * this;
  double get sh => _screenUtil.screenHeight * this;
  double get statusBar => _screenUtil.statusBarHeight * this;
}
