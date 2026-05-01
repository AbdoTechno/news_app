# شرح شامل ومفصل: API و HTTP وتطبيق الأخبار
## دليل كامل من الصفر للاحترافية

---

## 📚 جدول المحتويات
1. [مقدمة عن الشبكة والإنترنت](#مقدمة)
2. [ما هو HTTP؟](#http)
3. [ما هي API؟](#api)
4. [التفكير والتخطيط لمشروع](#التخطيط)
5. [شرح الكود الخاص بك](#شرح-الكود)
6. [كيفية استعراض البيانات](#البيانات)

---

## <a id="مقدمة"></a>🌐 مقدمة عن الشبكة والإنترنت

### الإنترنت بشكل بسيط:
```
أنت (Client)  ←→  الخادم (Server)
   هاتفك           موقع الأخبار
```

- **Client (أنت)**: التطبيق على هاتفك الذي يطلب البيانات
- **Server (الخادم)**: الكمبيوتر البعيد الذي يحتفظ بالبيانات ويرسلها إليك

### مثال عملي للحياة الحقيقية:
```
أنت: "السلام عليكم، أعطيني أحدث الأخبار العلمية"
     ↓ (طلب عبر الإنترنت)
الخادم: "حسناً، انتظر شوية..."
      ↓ (معالجة الطلب)
الخادم: "تمام! إليك 10 أخبار علمية"
     ↓ (الرد)
أنت: تستقبل الأخبار وتعرضها الآن
```

---

## <a id="http"></a>🔗 ما هو HTTP؟

### تعريف HTTP:
**HTTP** = Hyper Text Transfer Protocol
- بروتوكول لنقل البيانات عبر الإنترنت
- مثل قواعد الحوار بينك وبين الخادم
- بدون HTTP لن يفهم الخادم ما تريد!

### أنواع الطلبات (Methods):

```
┌─────────────────────────────────────────────────────────────┐
│                    HTTP Methods                             │
├──────────────┬─────────────┬────────────────────────────────┤
│ Method       │ الاستخدام   │ مثال عملي                      │
├──────────────┼─────────────┼────────────────────────────────┤
│ GET          │ جلب البيانات│ احصل على أحدث الأخبار          │
│ POST         │ إرسال بيانات│ انشر تغريدة جديدة             │
│ PUT          │ تعديل كامل │ غير كل بيانات حسابك            │
│ DELETE       │ حذف بيانات │ احذف هذا المقال               │
│ PATCH        │ تعديل جزئي │ غير فقط صورة الملف             │
└──────────────┴─────────────┴────────────────────────────────┘
```

### الطلب GET (ما نستخدمه): 

```
GET /v2/top-headlines HTTP/1.1
Host: newsapi.org
```

يعني:
- **GET**: أريد استقبال بيانات (ولا أرسل بيانات حساسة)
- **/v2/top-headlines**: الموقع الذي أريده على الخادم
- **newsapi.org**: اسم الخادم

### العنوان الكامل (URL):
```
https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=YOUR_KEY

┌─────────┬────────────────┬──────────────────────┬────────────────────────────────┐
│ Protocol│    Domain      │      Path            │         Query Parameters       │
├─────────┼────────────────┼──────────────────────┼────────────────────────────────┤
│ https://│ newsapi.org    │ /v2/top-headlines    │ ?country=us&category=science   │
│         │                │                      │  &apiKey=YOUR_KEY              │
└─────────┴────────────────┴──────────────────────┴────────────────────────────────┘
```

### الرد من الخادم (Response):

```
HTTP/1.1 200 OK
Status: 200

{
  "status": "ok",
  "articles": [
    {
      "title": "Science News",
      "description": "New discovery...",
      "urlToImage": "https://...",
      "publishedAt": "2024-01-15T10:30:00Z",
      "author": "John Doe",
      "url": "https://...",
      "content": "The article content..."
    }
  ]
}
```

#### حالات الاستجابة (Status Codes):
```
┌─────────┬───────────────┬──────────────────────────────────┐
│ Code    │ المعنى        │ الشرح                            │
├─────────┼───────────────┼──────────────────────────────────┤
│ 200 OK  │ نجح ✅        │ الطلب تم بنجاح والبيانات جاهزة  │
│ 400 Bad │ خطأ في الطلب │ أنت أرسلت شيء خاطئ             │
│ 401     │ بدون تصريح    │ API Key خاطئ أو منتهي الصلاحية │
│ 404 Not │ غير موجود    │ الـ endpoint غير موجود          │
│ 429     │ طلبات كثير   │ أرسلت طلبات أكثر من المسموح    │
│ 500     │ خطأ في Server│ مشكلة من طرف الخادم            │
└─────────┴───────────────┴──────────────────────────────────┘
```

---

## <a id="api"></a>🎯 ما هي API؟

### تعريف API:
**API** = Application Programming Interface
- طريقة تواصل بين تطبيقك والخادم البعيد
- مثل القائمة في المطعم - تخبر المطعم ماذا تريد!

### مثال عملي:

```
┌─────────────────────────────────────────────────────────┐
│           تطبيق الأخبار على هاتفك                    │
│         (يستخدم NewsAPI الخاص بنا)                   │
└─────────────────────────────────────────────────────────┘
            ↓ (يطلب أحدث الأخبار)
┌─────────────────────────────────────────────────────────┐
│              News API (newsapi.org)                    │
│  ✅ /top-headlines → أحدث الأخبار                    │
│  ✅ /everything → ابحث عن أخبار معينة               │
│  ✅ /sources → قائمة المصادر                         │
└─────────────────────────────────────────────────────────┘
            ↑ (يرسل البيانات)
```

### API Endpoints في مشروعنا:

```
1️⃣ Top Headlines (أحدث الأخبار)
   GET https://newsapi.org/v2/top-headlines
   ├─ country: البلد (us, eg, gb, etc)
   ├─ category: التصنيف (general, business, science, etc)
   └─ apiKey: مفتاح الوصول الخاص بك

2️⃣ Everything (البحث الشامل)
   GET https://newsapi.org/v2/everything
   ├─ q: كلمة البحث (python, flutter, etc)
   ├─ sortBy: ترتيب النتائج (relevancy, publishedAt, etc)
   └─ apiKey: مفتاح الوصول
```

---

## <a id="التخطيط"></a>💡 التفكير والتخطيط لمشروع API

### الخطوة 1️⃣: فهم المتطلبات
```
السؤال: ماذا نريد من API؟
الإجابة:
  ✅ عرض أحدث الأخبار
  ✅ البحث عن أخبار معينة
  ✅ تصفية الأخبار حسب التصنيف
  ✅ عرض تفاصيل المقال الواحد
```

### الخطوة 2️⃣: اختيار API مناسب
```
ابحث عن:
  📌 هل API مجانية؟ ✅
  📌 كم طلب يومي؟ ✅ (500 طلب في الخطة المجانية)
  📌 البيانات جيدة؟ ✅
  📌 الموثوقية عالية؟ ✅
  📌 التوثيق كويس؟ ✅
```

### الخطوة 3️⃣: تسجيل والحصول على API Key
```
خطوات التسجيل:
1. اذهب إلى https://newsapi.org
2. سجل حساب جديد
3. ستحصل على API Key الخاص بك
4. احفظه في ApiConfig.dart (بسرية!)

⚠️ تحذير: لا تشارك API Key على Github!
```

### الخطوة 4️⃣: اختبار API باستخدام Postman

```
Postman = أداة لاختبار API قبل البرمجة

الخطوات:
1. حمل Postman (https://www.postman.com)
2. اختر GET
3. ضع الرابط:
   https://newsapi.org/v2/top-headlines?country=us&apiKey=YOUR_KEY
4. صحن Send
5. شوف النتائج!
```

### الخطوة 5️⃣: بناء معمارية المشروع

```
┌─────────────────────────────────────────────────────────┐
│               UI Layer (الواجهة)                       │
│          screens/ → widgets/ → models/                 │
└────────────────────┬────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────┐
│           Business Logic (المنطق)                      │
│          controllers/ → getters/ → setters/            │
└────────────────────┬────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────┐
│            Repository Layer (المخزن)                   │
│          repos/ → follows DIP principle                │
└────────────────────┬────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────┐
│         Data/Repository Layer (البيانات)              │
│       datasource/ → api_service/ → models/            │
└────────────────────┬────────────────────────────────────┘
                     ↓
┌─────────────────────────────────────────────────────────┐
│            Network Layer (الشبكة)                      │
│          HTTP requests ← → Servers               │
└─────────────────────────────────────────────────────────┘
```

---

## <a id="شرح-الكود"></a>📝 شرح الكود الخاص بك

### 1️⃣ ApiConfig.dart (المفتاح والإعدادات)

```dart
class ApiConfig {
  // 🔑 المفتاح السري - احفظه بأمان!
  static const String baseUrl = 'newsapi.org';
  
  // هذا هو API Key الخاص بك
  // ⚠️ لا تشاركه مع أحد!
  static const String apiKey = '8042727e17874687b578ff0a46e0585e';
  
  // 🎯 Endpoints (النقاط التي سنطلب منها)
  static const String topHeadLinesEndPoint = 'top-headlines';
  static const String everythingEndPoint = 'everything';
}
```

#### الشرح المفصل:

```
لماذا نستخدم static؟
- لأننا لا نريد إنشاء instance جديد في كل مرة
- نستخدمها مباشرة: ApiConfig.apiKey

baseUrl = 'newsapi.org'
- اسم الخادم الأساسي
- في الكود سيصبح: https://newsapi.org

apiKey = المفتاح السري
- يثبت أنك أنت من يستخدم الخدمة
- يحدد عدد الطلبات اليومية
- بدونه: "401 Unauthorized"
```

---

### 2️⃣ ApiService.dart (المرسل والمستقبل)

```dart
abstract class BaseApiService {
  // "العقد" الذي يجب أن يتبعه أي ApiService
  Future<dynamic> get(String endPoint, {Map<String, dynamic>? endPointsParam});
}

class ApiService implements BaseApiService {
  @override
  Future<dynamic> get(
    String endPoint,
    {Map<String, dynamic>? endPointsParam,}
  ) async {
    // بناء الرابط النهائي
    final url = Uri.http(ApiConfig.baseUrl, "v2/$endPoint", {
      "apiKey": ApiConfig.apiKey,
      ...?endPointsParam,
    });
    
    try {
      // إرسال الطلب GET
      final http.Response response = await http.get(url);
      
      // تحويل الـ JSON إلى خريطة (Map)
      return jsonDecode(response.body) as Map<String, dynamic>;
    } on Exception {
      // إذا حدث خطأ
      throw Exception("Failed to load data");
    }
  }
}
```

#### الشرح والتطبيق العملي:

```
الدالة: get(String endPoint, {Map<String, dynamic>? endPointsParam})

مثال 1: طلب أحدث الأخبار
────────────────────────────────
endPoint = "top-headlines"
endPointsParam = {
  "country": "us",
  "category": "science"
}

الرابط النهائي الذي سيتم بناؤه:
https://newsapi.org/v2/top-headlines?
  country=us&
  category=science&
  apiKey=8042727e17874687b578ff0a46e0585e

الخطوات:
1. Uri.http() يبني الرابط بشكل آمن
2. http.get(url) يرسل الطلب
3. await ينتظر الرد (قد يأخذ وقت!)
4. response.body يحتوي على JSON
5. jsonDecode() يحول JSON إلى Map (خريطة)
6. نعيد البيانات أو نرمي Exception

مثال 2: البحث عن أخبار
────────────────────────────────
endPoint = "everything"
endPointsParam = {
  "q": "python",
  "sortBy": "publishedAt"
}

الرابط النهائي:
https://newsapi.org/v2/everything?
  q=python&
  sortBy=publishedAt&
  apiKey=8042727e17874687b578ff0a46e0585e
```

#### لماذا async/await?

```dart
// مثال بدون async/await (الطريقة القديمة):
http.get(url).then((response) {
  print(response.body);
}).catchError((error) {
  print("خطأ: $error");
});

// مثال مع async/await (الطريقة الحديثة - أفضل):
try {
  final http.Response response = await http.get(url);
  // الآن response موجودة وجاهزة
  return jsonDecode(response.body);
} on Exception {
  throw Exception("Failed to load data");
}
```

الفرق:
- `async` يخبر Dart: "هذه الدالة قد تأخذ وقت"
- `await` يقول: "انتظر حتى تنتهي العملية ثم استمر"
- يجعل الكود أسهل للقراءة والفهم

---

### 3️⃣ NewsRepository.dart (معالج البيانات)

```dart
abstract class BaseNewsRepository {
  // العقد الذي يجب أن يتبعه Repository
  Future<List<NewsArticleModel>> getTopHeadLine({String? category});
  Future<List<NewsArticleModel>> getEverything({String? query});
}

class NewsRepository extends BaseNewsRepository {
  NewsRepository(this.apiService); // الحقن
  final BaseApiService apiService;
  
  @override
  Future<List<NewsArticleModel>> getTopHeadLine({String? category}) async {
    // خطوة 1: استدعاء API
    Map<String, dynamic> result = await apiService.get(
      ApiConfig.topHeadLinesEndPoint,
      endPointsParam: {"country": "us", "category": category?.toLowerCase()},
    );
    
    // خطوة 2: تحويل النتائج إلى قائمة Articles
    return (result["articles"] as List)
        .map((e) => NewsArticleModel.fromJson(e))
        .toList();
  }
  
  @override
  Future<List<NewsArticleModel>> getEverything({String? query = "news"}) async {
    // نفس الفكرة لكن مع everything endpoint
    Map<String, dynamic> result = await apiService.get(
      ApiConfig.everythingEndPoint,
      endPointsParam: {"q": query},
    );
    return (result["articles"] as List?)
            ?.map((e) => NewsArticleModel.fromJson(e))
            .toList() ??
        [];
  }
}
```

#### الشرح:

```
Repository = المستودع
- يتوسط بين Controller و API Service
- يعالج البيانات وتحويلها
- يسهل التبديل بين مصادر البيانات

الفكرة:
1. استدعاء ApiService للحصول على JSON
2. تحويل JSON إلى NewsArticleModel
3. إرجاع قائمة من الـ Models

الفائدة:
- فصل الاهتمامات (Separation of Concerns)
- إذا غيرنا API، نغير Repository فقط!
- العقل (Controller) لا يعرف تفاصيل التطبيق
```

#### شرح .map() و .toList():

```dart
// البيانات من API تبدو هكذا:
{
  "articles": [
    {"title": "News 1", "description": "...", ...},
    {"title": "News 2", "description": "...", ...},
    {"title": "News 3", "description": "...", ...}
  ]
}

// الخطوة 1: استخراج قائمة المقالات
result["articles"] as List
// النتيجة:
// [
//   {"title": "News 1", ...},
//   {"title": "News 2", ...},
//   {"title": "News 3", ...}
// ]

// الخطوة 2: تحويل كل مقال من JSON إلى NewsArticleModel
.map((e) => NewsArticleModel.fromJson(e))
// النتيجة: Stream من NewsArticleModel

// الخطوة 3: تحويل إلى قائمة عادية
.toList()
// النتيجة:
// [
//   NewsArticleModel(title: "News 1", ...),
//   NewsArticleModel(title: "News 2", ...),
//   NewsArticleModel(title: "News 3", ...)
// ]
```

---

### 4️⃣ MockNewsRepository.dart (للاختبار بدون إنترنت)

```dart
class MockNewsRepository extends BaseNewsRepository {
  // نفس الواجهة لكن بيانات وهمية
  // للاختبار بدون الحاجة للإنترنت
  
  @override
  Future<List<NewsArticleModel>> getTopHeadLine({String? category}) async {
    return [
      NewsArticleModel(
        title: "Mock News Article 1",
        description: "This is a mock news article for testing.",
        urlToImage: "https://via.placeholder.com/150",
        publishedAt: DateTime.now(),
        author: '',
        url: '',
        content: '',
      ),
      // ... أخبار وهمية أخرى
    ];
  }
}
```

#### الفائدة:
```
✅ اختبار الـ UI بدون إنترنت
✅ اختبار بسرعة كبيرة
✅ لا تضيع الحد اليومي من الطلبات أثناء التطوير
✅ بيانات ثابتة وقابلة للتنبؤ
```

---

## <a id="البيانات"></a>📊 كيفية استعراض البيانات

### رحلة البيانات من الخادم إلى الشاشة:

```
1️⃣ Users يضغط زر "Get News"
   ↓
2️⃣ Controller استدعاء Repository
   repository.getTopHeadLine(category: "science")
   ↓
3️⃣ Repository استدعاء Api Service
   apiService.get(
     "top-headlines",
     endPointsParam: {"country": "us", "category": "science"}
   )
   ↓
4️⃣ ApiService بناء الرابط وإرسال الطلب
   GET https://newsapi.org/v2/top-headlines?
       country=us&category=science&apiKey=KEY
   ↓
5️⃣ الخادم معالجة الطلب والرد
   HTTP/1.1 200 OK
   {
     "status": "ok",
     "totalResults": 1000,
     "articles": [...]
   }
   ↓
6️⃣ ApiService استقبال الرد وتحويله
   jsonDecode(response.body)
   ↓
7️⃣ Repository تحويل JSON إلى Models
   result["articles"].map((e) => NewsArticleModel.fromJson(e))
   ↓
8️⃣ Controller عرض البيانات في الشاشة
   setState(() {
     articles = result;
   });
   ↓
9️⃣ UI عرض الأخبار للمستخدم
   ListView.builder(
     itemCount: articles.length,
     itemBuilder: (context, index) {
       return ArticleCard(article: articles[index]);
     }
   )
```

### مثال كامل في Controller:

```dart
class HomeController extends ChangeNotifier {
  final BaseNewsRepository newsRepository;
  
  List<NewsArticleModel> articles = [];
  bool isLoading = false;
  String? errorMessage;
  
  HomeController(this.newsRepository);
  
  Future<void> fetchNews(String category) async {
    // 1. ابدأ التحميل
    isLoading = true;
    errorMessage = null;
    notifyListeners(); // أخبر الـ UI بالتحديث
    
    try {
      // 2. اطلب البيانات من Repository
      final result = await newsRepository.getTopHeadLine(
        category: category
      );
      
      // 3. حفظ البيانات
      articles = result;
      
      // 4. أخبر الـ UI بأن البيانات جاهزة
      isLoading = false;
      notifyListeners();
    } catch (e) {
      // 5. إذا حدث خطأ
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }
}
```

### شرح الحالات:

```
┌─────────────┬──────────────────────┬──────────────────────┐
│ الحالة      │ isLoading            │ UI يعرض              │
├─────────────┼──────────────────────┼──────────────────────┤
│ البداية     │ false                │ زر "Get News"        │
│             │                      │                      │
│ أثناء الطلب │ true                 │ Loading Spinner      │
│             │                      │ (دوران محمل)        │
│             │                      │                      │
│ النجاح      │ false                │ قائمة الأخبار        │
│             │                      │                      │
│ الفشل       │ false                │ رسالة الخطأ          │
└─────────────┴──────────────────────┴──────────────────────┘
```

---

## 🔍 خطوات تطبيق الشرح على مشروعك

### الخطوة 1: فهم التدفق

```
User Interface
     ↓
Controller (Business Logic - يدير الحالة)
     ↓
Repository (معالجة البيانات)
     ↓
ApiService (إرسال الطلبات)
     ↓
newsapi.org (الخادم البعيد)
```

### الخطوة 2: متابعة البيانات

```dart
// في HomeController:
Future<void> fetchTopHeadlines(String category) async {
  print("1️⃣ بدء الطلب...");
  
  try {
    final articles = await newsRepository.getTopHeadLine(
      category: category
    );
    
    print("2️⃣ استقبلنا ${articles.length} مقال");
    
    this.articles = articles;
    isLoading = false;
    notifyListeners();
    
    print("3️⃣ عدد بيانات بنجاح!");
  } catch (e) {
    print("❌ خطأ: $e");
    errorMessage = e.toString();
    isLoading = false;
    notifyListeners();
  }
}
```

### الخطوة 3: اختبار مع Postman

```
1. حمل Postman من https://www.postman.com
2. اختر GET
3. صح الرابط:
   https://newsapi.org/v2/top-headlines?
   country=us&category=science&apiKey=8042727e17874687b578ff0a46e0585e
4. صحن Send
5. شوف النتائج المالي
```

---

## ❌ الأخطاء الشائعة والحلول

### 1. خطأ: "401 Unauthorized"
```
السبب: API Key خاطئ أو منتهي الصلاحية
الحل:
  ✅ تأكد أن API Key صحيح في ApiConfig
  ✅ تحقق من صلاحية الحساب على newsapi.org
```

### 2. خطأ: "429 Too Many Requests"
```
السبب: طلبت أكثر من 500 طلب في اليوم (الحد مجاني)
الحل:
  ✅ انتظر حتى غداً
  ✅ ادفع للحصول على حد أكثر
  ✅ استخدم MockRepository أثناء التطوير
```

### 3. خطأ: "null"
```
السبب: البيانات لم تحمل بعد عند محاولة عرضها
الحل:
  ✅ تحقق من isLoading قبل عرض البيانات
  ✅ استخدم FutureBuilder أو Consumer
  ✅ تأكد من await الدالة
```

### 4. خطأ: "Connection Timeout"
```
السبب: الإنترنت معطل أو الخادم بطيء
الحل:
  ✅ تحقق من الإنترنت
  ✅ أعد المحاولة
  ✅ أضف timeout مناسب
```

---

## 📚 معلومات إضافية مهمة

### مفاهيم أساسية يجب تفهمها:

#### 1. Dependency Injection (الحقن)
```dart
// بدل هذا (صعب للاختبار):
class HomeController {
  final ApiService apiService = ApiService();
}

// افعل هذا (سهل للاختبار):
class HomeController {
  final BaseApiService apiService;
  HomeController(this.apiService); // حقن المعامل
}

// الآن يمكنك استخدام:
final controller = HomeController(ApiService()); // API حقيقي
final testController = HomeController(MockApiService()); // API وهمي
```

#### 2. Abstract Classes (الطبقات المجردة)
```dart
// العقد - ماذا يجب أن يفعل أي ApiService
abstract class BaseApiService {
  Future<dynamic> get(String endPoint, {Map<String, dynamic>? endPointsParam});
}

// التطبيق - كيف يفعل ApiService هذا
class ApiService implements BaseApiService {
  @override
  Future<dynamic> get(...) async {
    // التطبيق الفعلي
  }
}

// الفائدة: يمكنك تبديل التطبيق والواجهة تبقى نفسها!
```

#### 3. JSON Serialization
```dart
// JSON من الخادم:
{
  "title": "News Title",
  "description": "News Description",
  "urlToImage": "https://...",
  "publishedAt": "2024-01-15T10:30:00Z"
}

// تحويله إلى Dart Object:
NewsArticleModel.fromJson(json) قيمة:
NewsArticleModel(
  title: "News Title",
  description: "News Description",
  urlToImage: "https://...",
  publishedAt: DateTime.parse("2024-01-15T10:30:00Z")
)
```

---

## 🎓 الخلاصة - كيف افكر وابدي مشروع API:

### 1. التخطيط والفهم
- [ ] أفهم المتطلبات
- [ ] اختار API مناسبة
- [ ] أدرس التوثيق
- [ ] أسجل واحصل على مفتاح

### 2. التصميم
- [ ] ارسم معمارية التطبيق
- [ ] حدد الـ Models
- [ ] خطط الـ Repository و Service

### 3. التطوير
- [ ] اعمل ApiConfig
- [ ] اعمل ApiService
- [ ] اعمل Repository
- [ ] اعمل Controller
- [ ] اعمل UI

### 4. الاختبار
- [ ] اختبر مع Postman أولاً
- [ ] اختبر مع MockRepository
- [ ] اختبر الأخطاء والحالات الحدية

### 5. النشر والصيانة
- [ ] أخفِ API Key (استخدم .env)
- [ ] أضف معالجة أخطاء قوية
- [ ] راقب الأداء والطلبات

---

## 🚀 الخطوات التالية لتحسين التطبيق:

```dart
// 1. أضف Caching:
// احفظ البيانات محلياً لتجنب الطلبات غير الضرورية

// 2. أضف Pagination:
// حمل البيانات حسب الطلب (صفحات بدل كل شيء)

// 3. أضف Search advanced:
// ابحث بشروط متعددة

// 4. أضف offline mode:
// اعرض البيانات المحفوظة حتى في بدون إنترنت

// 5. أضف Real-time updates:
// استخدم WebSocket للتحديثات الفورية
```

---

**محرر بواسطة**: فريق التطوير  
**التاريخ**: 2024  
**الحالة**: مكتمل وجاهز للمرجع

