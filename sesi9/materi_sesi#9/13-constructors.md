# Constructors

---

**Constructor** adalah fungsi khusus untuk **membuat object** dari sebuah class dan menyiapkan nilai awalnya.

> Materi ini memakai `assert` di beberapa contoh. Ingat: `assert` hanya aktif dengan `dart run --enable-asserts` (lihat materi Error Handling).

# 1. Types of constructors

| Jenis | Kegunaan |
| --- | --- |
| **Generative** | Membuat object baru dan mengisi instance variable |
| **Default** | Dipakai otomatis jika class tidak menulis constructor; tanpa nama dan tanpa parameter |
| **Named** | Memperjelas tujuan, atau membuat lebih dari satu constructor |
| **Constant** | Membuat object sebagai compile-time constant |
| **Factory** | Mengembalikan object yang sudah ada (cache) atau object dari subtype |
| **Redirecting** | Meneruskan pemanggilan ke constructor lain di class yang sama |

Subtopik 1.1–1.8 membahas masing-masing jenis.

## 1.1 Generative constructors

Constructor yang paling umum: **membuat object baru** dan mengisi instance variable. Penulisan `this.x` di parameter disebut **initializing formal parameter** (dibahas di bagian 2).

### Bentuk Dasar

```dart
class Point {
  // Instance variables to hold the coordinates of the point.
  double x;
  double y;

  // Generative constructor with initializing formal parameters:
  Point(this.x, this.y);
}
```

## Contoh 1 — Generative Constructor

```dart
class Point {
  double x;
  double y;

  Point(this.x, this.y);
}

void main() {
  var p = Point(3, 4);
  print('(${p.x}, ${p.y})');
}
```

Output:

```
(3.0, 4.0)
```

## 📍Check Point 1: Generative — Mahasiswa

Buat class `Mahasiswa` dengan `String nama`, `int semester`, dan generative constructor `Mahasiswa(this.nama, this.semester);`. Buat `Mahasiswa('Andi', 3)` dan tampilkan `<nama> - semester <semester>`.

Output yang diharapkan:

```
Andi - semester 3
```

## 1.2 Default constructors

Jika class **tidak menulis constructor sama sekali**, Dart memakai **default constructor**: generative constructor tanpa nama dan tanpa parameter.

### Bentuk Dasar

```dart
class NamaClass {
  // tidak ada constructor
}

var obj = NamaClass(); // memakai default constructor
```

## Contoh 1 — Class Tanpa Constructor

```dart
class Keranjang {
  List<String> isi = [];
  int get jumlah => isi.length;
}

void main() {
  var k = Keranjang();
  k.isi.add('Buku');
  print(k.jumlah);
}
```

Output:

```
1
```

## 📍Check Point 2: Default — Absensi

Buat class `Absensi` **tanpa constructor**, berisi `int hadir = 0;` dan `List<String> catatan = [];`. Buat object-nya, tambah `hadir` 1, tambahkan `'Pertemuan 1'` ke `catatan`, lalu tampilkan `<hadir> <catatan>`.

Output yang diharapkan:

```
1 [Pertemuan 1]
```

## 1.3 Named constructors

**Named constructor** adalah constructor dengan nama tambahan: `NamaClass.nama()`. Berguna untuk membuat **beberapa cara** membuat object, atau memperjelas tujuan.

> Subclass **tidak mewarisi** named constructor milik superclass. Jika butuh, tulis ulang di subclass.

### Bentuk Dasar

```dart
const double xOrigin = 0;
const double yOrigin = 0;

class Point {
  final double x;
  final double y;

  // Sets the x and y instance variables
  // before the constructor body runs.
  Point(this.x, this.y);

  // Named constructor
  Point.origin() : x = xOrigin, y = yOrigin;
}
```

## Contoh 1 — `Point.origin()`

```dart
const double xOrigin = 0;
const double yOrigin = 0;

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

  // Named constructor
  Point.origin() : x = xOrigin, y = yOrigin;
}

void main() {
  var p = Point.origin();
  print('(${p.x}, ${p.y})');
}
```

Output:

```
(0.0, 0.0)
```

## Contoh 2 — Named Constructor Tidak Diwariskan

```dart
class Point {
  final double x;
  Point(this.x);
  Point.origin() : x = 0;
}

class Point3 extends Point {
  Point3(super.x);
}

void main() {
  print(Point3.origin().x); // ❌ Error
}
```

Pesan error:

```
Error: Member not found: 'Point3.origin'.
```

## 📍Check Point 3: Named — Nilai Mahasiswa

Buat class `Nilai` dengan `final String nama`, `final int angka`, dan tiga constructor:

- `Nilai(this.nama, this.angka)`,
- `Nilai.kosong(this.nama)` → `angka` = `0`,
- `Nilai.sempurna(this.nama)` → `angka` = `100`.

Tampilkan `<nama>: <angka>` untuk `Nilai('Andi', 80)`, `Nilai.kosong('Siti')`, dan `Nilai.sempurna('Rina')` dengan for-in.

Output yang diharapkan:

```
Andi: 80
Siti: 0
Rina: 100
```

## 1.4 Constant constructors

