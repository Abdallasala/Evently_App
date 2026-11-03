/// ============================================================================
/// ❌ BAD EXAMPLE: Violation of Open/Closed Principle (OCP)
/// ============================================================================
///
/// WHY IS THIS BAD?
/// 1. The [AreaCalculator] class is NOT closed for modification.
/// 2. Every time we add a new shape (e.g., Triangle, Polygon, Circle), we MUST
///    modify the existing [calculateArea] method by adding more if-else / switch cases.
/// 3. Modifying existing tested code increases the risk of introducing bugs into 
///    already working features.

enum ShapeType { rectangle, circle, triangle }

class Shape {
  final ShapeType type;
  final double? width;
  final double? height;
  final double? radius;

  Shape({
    required this.type,
    this.width,
    this.height,
    this.radius,
  });
}

class AreaCalculator {
  double calculateArea(Shape shape) {
    if (shape.type == ShapeType.rectangle) {
      return (shape.width ?? 0) * (shape.height ?? 0);
    } else if (shape.type == ShapeType.circle) {
      return 3.14159 * (shape.radius ?? 0) * (shape.radius ?? 0);
    } else if (shape.type == ShapeType.triangle) {
      // ❌ We had to MODIFY this existing class to add Triangle support!
      return 0.5 * (shape.width ?? 0) * (shape.height ?? 0);
    }
    return 0.0;
  }
}
