/// ============================================================================
/// ✅ GOOD EXAMPLE: Adherence to Open/Closed Principle (OCP)
/// ============================================================================
///
/// "Software entities (classes, modules, functions) should be OPEN for extension,
///  but CLOSED for modification."
///
/// WHY IS THIS GOOD?
/// 1. The abstract [Shape] class defines an interface for area calculation.
/// 2. Adding a new shape (e.g., [Triangle], [Pentagon]) only requires CREATING a new class.
/// 3. We NEVER need to modify [AreaCalculator] or any existing shape classes!
/// 4. Highly scalable, testable, and maintainable.

abstract class Shape {
  double calculateArea();
}

class Rectangle implements Shape {
  final double width;
  final double height;

  Rectangle({required this.width, required this.height});

  @override
  double calculateArea() => width * height;
}

class Circle implements Shape {
  final double radius;

  Circle({required this.radius});

  @override
  double calculateArea() => 3.14159 * radius * radius;
}

// ✅ Adding new functionality without modifying existing code!
class Triangle implements Shape {
  final double base;
  final double height;

  Triangle({required this.base, required this.height});

  @override
  double calculateArea() => 0.5 * base * height;
}

class AreaCalculator {
  double calculateTotalArea(List<Shape> shapes) {
    double totalArea = 0.0;
    for (var shape in shapes) {
      totalArea += shape.calculateArea();
    }
    return totalArea;
  }
}

void main() {
  final shapes = <Shape>[
    Rectangle(width: 10, height: 5),
    Circle(radius: 7),
    Triangle(base: 6, height: 4),
  ];

  final calculator = AreaCalculator();
  print('Total Area: ${calculator.calculateTotalArea(shapes)}');
}