Jika object dari class tidak pernah berubah, jadikan object tersebut **compile-time constant**: buat constructor `const`, dan **semua** instance variable harus `final`.

### Bentuk Dasar

```dart
class ImmutablePoint {
  static const ImmutablePoint origin = ImmutablePoint(0, 0);

  final double x, y;

  const ImmutablePoint(this.x, this.y);
}
```

## Contoh 1 — `ImmutablePoint`

```dart
class ImmutablePoint {
  static const ImmutablePoint origin = ImmutablePoint(0, 0);

  final double x, y;

  const ImmutablePoint(this.x, this.y);
}

void main() {
  var a = const ImmutablePoint(0, 0);
  print(identical(a, ImmutablePoint.origin));
  print(ImmutablePoint.origin.x);
}
```

Output:

```
true
0.0
```

Constant constructor **tidak selalu** menghasilkan konstanta. Object baru menjadi konstanta jika dibuat dengan `const` (atau di dalam constant context).

## 📍Check Point 4: Constant — Ruang Lab

Buat class `Ruang` dengan `final String kode`, `final int kapasitas`, constructor `const`, dan konstanta `static const lab = Ruang('LAB-1', 30);`. Buat `a = const Ruang('LAB-1', 30)`, lalu tampilkan `identical(a, Ruang.lab)` dan `<kode> (<kapasitas>)` dari `Ruang.lab`.

Output yang diharapkan:

```
true
LAB-1 (30)
```

## 1.5 Redirecting constructors

**Redirecting constructor** meneruskan pemanggilan ke constructor lain di class yang sama. Badannya **kosong**, dan setelah titik dua ditulis `this(...)` (bukan nama class).

### Bentuk Dasar

```dart
class Point {
  double x, y;

  // The main constructor for this class.
  Point(this.x, this.y);

  // Delegates to the main constructor.
  Point.alongXAxis(double x) : this(x, 0);
}
```

## Contoh 1 — `Point.alongXAxis`

```dart
class Point {
  double x, y;

  // The main constructor for this class.
  Point(this.x, this.y);

  // Delegates to the main constructor.
  Point.alongXAxis(double x) : this(x, 0);
}

void main() {
  var p = Point.alongXAxis(7);
  print('(${p.x}, ${p.y})');
}
```

Output:

```
(7.0, 0.0)
```

## 📍Check Point 5: Redirecting — Jadwal Pagi

Buat class `Jadwal` dengan `mataKuliah`, `hari`, `int jam`, constructor utama `Jadwal(this.mataKuliah, this.hari, this.jam)`, dan redirecting constructor `Jadwal.pagi(String mataKuliah, String hari)` yang meneruskan ke constructor utama dengan `jam` = `8`. Tampilkan hasil `Jadwal.pagi('PPB 1', 'Senin')`.

Output yang diharapkan:

```
PPB 1 Senin jam 8
```

## 1.6 Factory constructors

Constructor dengan kata kunci `factory` **tidak selalu membuat object baru**. Kegunaannya:

- mengembalikan object yang **sudah ada** (misalnya dari cache),
- mengembalikan object dari **subtype**,
- melakukan proses yang tidak bisa dilakukan di initializer list.

> Factory constructor **tidak bisa** mengakses `this`.

### Bentuk Dasar

```dart
class Logger {
  final String name;

  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  Logger._internal(this.name);
}
```

## Contoh 1 — Logger dengan Cache

```dart
class Logger {
  final String name;
  bool mute = false;

  // _cache is library-private, thanks to
  // the _ in front of its name.
  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  factory Logger.fromJson(Map<String, Object> json) {
    return Logger(json['name'].toString());
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}

void main() {
  var logger = Logger('UI');
  logger.log('Button clicked');

  var logMap = {'name': 'UI'};
  var loggerJson = Logger.fromJson(logMap);

  print(identical(logger, loggerJson));
}
```

Output:

```
Button clicked
true
```

`Logger('UI')` yang kedua (lewat `fromJson`) tidak membuat object baru, tetapi mengembalikan object yang sudah tersimpan di `_cache`. `putIfAbsent` hanya menjalankan `Logger._internal(name)` jika key belum ada.

## Contoh 2 — `this` di Factory Constructor

```dart
class Logger {
  final String name;
  Logger(this.name);

  factory Logger.salinan() {
    return Logger(name); // ❌ Error
  }
}

void main() {}
```

Pesan error:

```
Error: Undefined name 'name'.
```

Di dalam factory constructor belum ada object (`this`), sehingga property `name` tidak bisa diakses.

## 📍Check Point 6: Factory — Koneksi Server

Buat class `Koneksi` dengan:

- `static final Map<String, Koneksi> _cache = {};` dan `final String server;`,
- factory constructor `Koneksi(String server)` yang memakai `_cache.putIfAbsent(...)`,
- private named constructor `Koneksi._buat(this.server)` yang mencetak `Membuat koneksi ke <server>`.

Buat `a = Koneksi('siakad')`, `b = Koneksi('siakad')`, `c = Koneksi('elearning')`, lalu tampilkan `identical(a, b)` dan `identical(a, c)`.

Output yang diharapkan:

