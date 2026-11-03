# Open/Closed Principle (OCP) - مبدأ المفتوح/المغلق

## 📌 التعريف (Definition)
> "Software entities (classes, modules, functions) should be **OPEN for extension**, but **CLOSED for modification**."
> 
> "يجب أن تكون الكيانات البرمجية (الكلاسات، الموديولات، الدوال) **مفتوحة للتوسيع والإضافة**، ولكن **مغلقة أمام التعديل**."

---

## ❌ المثال السيئ (bad_ocp_example.dart)
في المثال السيئ:
- الكلاس `AreaCalculator` يحتوي على `if-else` لفحص نوع الشكل.
- كلما أردنا إضافة شكل جديد (مثل Triangle)، **نضطر لتعديل الكلاس الأساسي** وإضافة `else if` جديد.
- هذا يخالف المبدأ لأنه يفتح الكود القديم للتعديل والمخاطرة بظهور أخطاء.

---

## ✅ المثال الجيد (good_ocp_example.dart)
في المثال الجيد:
- تم إنشاء كلاس مجرد `Shape` يحتوي على دالة `calculateArea()`.
- عند إضافة شكل جديد (مثل Triangle)، نقوم بإنشاء كلاس جديد يمتد من `Shape` دون المساس بالكلاسات القديمة.
- الكلاس `AreaCalculator` أصبح مغلقاً أمام التعديل ومفتوحاً للتوسيع عبر استخدام Polymorphism.
