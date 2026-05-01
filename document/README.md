# Auth Refactor Guide (Login Logic to Controller)

هذا الدليل يشرح بشكل عملي كيف تنقل منطق تسجيل الدخول من الشاشة إلى Controller بطريقة نظيفة وقابلة للتوسعة.

## الهدف

- فصل منطق الأعمال (Business Logic) عن الواجهة (UI)
- جعل الشاشة مسؤولة عن العرض فقط
- تسهيل الاختبار والصيانة
- توحيد نمط العمل بين login و register

## البنية المقترحة

- `lib/features/auth/controller/login_controller.dart`
- `lib/features/auth/login_screen.dart`

## 1) إنشاء LoginController

أنشئ Controller جديد يحتوي:

- `TextEditingController` للحقول
- `GlobalKey<FormState>` للفورم
- `isLoading` و `errorMessage`
- دالة `login()` ترجع `Future<bool>`

النقاط المهمة داخل `login()`:

1. ابدأ بتفعيل التحميل وتصفير الخطأ.
2. اقرأ القيم المخزنة من `PreferencesManager`.
3. إذا لا يوجد مستخدم، ارجع `false` مع رسالة واضحة.
4. قارن المدخلات مع البيانات المحفوظة.
5. عند النجاح، خزّن `isLoggedIn = true` ثم ارجع `true`.
6. في كل حالة، أوقف التحميل وحدث الواجهة عبر `safeNotifyListeners()`.

## 2) ربط الشاشة بالـ Controller

في شاشة `login_screen.dart`:

1. أضف `ChangeNotifierProvider`.
2. لف المحتوى بـ `Consumer<LoginController>`.
3. استخدم `controller.formKey` بدل متغير محلي.
4. اربط الحقول مع `controller.emailController` و `controller.passwordController`.
5. اعرض الأخطاء عبر `controller.errorMessage`.
6. اعرض `CircularProgressIndicator` حسب `controller.isLoading`.

## 3) التعامل الصحيح مع زر Sign In

داخل `onPressed`:

1. تحقق من صحة الفورم.
2. نفذ `await controller.login()`.
3. افحص `context.mounted` بعد await.
4. إذا فشل الدخول، توقف مباشرة (`return`).
5. إذا نجح، اعرض Snackbar ثم نفذ Navigation.

بهذا الشكل، الانتقال للشاشة الرئيسية يحدث فقط عند نجاح تسجيل الدخول.

## 4) إدارة الموارد (dispose)

داخل `LoginController`:

- نفذ `dispose()` وأغلق `emailController` و `passwordController`.
- لا تنشئ نفس الـ controllers داخل الشاشة عندما تستخدم Controller خارجي.

## 5) قواعد أفضل ممارسة

- لا تضع منطق المصادقة داخل `StatefulWidget`.
- اجعل دوال الـ controller ترجع نتيجة واضحة (`bool` أو `sealed result`).
- اجعل UI "غبية" (تعرض فقط) وController "ذكي" (يقرر).
- لا تنفذ `Navigator` بعد شرط نجاح/فشل بشكل غير مشروط.
- حدث الحالة دائمًا بعد كل branch نجاح/فشل.

## 6) أخطاء شائعة يجب تجنبها

- التنقل حتى عند فشل تسجيل الدخول.
- نسيان إعادة `isLoading = false` في مسارات الفشل.
- نسيان `notifyListeners` بعد تحديث الحالة.
- استخدام `Future.delayed` بدون حاجة فعلية.
- نسيان `context.mounted` بعد `await`.

## 7) الحالة الحالية في المشروع

تم تطبيق النمط بنجاح:

- منطق تسجيل الدخول في `login_controller.dart`
- الشاشة `login_screen.dart` أصبحت واجهة عرض مع Provider
- فحص الأخطاء للملفات المتعلقة بالـ auth بدون أخطاء

## 8) تحسينات مستقبلية (اختياري)

- إنشاء `AuthRepository` بدل التعامل المباشر مع `PreferencesManager` داخل Controllers.
- استبدال التخزين المحلي لكلمة المرور بحل أكثر أمانا.
- استخدام نتيجة أوضح من `bool` مثل:
  - `LoginSuccess`
  - `LoginUserNotFound`
  - `LoginInvalidCredentials`

هذا يجعل التعامل مع الأخطاء أدق وأسهل للتوسع.