```
Membuat koneksi ke siakad
Membuat koneksi ke elearning
true
false
```

## 1.7 Redirecting factory constructors

**Redirecting factory constructor** meneruskan pemanggilan ke constructor class **lain** dengan sintaks `= NamaClass`. Ini sering dipakai pada abstract class agar bisa "dibuat" lewat implementasinya.

### Bentuk Dasar

```dart
factory Listenable.merge(List<Listenable> listenables) = _MergingListenable;
```

## Contoh 1 — Abstract Class dengan Factory

```dart
abstract class Hewan {
  factory Hewan.kucing(String nama) = Kucing;
  String bersuara();
}

class Kucing implements Hewan {
  final String nama;
  Kucing(this.nama);

  @override
  String bersuara() => '$nama: Meong';
}

void main() {
  var h = Hewan.kucing('Tom');
  print(h.bersuara());
  print(h.runtimeType);
}
```

Output:

```
Tom: Meong
Kucing
```

`Hewan` adalah abstract class, tetapi `Hewan.kucing('Tom')` bisa dipakai karena diteruskan ke constructor `Kucing`.

## 📍Check Point 7: Redirecting Factory — Bentuk Persegi

Buat `abstract class Bentuk` dengan method `double luas();` dan redirecting factory `factory Bentuk.persegi(double sisi) = Persegi;`. Buat class `Persegi implements Bentuk` dengan `final double sisi`. Buat `Bentuk.persegi(4)`, lalu tampilkan `runtimeType` dan `luas()`.

Output yang diharapkan:

```
Persegi
16.0
```

## 1.8 Constructor tear-offs

Constructor bisa di-**tear-off** (dikirim tanpa dipanggil), sama seperti fungsi:

- named constructor: `NamaClass.nama` (misalnya `String.fromCharCode`),
- unnamed constructor: `NamaClass.new`.

Gunakan tear-off daripada membungkusnya dengan fungsi anonim.

### Bentuk Dasar

```dart
// Use a tear-off for a named constructor:
var strings = charCodes.map(String.fromCharCode);

// Use a tear-off for an unnamed constructor:
var buffers = charCodes.map(StringBuffer.new);
```

## Contoh 1 — `String.fromCharCode` dan `StringBuffer.new`

```dart
void main() {
  var charCodes = [68, 97, 114, 116];

  // Use a tear-off for a named constructor:
  var strings = charCodes.map(String.fromCharCode);
  print(strings.toList());

  // Use a tear-off for an unnamed constructor:
  var buffers = charCodes.map(StringBuffer.new);
  print(buffers.length);
}
```

Output:

```
[D, a, r, t]
4
```

## 📍Check Point 8: Tear-offs — Daftar Mahasiswa

Buat class `Mahasiswa` dengan `final String nama`, constructor, dan override `toString()` → `Mahasiswa(<nama>)`. Ubah `['Andi', 'Siti']` menjadi list `Mahasiswa` dengan `map(Mahasiswa.new).toList()`, lalu ubah `['10', '20']` menjadi list angka dengan `map(int.parse).toList()`. Tampilkan keduanya.

Output yang diharapkan:

```
[Mahasiswa(Andi), Mahasiswa(Siti)]
[10, 20]
```

---

## 🎒 Homework

### Homework 1: Tiket Bioskop (Aplikasi Pemesanan Tiket / Cinema App)

Buat class `Tiket` dengan ketentuan:
- **Property:** `judulFilm`, `studio`, `harga` (int)
- **Generative Constructor utama:** `Tiket(this.judulFilm, this.studio, this.harga)`
- **Named Constructor:** `Tiket.vip(this.judulFilm, this.studio)` dengan `harga` otomatis `100000`
- **Redirecting Constructor:** `Tiket.promo(String judulFilm, String studio)` yang meneruskan ke constructor utama dengan diskon 50% dari harga reguler `50000` (menjadi `25000`)
- **Method:** `tampilkanTiket()` menampilkan detail tiket dalam format: `[Studio] Judul - Rp Harga`
- Di `main()`, buat:
  1. Tiket reguler: `Tiket('Dune: Part Two', 'Reguler 1', 50000)`
  2. Tiket VIP: `Tiket.vip('Oppenheimer', 'Premiere')`
  3. Tiket promo: `Tiket.promo('Spiderman', 'Reguler 2')`
  Lalu panggil `tampilkanTiket()` pada masing-masing tiket.

**Contoh output yang diharapkan:**
```
[Reguler 1] Dune: Part Two - Rp 50000
[Premiere] Oppenheimer - Rp 100000
[Reguler 2] Spiderman - Rp 25000
```

### Homework 2: Connection Pool (Backend & Database Cache)

Buat class `KoneksiDatabase` yang menerapkan caching object menggunakan **factory constructor**:
- **Property:** `final String host`, `final String port`
- **Static cache:** `static final Map<String, KoneksiDatabase> _cache = {};`
- **Private Generative Constructor:** `KoneksiDatabase._internal(this.host, this.port);`
- **Factory Constructor:** `factory KoneksiDatabase(String host, String port)`
  - Format key cache: `'$host:$port'`
  - Gunakan `_cache.putIfAbsent(key, () => KoneksiDatabase._internal(host, port))` untuk mengembalikan koneksi yang sudah ada jika host dan port sama.
