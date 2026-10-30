import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_pro/core/routing/app_routes.dart';
import 'package:stream_pro/core/shared/widgets/stream_pro_logo.dart';
import 'package:stream_pro/core/utils/extensions/get_app_theme.dart';
import 'package:stream_pro/core/utils/extensions/navigation_extension.dart';
import 'package:stream_pro/feature/auth/presentation/controller/splash_cubit/splash_cubit.dart';
import 'package:stream_pro/generated/l10n.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;
  late final Animation<double> _textFade;
  late final Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: kSplashAnimationDuration,
    );

    _logoFade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    _logoScale = Tween(begin: 1.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    _textFade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.85, curve: Curves.easeOut),
      ),
    );

    _textSlide = Tween(begin: const Offset(0, 0.25), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.85, curve: Curves.easeOutCubic),
      ),
    );

    // Start the animation AND the refresh flow at the same time
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticated) {
            context.navigateToAndClearStack(AppRoutes.main);
          } else if (state is SplashUnauthenticated) {
            context.navigateToAndClearStack(AppRoutes.login);
          }
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated logo (zoom out + fade in)
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) => Opacity(
                  opacity: _logoFade.value,
                  child: Transform.scale(
                    scale: _logoScale.value,
                    child: StreamProLogo(size: 110.w),
                  ),
                ),
              ),
              SizedBox(height: 28.h),

              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) => Opacity(
                  opacity: _textFade.value,
                  child: FractionalTranslation(
                    translation: _textSlide.value,
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (rect) => LinearGradient(
                        colors: [
                          appTheme.blueAccent,
                          appTheme.tealAccent,
                          appTheme.purpleTint,
                          appTheme.pinkAccent,
                        ],
                      ).createShader(rect),
                      child: Text(
                        S.current.streamPro,
                        style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          color: context.appTheme.surfaceColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
