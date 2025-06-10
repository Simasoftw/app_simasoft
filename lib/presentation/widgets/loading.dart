 
import 'package:app_simasoft/core/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomPreloader extends StatefulWidget {
  const CustomPreloader({super.key});

  @override
  State<CustomPreloader> createState() => _CustomPreloaderState();
}

class _CustomPreloaderState extends State<CustomPreloader> with TickerProviderStateMixin {
  late final AnimationController _rotationController;
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;
  int _dotsCount = 0;
  late final Ticker _dotsTicker; 

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    _dotsTicker = createTicker((elapsed) {
      if (mounted) {
        setState(() {
          _dotsCount = (elapsed.inMilliseconds ~/ 500) % 4;
        });
      }
    })..start();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _dotsTicker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30), 
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 15)],
              ),
              padding: const EdgeInsets.all(15),
              child: RotationTransition(
                turns: _rotationController,
                child: ScaleTransition(
                  scale: _pulseAnimation,
                  child: ClipOval(
                    child: Image.asset(MyImages.appLogoIcon,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Cargando${'.' * _dotsCount}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