- **Method:** `info()` menampilkan `Koneksi aktif -> host:port`
- Di `main()`:
  - Buat koneksi `c1 = KoneksiDatabase('localhost', '5432')`
  - Buat koneksi `c2 = KoneksiDatabase('localhost', '5432')` (host & port sama)
  - Buat koneksi `c3 = KoneksiDatabase('192.168.1.1', '3306')` (host & port beda)
  - Panggil `info()` pada `c1` dan `c3`.
  - Buktikan bahwa `c1` dan `c2` merujuk ke object yang sama dengan `identical(c1, c2)`.

**Contoh output yang diharapkan:**
```
Koneksi aktif -> localhost:5432
Koneksi aktif -> 192.168.1.1:3306
Apakah c1 dan c2 instance yang sama? true
```

---

# 2. Concise constructor syntax

Mulai Dart **3.13**, nama class di constructor boleh diganti dengan kata kunci `new` (atau langsung `factory`). Ini mengurangi pengulangan nama class yang panjang.

| Sintaks lama | Sintaks ringkas |
| --- | --- |
| `LongClassName()` | `new()` |
| `LongClassName.name()` | `new name()` |
| `const LongClassName();` | `const new();` |
| `LongClassName(): this.other();` | `new(): this.other();` |
| `factory LongClassName() { ... }` | `factory() { ... }` |
| `factory LongClassName.name() { ... }` | `factory name() { ... }` |
| `factory LongClassName() = D;` | `factory() = D;` |
| `const factory LongClassName() = D;` | `const factory() = D;` |

### Bentuk Dasar

```dart
class Point {
  double x, y;

  new(this.x, this.y);

  new origin() : x = 0, y = 0;

  factory clone(Point other) => Point(other.x, other.y);
}
```

## Contoh 1 — Sintaks Ringkas

```dart
class Point {
  double x, y;

  new(this.x, this.y);

  new origin() : x = 0, y = 0;

  factory clone(Point other) => Point(other.x, other.y);
}

void main() {
  var p = Point(1, 2);
  var o = Point.origin();
  var c = Point.clone(p);
  print('(${p.x}, ${p.y}) (${o.x}, ${o.y}) (${c.x}, ${c.y})');
}
```

Output:

```
(1.0, 2.0) (0.0, 0.0) (1.0, 2.0)
```

Cara memanggilnya **tetap sama**: `Point(...)`, `Point.origin()`, `Point.clone(...)`.

## 📍Check Point 9: Concise Syntax — Mata Kuliah

Buat class `MataKuliahPraktikum` dengan `String nama`, `int sks`, dan dua constructor dengan **sintaks ringkas**:

- `new(this.nama, this.sks);`
- `new teori(this.nama) : sks = 2;`

Tampilkan `MataKuliahPraktikum('PPB 1', 3)` dan `MataKuliahPraktikum.teori('Pancasila')` (nama dan sks).

Output yang diharapkan:

```
PPB 1 3
Pancasila 2
```

---

## 🎒 Homework

### Homework 1: Titik GPS Cabang (Aplikasi Logistik & Delivery Tracking)

Buat class `TitikGPS` yang memanfaatkan fitur **concise constructor syntax** (`new`):
- **Property:** `final double latitude`, `final double longitude`
- **Concise Constant Constructor utama:** `const new(this.latitude, this.longitude);`
- **Concise Named Constructor:** `const new origin() : latitude = 0.0, longitude = 0.0;`
- **Static constant:** `static const kantorPusat = TitikGPS(-1.8500, 109.9700);`
- **Method:** `tampilkanKoordinat()` menampilkan format `(latitude, longitude)`
- Di `main()`:
  - Buat `titikA` mengacu pada `const TitikGPS(-1.8500, 109.9700)`
  - Buat `titikB` menggunakan named constructor `TitikGPS.origin()`
  - Tampilkan koordinat `titikA` dan `titikB`.
  - Buktikan apakah `titikA` identik dengan `TitikGPS.kantorPusat` menggunakan `identical()`.

**Contoh output yang diharapkan:**
```
(-1.85, 109.97)
(0.0, 0.0)
Apakah titikA identik dengan kantorPusat? true
```

### Homework 2: Konfigurasi API Client (Aplikasi Mobile Service)

Buat class `ApiClient` dengan sintaks constructor ringkas:
- **Property:** `final String baseUrl`, `final int timeoutDetik`, `final bool useHttps`
- **Concise Constructor utama:** `new(this.baseUrl, {this.timeoutDetik = 30, this.useHttps = true});`
- **Concise Named Constructor (Development):** `new dev(String host) : baseUrl = host, timeoutDetik = 5, useHttps = false;`
- **Method:** `cetakStatus()` menampilkan detail konfigurasi:
  `Base URL: <baseUrl> | Timeout: <timeoutDetik>s | HTTPS: <useHttps>`
- Di `main()`:
  - Buat konfigurasi production: `ApiClient('api.kampus.ac.id')`
  - Buat konfigurasi dev: `ApiClient.dev('localhost:8080')`
  - Panggil `cetakStatus()` pada kedua instance.

