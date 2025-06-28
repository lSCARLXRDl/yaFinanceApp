import 'dart:math';
import 'package:flutter/material.dart';

class ParticleContainer extends StatefulWidget {
  final int particleCount;
  final Color particleColor;
  final double width;
  final double height;

  const ParticleContainer({
    super.key,
    this.particleCount = 50,
    this.particleColor = const Color(0xFF2AE881),
    this.width = 30,
    this.height = 20,
  });

  @override
  State<ParticleContainer> createState() => _ParticleContainerState();
}

class Particle {
  Offset position;
  Offset velocity;
  double radius;
  Color color;

  Particle({
    required this.position,
    required this.velocity,
    required this.radius,
    required this.color,
  });
}

class _ParticleContainerState extends State<ParticleContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _initializeParticles();
    _controller.addListener(_updateParticles);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateParticles);
    _controller.dispose();
    super.dispose();
  }

  void _initializeParticles() {
    _particles = List.generate(widget.particleCount, (index) {
      return Particle(
        position: Offset(
          _random.nextDouble() * widget.width,
          _random.nextDouble() * widget.height,
        ),
        velocity: Offset(
          (_random.nextDouble() - 0.5) * 0.8,
          (_random.nextDouble() - 0.5) * 0.8,
        ),
        radius: 1.5 + _random.nextDouble() * 1.5,
        color: widget.particleColor,
      );
    });
  }

  void _updateParticles() {
    if (!mounted) return;

    setState(() {
      for (var particle in _particles) {
        particle.position += particle.velocity;

        if (particle.position.dx <= 0 || particle.position.dx >= widget.width) {
          particle.velocity = Offset(-particle.velocity.dx, particle.velocity.dy);
        }
        if (particle.position.dy <= 0 || particle.position.dy >= widget.height) {
          particle.velocity = Offset(particle.velocity.dx, -particle.velocity.dy);
        }

        particle.position = Offset(
          particle.position.dx.clamp(0, widget.width),
          particle.position.dy.clamp(0, widget.height),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(
        painter: _ParticlePainter(particles: _particles),
      ),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  _ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final particle in particles) {
      paint.color = particle.color;
      canvas.drawCircle(particle.position, particle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) {
    return true;
  }
}