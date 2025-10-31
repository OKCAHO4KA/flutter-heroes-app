import 'package:prueba_jun/library.dart';

class UsefulMethods {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  void showSnackBar({
    required String message,
    String? textContent,
    SnackBarType type = SnackBarType.normal,
    int durationInSeconds = 38888,
    VoidCallback? tapIconCallback,
  }) {
    final context =
        navigatorKey.currentContext ??
        appRoute.routerDelegate.navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarWidget.getSnackBar(
          message: message,
          textContent: textContent,
          type: type,
          tapIconCallback: () =>
              ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          durationInSeconds: durationInSeconds,
        ),
      );
    } else {
      Exception();
    }
  }
}

class SnackBarWidget {
  static SnackBar getSnackBar({
    required String message,
    String? textContent,
    SnackBarType type = SnackBarType.normal,
    String? icon,
    String? actionLabel,
    int durationInSeconds = 5,
    VoidCallback? tapIconCallback,
  }) {
    return SnackBar(
      backgroundColor: Colors.transparent,
      width: 360,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(8.0),
      elevation: 0,
      content: Center(
        child: SnackBarContentWidget(
          tapIconCallback: () {
            tapIconCallback != null ? tapIconCallback() : null;
          },
          messageHeader: message,
          textContent: textContent,
          type: type,
        ),
      ),
      duration: Duration(seconds: durationInSeconds),
    );
  }
}

class _SnackBarAppearance {
  final Color backgroundColor;
  final Color backgroundColor2;
  final Color textColor;

  _SnackBarAppearance({
    required this.backgroundColor,
    required this.backgroundColor2,
    required this.textColor,
  });

  static _SnackBarAppearance fromType(UIThemes theme, SnackBarType type) {
    switch (type) {
      case SnackBarType.normal:
        return _SnackBarAppearance(
          backgroundColor: theme.backgroundPrimary,
          backgroundColor2: theme.greenAccent,
          textColor: theme.textColorDefault,
        );
      case SnackBarType.error:
        return _SnackBarAppearance(
          backgroundColor: theme.backgroundPrimary,
          backgroundColor2: theme.redColor,
          textColor: theme.redColor,
        );
    }
  }
}

class SnackBarContentWidget extends StatelessWidget {
  const SnackBarContentWidget({
    super.key,
    required this.messageHeader,
    this.type = SnackBarType.normal,
    this.textContent,
    this.tapIconCallback,
  });

  final String messageHeader;
  final String? textContent;
  final SnackBarType type;
  final VoidCallback? tapIconCallback;

  @override
  Widget build(BuildContext context) {
    final theme = UIThemes.of(context);
    final appearance = _SnackBarAppearance.fromType(theme, type);

    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(GeneralConstants.borderRadiusSnackBar),
      ),
      child: Container(
        height: 84,
        decoration: BoxDecoration(
          color: theme.whiteColor.withValues(alpha: 0.9),
          border: Border.all(color: appearance.backgroundColor2),
          borderRadius: const BorderRadius.all(
            Radius.circular(GeneralConstants.borderRadiusSnackBar),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 84,
              decoration: BoxDecoration(color: appearance.backgroundColor2),
            ),
            Container(
              width: 336,
              height: 84,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(
                    GeneralConstants.borderRadiusSnackBar,
                  ),
                  bottomRight: Radius.circular(
                    GeneralConstants.borderRadiusSnackBar,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        child: Text(
                          messageHeader,
                          style: theme.bold20.copyWith(
                            color: appearance.textColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          textContent ?? '',
                          style: theme.medium15.copyWith(
                            color: appearance.textColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 45,
                    child: GestureDetector(
                      onTap: () async {
                        tapIconCallback != null ? tapIconCallback!() : null;
                      },
                      child: Icon(Icons.cancel),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