**Contoh output yang diharapkan:**
```
Base URL: api.kampus.ac.id | Timeout: 30s | HTTPS: true
Base URL: localhost:8080 | Timeout: 5s | HTTPS: false
```

---

# 3. Instance variable initialization

Ada tiga cara mengisi nilai awal instance variable:

1. di **deklarasi**,
2. dengan **initializing formal parameter** (`this.x`),
3. dengan **initializer list** (`: x = ...`).

## 3.1 Initialize instance variables in the declaration

Isi nilai awal langsung saat variabel dideklarasikan.

### Bentuk Dasar

```dart
class PointA {
  double x = 1.0;
  double y = 2.0;
}
```

## Contoh 1 — Nilai Awal di Deklarasi

```dart
class PointA {
  double x = 1.0;
  double y = 2.0;

  // The implicit default constructor sets these variables to (1.0,2.0)
  // PointA();

  @override
  String toString() {
    return 'PointA($x,$y)';
  }
}

void main() {
  print(PointA());
}
```

Output:

```
PointA(1.0,2.0)
```

## 📍Check Point 10: Declaration — Pengaturan Aplikasi

Buat class `Pengaturan` dengan `String tema = 'terang'`, `int ukuranFont = 14`, `bool notifikasi = true`, dan override `toString()` → `Pengaturan(<tema>, <ukuranFont>, <notifikasi>)`. Tampilkan object baru, ubah `tema` menjadi `gelap`, lalu tampilkan lagi.

Output yang diharapkan:

```
Pengaturan(terang, 14, true)
Pengaturan(gelap, 14, true)
```

## 3.2 Use initializing formal parameters

`this.x` di parameter constructor langsung mengisi instance variable `x`. Cara ini juga bisa untuk variabel **non-nullable** dan **final**, serta bisa dipakai pada parameter **opsional** dan **named** (lengkap dengan nilai default).

Variabel yang dibuat dari initializing formal parameter bersifat `final` dan hanya berlaku di initializer list.

### Bentuk Dasar

```dart
class PointB {
  final double x;
  final double y;

  // Sets the x and y instance variables
  // before the constructor body runs.
  PointB(this.x, this.y);

  // Initializing formal parameters can also be optional.
  PointB.optional([this.x = 0.0, this.y = 0.0]);
}
```

## Contoh 1 — Positional, Opsional, Named, dan Nullable

```dart
class PointB {
  final double x;
  final double y;

  PointB(this.x, this.y);

  PointB.optional([this.x = 0.0, this.y = 0.0]);
}

class PointC {
  double x; // must be set in constructor
  double y; // must be set in constructor

  // Generative constructor with initializing formal parameters
  // with default values
  PointC.named({this.x = 1.0, this.y = 1.0});

  @override
  String toString() {
    return 'PointC.named($x,$y)';
  }
}

class PointD {
  double? x; // null if not set in constructor
  double? y; // null if not set in constructor

  // Generative constructor with initializing formal parameters
  PointD(this.x, this.y);

  @override
  String toString() {
    return 'PointD($x,$y)';
  }
}

void main() {
  var b = PointB.optional(5);
  print('${b.x} ${b.y}');

  // Constructor using named variables.
  final pointC = PointC.named(x: 2.0, y: 2.0);
  print(pointC);
  print(PointC.named(y: 3.0));

  print(PointD(null, 4.0));
}
```

Output:

```
5.0 0.0
PointC.named(2.0,2.0)
PointC.named(1.0,3.0)
PointD(null,4.0)
```

## 📍Check Point 11: Initializing Formals — Lokasi

Buat class `Lokasi` dengan `final double lat`, `final double lng`, override `toString()` → `Lokasi(<lat>, <lng>)`, dan tiga constructor:

- `Lokasi(this.lat, this.lng)`,
- `Lokasi.opsional([this.lat = 0.0, this.lng = 0.0])`,
- `Lokasi.named({this.lat = -1.85, this.lng = 109.97})`.

Tampilkan `Lokasi(1.0, 2.0)`, `Lokasi.opsional(5.0)`, dan `Lokasi.named(lng: 110.0)`.

Output yang diharapkan:

```
Lokasi(1.0, 2.0)
Lokasi(5.0, 0.0)
Lokasi(-1.85, 110.0)
```

## 3.3 Private named parameters

Mulai Dart **3.12**, initializing formal parameter boleh memakai field **private** pada parameter **named**: `{this._x}`. Dari sisi pemanggil, nama parameternya otomatis menjadi nama **public** (tanpa `_`): `Point(x: 1.0)`.

Aturannya:

- hanya berlaku untuk initializing formal `this._field` (dan `super._field`),
- nama public-nya tidak boleh bentrok dengan parameter lain,
- nama tanpa `_` harus berupa identifier yang valid.

### Bentuk Dasar

```dart
class Point {
  final double _x;
  Point({required this._x});
}

var p = Point(x: 1.0);
```

## Contoh 1 — Field Private dari Parameter Named

```dart
class PointPrivate {
  final double? _x;
  final double _y;

  // You can use this._x and this._y for optional parameters
  // or parameters with default values.
  PointPrivate({this._x, this._y = 0.0});

  @override
  String toString() => 'PointPrivate($_x, $_y)';
}

void main() {
  var p = PointPrivate(x: 1.0, y: 2.0);
  print(p);
  print(PointPrivate());
}
```

Output:

```
PointPrivate(1.0, 2.0)
PointPrivate(null, 0.0)
```

Sebelum fitur ini ada, kita harus menulis `PointPrivate({double? x}) : _x = x;`. Sekarang cukup `{this._x}`.

## 📍Check Point 12: Private Named — Akun

Buat class `Akun` dengan field private `final String _username`, `final int _poin`, constructor `Akun({required this._username, this._poin = 0})`, dan override `toString()` → `<username> (<poin> poin)`. Tampilkan `Akun(username: 'andi')` dan `Akun(username: 'siti', poin: 50)`.

Output yang diharapkan:

```
andi (0 poin)
siti (50 poin)
```

## 3.4 Use an initializer list

**Initializer list** ditulis setelah titik dua (`:`), **sebelum** badan constructor, dipisahkan koma. Gunanya:

- mengisi instance variable (termasuk `final`) dengan hasil perhitungan,
- memeriksa input dengan `assert` (saat pengembangan).

Ruas kanan initializer list **tidak bisa** mengakses `this`.

### Bentuk Dasar

```dart
// Initializer list sets instance variables before
// the constructor body runs.
Point.fromJson(Map<String, double> json) : x = json['x']!, y = json['y']! {
  print('In Point.fromJson(): ($x, $y)');
}
```

## Contoh 1 — Menghitung Field Final

```dart
import 'dart:math';

class Point {
  final double x;
  final double y;
  final double distanceFromOrigin;

  Point(double x, double y)
    : x = x,
      y = y,
      distanceFromOrigin = sqrt(x * x + y * y);

  Point.fromJson(Map<String, double> json) : x = json['x']!, y = json['y']!, distanceFromOrigin = 0 {
    print('In Point.fromJson(): ($x, $y)');
  }
}

void main() {
  var p = Point(3, 4);
  print(p.distanceFromOrigin);

  Point.fromJson({'x': 1, 'y': 2});
}
```

Output:

```
5.0
In Point.fromJson(): (1.0, 2.0)
```

## Contoh 2 — `assert` di Initializer List

```dart
// Jalankan dengan: dart run --enable-asserts
class Point {
  final double x, y;

  Point.withAssert(this.x, this.y) : assert(x >= 0) {
    print('In Point.withAssert(): ($x, $y)');
  }
}

void main() {
  Point.withAssert(2, 3);
  try {
    Point.withAssert(-1, 3);
  } on AssertionError {
    print('x tidak boleh negatif');
  }
}
```

Output:

```
In Point.withAssert(): (2.0, 3.0)
x tidak boleh negatif
```

## 📍Check Point 13: Initializer List — Persegi

Buat class `Persegi` dengan field final `sisi`, `luas`, dan `keliling`. Constructor `Persegi(double sisi)` memakai initializer list: `assert(sisi > 0)`, lalu mengisi `sisi`, `luas` (`sisi * sisi`), dan `keliling` (`4 * sisi`). Tampilkan ketiganya untuk `Persegi(5)`.

Output yang diharapkan:

```
5.0 25.0 20.0
```

---

## 🎒 Homework

### Homework 1: Akun Bank & Level Nasabah (Aplikasi Mobile Banking)

Buat class `AkunBank` yang memadukan **private named parameters**, **default values**, dan **initializer list**:
- **Property:**
  - `final String _noRekening` (private)
  - `final String namaNasabah`
  - `final int _saldo` (private)
  - `final String level` (dihitung otomatis)
- **Constructor:**
  - Menerima parameter named: `{required String noRekening, required this.namaNasabah, int saldoAwal = 0}`
  - Gunakan **initializer list** untuk:
    - Memvalidasi `assert(noRekening.length == 10, 'Nomor rekening harus 10 digit!')`
    - Memvalidasi `assert(saldoAwal >= 0, 'Saldo awal tidak boleh negatif!')`
    - Mengisi `_noRekening = noRekening`
    - Mengisi `_saldo = saldoAwal`
    - Mengisi `level`: jika `saldoAwal >= 5000000` maka `'Priority'`, selain itu `'Reguler'`.
- **Method:**
  - `infoAkun()` mencetak format: `[NoRek] Nama | Saldo: Rp Saldo | Level: Level`
- Di `main()`:
  - Buat akun nasabah reguler: `AkunBank(noRekening: '1234567890', namaNasabah: 'Budi Santoso', saldoAwal: 1500000)`
  - Buat akun nasabah priority: `AkunBank(noRekening: '9876543210', namaNasabah: 'Siti Aminah', saldoAwal: 10000000)`
  - Panggil `infoAkun()` pada kedua akun.

**Contoh output yang diharapkan:**
```
[1234567890] Budi Santoso | Saldo: Rp 1500000 | Level: Reguler
[9876543210] Siti Aminah | Saldo: Rp 10000000 | Level: Priority
```

### Homework 2: Profil Pasien & Hitung BMI (Aplikasi Rekam Medis Rumah Sakit)

Buat class `Pasien` dengan perhitungan nilai awal di initializer list:
- **Property:**
  - `final String nama`
  - `final double beratKg`
  - `final double tinggiMeter`
  - `final double bmi`
  - `final String statusGizi`
- **Constructor:**
  - Menerima parameter: `Pasien(this.nama, this.beratKg, this.tinggiMeter)`
  - Di **initializer list**:
    - Validasi: `assert(beratKg > 0 && tinggiMeter > 0, 'Berat dan tinggi harus lebih dari 0!')`
    - Hitung `bmi = beratKg / (tinggiMeter * tinggiMeter)`
    - Tentukan `statusGizi`: jika `(beratKg / (tinggiMeter * tinggiMeter)) < 18.5` maka `'Kurus'`, jika `< 25.0` maka `'Normal'`, selain itu `'Gemuk'`.
- **Method:** `cetakResume()` menampilkan ringkasan data pasien:
  `Pasien: nama | BMI: <bmi 1 angka di belakang koma> (<statusGizi>)`
- Di `main()`:
  - Buat `pasien1 = Pasien('Ahmad', 65.0, 1.70)`
  - Buat `pasien2 = Pasien('Rani', 45.0, 1.65)`
  - Panggil `cetakResume()` pada masing-masing pasien.

**Contoh output yang diharapkan:**
```
Pasien: Ahmad | BMI: 22.5 (Normal)
Pasien: Rani | BMI: 16.5 (Kurus)
```

---

# 4. Constructor inheritance

Subclass **tidak mewarisi** constructor dari superclass-nya. Jika subclass tidak menulis constructor, ia hanya punya default constructor.

## 4.1 Non-default superclass constructors

Saat constructor subclass dijalankan, urutannya:

1. initializer list,
2. constructor superclass (default: yang tanpa nama dan tanpa parameter),
3. badan constructor subclass.

Jika superclass **tidak punya** constructor tanpa nama dan tanpa parameter, subclass harus memanggil constructor superclass secara manual setelah titik dua: `: super.nama(...)`.

> Argumen untuk constructor superclass **tidak bisa** mengakses `this`. Misalnya, boleh memanggil static method, tetapi tidak boleh memanggil instance method.

### Bentuk Dasar

```dart
class Employee extends Person {
  Employee.fromJson(Map data) : super.fromJson(data) {
    // ...
  }
}
```

## Contoh 1 — Urutan Constructor

```dart
class Person {
  String? firstName;

  Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {
  // Person does not have a default constructor;
  // you must call super.fromJson().
  Employee.fromJson(Map data) : super.fromJson(data) {
    print('in Employee');
  }
}

void main() {
  var employee = Employee.fromJson({});
  print(employee);
}
```

Output:

```
in Person
in Employee
Instance of 'Employee'
```

Badan constructor `Person` dijalankan **lebih dulu**, baru badan constructor `Employee`.

## Contoh 2 — Lupa Memanggil Constructor Superclass

```dart
class Person {
  String? firstName;
  Person.fromJson(Map data);
}

class Employee extends Person {
  Employee(); // ❌ Error
}

void main() {}
```

Pesan error:

```
Error: The superclass, 'Person', has no unnamed constructor that takes no arguments.
```

## 📍Check Point 14: Superclass Constructor — Pegawai dan Dosen

Buat class `Pegawai` dengan `String nama` dan constructor `Pegawai.dariMap(Map<String, String> data) : nama = data['nama']!` yang badannya mencetak `Constructor Pegawai`. Buat class `Dosen extends Pegawai` dengan `String nidn` dan constructor `Dosen.dariMap(...)` yang mengisi `nidn` lewat initializer list, memanggil `super.dariMap(data)`, dan badannya mencetak `Constructor Dosen`. Buat `Dosen.dariMap({'nama': 'Sari', 'nidn': '0011223344'})`, lalu tampilkan nama dan NIDN.

Output yang diharapkan:

```
Constructor Pegawai
Constructor Dosen
Sari 0011223344
```

## 4.2 Super parameters

**Super parameter** (`super.x`) langsung meneruskan parameter ke constructor superclass, sehingga tidak perlu menulis ulang `: super(x, y)`.

- Membutuhkan language version **2.17** atau lebih baru.
- Jika pemanggilan constructor superclass sudah memakai argumen **positional**, super parameter tidak boleh positional.
- Super parameter juga bisa dipakai untuk parameter **named**.

### Bentuk Dasar

```dart
class Vector2d {
  final double x;
  final double y;

  Vector2d(this.x, this.y);
}

class Vector3d extends Vector2d {
  final double z;

  // Forward the x and y parameters to the default super constructor like:
  // Vector3d(final double x, final double y, this.z) : super(x, y);
  Vector3d(super.x, super.y, this.z);
}
```

## Contoh 1 — Positional dan Named Super Parameters

```dart
class Vector2d {
  final double x;
  final double y;

  Vector2d(this.x, this.y);
  Vector2d.named({required this.x, required this.y});
}

class Vector3d extends Vector2d {
  final double z;

  Vector3d(super.x, super.y, this.z);

  Vector3d.yzPlane({required super.y, required this.z}) : super.named(x: 0);
}

void main() {
  var v = Vector3d(1, 2, 3);
  print('${v.x} ${v.y} ${v.z}');

  var yz = Vector3d.yzPlane(y: 5, z: 6);
  print('${yz.x} ${yz.y} ${yz.z}');
}
```

Output:

```
1.0 2.0 3.0
0.0 5.0 6.0
```

## Contoh 2 — Positional Super Parameter yang Salah

```dart
class Vector2d {
  final double x;
  final double y;
  Vector2d(this.x, this.y);
}

class Vector3d extends Vector2d {
  final double z;

  Vector3d.xAxisError(super.x) : z = 0, super(0); // ❌ Error
}

void main() {}
```

Pesan error:

```
Error: Positional super-initializer parameters cannot be used when the super initializer has positional arguments.
```

## 📍Check Point 15: Super Parameters — Kendaraan

Buat class `Kendaraan` dengan `final String merek`, `final int tahun`, dan constructor. Buat class `Motor extends Kendaraan` dengan `final int cc` dan constructor `Motor(super.merek, super.tahun, this.cc)`. Tampilkan `Motor('Merek A', 2024, 150)`.

Output yang diharapkan:

```
Merek A 2024 150cc
```

---

## 🎒 Homework

### Homework 1: Sistem Kepegawaian Kampus (Pewarisan Superclass & Subclass)

Buat hierarki class pegawai kampus menggunakan **super parameters** (`super.nip`, `super.nama`, `super.gajiPokok`):
- **Superclass `Pegawai`:**
  - Property: `final String nip`, `final String nama`, `final int gajiPokok`
  - Constructor: `Pegawai(this.nip, this.nama, this.gajiPokok);`
  - Method: `int hitungTotalGaji()` yang mengembalikan `gajiPokok`.
  - Method: `info()` menampilkan rincian pegawai: `[NIP] Nama - Total Gaji: Rp Gaji`
- **Subclass `Dosen extends Pegawai`:**
  - Property tambahan: `final int jumlahSksAjar`
  - Constructor menggunakan **super parameter**: `Dosen(super.nip, super.nama, super.gajiPokok, this.jumlahSksAjar);`
  - Override `hitungTotalGaji()`: gaji pokok ditambah tunjangan SKS (`jumlahSksAjar * 50000`).
- **Subclass `Staf extends Pegawai`:**
  - Property tambahan: `final int uangLembur`
  - Constructor menggunakan **super parameter**: `Staf(super.nip, super.nama, super.gajiPokok, this.uangLembur);`
  - Override `hitungTotalGaji()`: gaji pokok ditambah `uangLembur`.
- Di `main()`:
  - Buat satu dosen: `Dosen('198501', 'Dr. Hendra', 5000000, 6)`
  - Buat satu staf: `Staf('199002', 'Dewi Lestari', 3500000, 400000)`
  - Panggil `info()` pada masing-masing objek.

**Contoh output yang diharapkan:**
```
[198501] Dr. Hendra - Total Gaji: Rp 5300000
[199002] Dewi Lestari - Total Gaji: Rp 3900000
```

### Homework 2: Tracking Armada Logistik (Constructor Chaining & Factory Multi-Format)

Buat hierarki kendaraan ekspedisi dengan urutan eksekusi constructor dan parsing multi-format:
- **Superclass `KendaraanEkspedisi`:**
  - Property: `final String platNomor`, `final String jenis`
  - Constructor: `KendaraanEkspedisi(this.platNomor, {this.jenis = 'Umum'})` dengan body:
    `print('Log Init Superclass: Kendaraan $platNomor ($jenis)');`
- **Subclass `TrukPengirim extends KendaraanEkspedisi`:**
  - Property: `final int kapasitasKg`
  - Constructor utama (chaining ke superclass):
    `TrukPengirim(super.platNomor, this.kapasitasKg) : super(jenis: 'Truk Pengangkut')` dengan body:
    `print('Log Init Subclass: Kapasitas $kapasitasKg kg');`
  - Factory constructor dari teks CSV: `factory TrukPengirim.dariCsv(String csv)`
    - Parsing teks berformat `'platNomor,kapasitasKg'` (contoh: `'KB-8899-XX,8000'`) menggunakan `.split(',')`.
    - Return instance `TrukPengirim(parts[0], int.parse(parts[1]))`.
  - Method: `cetakManifest()` mencetak format: `Armada [Plat] - Jenis: Jenis - Kapasitas: Kapasitas kg`
- Di `main()`:
  - Buat truk dari CSV: `final truk1 = TrukPengirim.dariCsv('KB-8899-XX,8000');`
  - Panggil `truk1.cetakManifest()`.

**Contoh output yang diharapkan:**
```
Log Init Superclass: Kendaraan KB-8899-XX (Truk Pengangkut)
Log Init Subclass: Kapasitas 8000 kg
Armada [KB-8899-XX] - Jenis: Truk Pengangkut - Kapasitas: 8000 kg
```

---

# Sumber

- https://dart.dev/language/constructors

