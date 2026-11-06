# Classes

---

Dart adalah bahasa **berorientasi objek**. Setiap object adalah **instance** dari sebuah **class**, dan semua class (kecuali `Null`) merupakan turunan dari `Object`.

- **Class** = cetakan (blueprint).
- **Object/instance** = hasil cetakan, dibuat dengan **constructor**.
- **Member** class = **data** (variabel) dan **fungsi** (method).

Di materi Pengenalan Dasar kita sudah membuat class sederhana. Materi ini membahas cara memakai class lebih rinci.

# 1. Class

## Bentuk Dasar

```dart
class NamaClass {
  // 1. Property (atribut/data)
  String property1;
  int property2;

  // 2. Constructor (dipanggil saat object dibuat)
  NamaClass(this.property1, this.property2);

  // 3. Method (perilaku/aksi)
  void namaMethod() {
    print('Property1: $property1');
  }
}

void main() {
  // 4. Membuat object (instance) dari class
  var obj = NamaClass('nilai', 10);
  obj.namaMethod();
}
```

| Bagian | Fungsi |
|---|---|
| **Class** | Cetakan (blueprint) |
| **Property** | Data yang dimiliki object |
| **Constructor** | Mengisi data awal saat object dibuat |
| **Method** | Aksi yang bisa dilakukan object |
| **Object** | Hasil nyata dari cetakan |

---

## 📍 Check Point: Data Karyawan (Sistem HRD)

```dart
class Karyawan {
  String nama;
  String jabatan;
  double gaji;

  Karyawan(this.nama, this.jabatan, this.gaji);

  void tampilkanInfo() {
    print('Nama    : $nama');
    print('Jabatan : $jabatan');
    print('Gaji    : Rp $gaji');
  }

  void naikGaji(double persen) {
    gaji = gaji + (gaji * persen / 100);
    print('$nama naik gaji $persen%, gaji baru: Rp $gaji');
  }
}

void main() {
  var k1 = Karyawan('Budi', 'Backend Developer', 8000000);
  var k2 = Karyawan('Sari', 'UI/UX Designer', 7500000);

  k1.tampilkanInfo();
  k1.naikGaji(10);

  print('---');
  k2.tampilkanInfo();
}
```

**Output:**
```
Nama    : Budi
Jabatan : Backend Developer
Gaji    : Rp 8000000.0
Budi naik gaji 10%, gaji baru: Rp 8800000.0
---
Nama    : Sari
Jabatan : UI/UX Designer
Gaji    : Rp 7500000.0
```

Satu class `Karyawan` bisa dipakai untuk membuat banyak object (`k1`, `k2`) dengan data berbeda.

---

## 🎒 Homework

### Homework 1: Stok Produk (Aplikasi Gudang/Inventory)

Buat class `Produk` dengan ketentuan:
- **Property:** `kode`, `nama`, `harga`, `stok`
- **Method:**
  - `tambahStok(int jumlah)` untuk menambah stok
  - `kurangiStok(int jumlah)`: jika stok tidak cukup, tampilkan `"Stok tidak mencukupi!"`
  - `tampilkanInfo()` untuk menampilkan semua data produk
- Di `main()`, buat **minimal 2 produk**, lalu uji ketiga method tersebut.

**Contoh output yang diharapkan:**
```
[P001] Laptop Asus - Rp 9500000 | Stok: 5
Stok ditambah 3, stok sekarang: 8
Stok tidak mencukupi!
```

### Homework 2: Task Manager (Aplikasi Manajemen Proyek, seperti Trello/Jira)

Buat class `Task` dengan ketentuan:
- **Property:** `judul`, `assignee` (orang yang mengerjakan), `deadline` (String), `status` (default `"To Do"`)
- **Method:**
  - `mulaiKerjakan()` mengubah status menjadi `"In Progress"`
  - `selesaikan()` mengubah status menjadi `"Done"`
  - `tampilkanTask()` menampilkan detail task
- Di `main()`, buat **3 task** untuk satu tim proyek, lalu ubah status masing-masing secara berbeda.

**Petunjuk:** nilai default bisa diisi langsung pada property:
```dart
String status = 'To Do';
```

# 2. Using constructors
## Bentuk Dasar

```dart
class NamaClass {
  String a;
  int b;

  // 1. Constructor biasa (positional)
  NamaClass(this.a, this.b);

  // 2. Constructor dengan named parameter
  // NamaClass({required this.a, this.b = 0});

  // 3. Named constructor (constructor alternatif)
  NamaClass.versiLain(this.a) : b = 0;
}

void main() {
  var obj1 = NamaClass('data', 10);       // positional
  var obj2 = NamaClass.versiLain('data'); // named constructor
}
```

| Jenis | Ciri | Kapan dipakai |
|---|---|---|
| **Positional** | `NamaClass(this.a, this.b)` | Parameter sedikit, urutan jelas |
| **Named parameter** | `NamaClass({required this.a})` | Parameter banyak, agar tidak tertukar |
| **Default value** | `this.b = 0` | Ada nilai bawaan jika tidak diisi |
| **Named constructor** | `NamaClass.nama()` | Butuh lebih dari satu cara membuat object |

Satu class hanya boleh punya **satu** constructor tanpa nama, sehingga cara pembuatan lainnya menggunakan named constructor.

---

## 📍 Check Point: Pesanan (Aplikasi E-Commerce)

```dart
class Pesanan {
  String idPesanan;
  String pelanggan;
  double total;
  String metodeBayar;

  // Constructor dengan named parameter + default value
  Pesanan({
    required this.idPesanan,
    required this.pelanggan,
    required this.total,
    this.metodeBayar = 'Transfer Bank',
  });

  // Named constructor khusus pesanan COD
  Pesanan.cod(this.idPesanan, this.pelanggan, this.total)
      : metodeBayar = 'COD';

  void tampilkan() {
    print('[$idPesanan] $pelanggan - Rp $total ($metodeBayar)');
  }
}

void main() {
  var p1 = Pesanan(idPesanan: 'ORD001', pelanggan: 'Andi', total: 250000);
  var p2 = Pesanan(idPesanan: 'ORD002', pelanggan: 'Rina', total: 120000, metodeBayar: 'E-Wallet');
  var p3 = Pesanan.cod('ORD003', 'Doni', 90000);

  p1.tampilkan();
  p2.tampilkan();
  p3.tampilkan();
}
```

**Output:**
```
[ORD001] Andi - Rp 250000.0 (Transfer Bank)
[ORD002] Rina - Rp 120000.0 (E-Wallet)
[ORD003] Doni - Rp 90000.0 (COD)
```

`p1` memakai nilai default, `p2` mengganti nilai default, dan `p3` dibuat lewat named constructor.

---

## 🎒 Homework

### Homework 1: Akun Pengguna (Sistem Login Aplikasi)

Buat class `User` dengan ketentuan:
- **Property:** `username`, `email`, `role`, `isActive`
- **Constructor utama** (named parameter): `username` dan `email` wajib (`required`), `role` default `"member"`, `isActive` default `true`
- **Named constructor:**
  - `User.admin(username, email)` dengan `role` otomatis `"admin"`
  - `User.guest()` dengan username `"guest"`, email `"-"`, role `"viewer"`
- Method `tampilkanProfil()`
- Di `main()`, buat 1 member, 1 admin, dan 1 guest.

**Contoh output yang diharapkan:**
```
budi | budi@mail.com | member | aktif: true
siti | siti@kantor.com | admin | aktif: true
guest | - | viewer | aktif: true
```

### Homework 2: Invoice (Aplikasi Kasir/Billing)

Buat class `Invoice` dengan ketentuan:
- **Property:** `nomor`, `namaKlien`, `subtotal`, `pajak` (persen), `diskon` (persen)
- **Constructor** (named parameter): `pajak` default `11`, `diskon` default `0`
- **Named constructor** `Invoice.member(...)` dengan diskon otomatis `10`
- Method `hitungTotal()` dengan rumus: subtotal − diskon + pajak
- Method `cetak()` menampilkan rincian invoice beserta totalnya
- Di `main()`, buat 1 invoice biasa dan 1 invoice member, lalu bandingkan totalnya.

**Petunjuk:** hitung diskon lebih dulu, lalu pajak dari harga setelah diskon.

# 4. Instance variables
## Bentuk Dasar

Instance variable adalah **variabel milik setiap object**. Setiap object menyimpan salinan datanya sendiri.

```dart
class NamaClass {
  String a;              // 1. Biasa: wajib diisi lewat constructor
  int b = 0;             // 2. Default value: punya nilai awal
  String? c;             // 3. Nullable: boleh kosong (null)
  final String d;        // 4. Final: hanya diisi sekali, tidak bisa diubah
  late String e;         // 5. Late: diisi belakangan, sebelum dipakai

  NamaClass(this.a, this.d);
}

void main() {
  var obj = NamaClass('isi a', 'isi d');
  print(obj.a);   // mengakses instance variable
  obj.b = 5;      // mengubah instance variable
}
```

| Jenis | Ciri | Contoh nyata |
|---|---|---|
| **Biasa** | `String nama;` | Nama karyawan |
| **Default value** | `int poin = 0;` | Poin member awal |
| **Nullable** | `String? catatan;` | Catatan opsional |
| **Final** | `final String id;` | ID, NIK, nomor rekening |
| **Late** | `late String token;` | Token yang didapat setelah login |

---

## 📍 Check Point: Driver (Aplikasi Ojek Online)

```dart
class Driver {
  final String idDriver;      // final: ID tidak boleh berubah
  String nama;                // biasa
  double rating = 5.0;        // default value
  int totalTrip = 0;          // default value
  String? lokasiTerakhir;     // nullable: belum ada sebelum trip

  Driver(this.idDriver, this.nama);

  void selesaikanTrip(double nilai, String lokasi) {
    rating = ((rating * totalTrip) + nilai) / (totalTrip + 1);
    totalTrip++;
    lokasiTerakhir = lokasi;
  }

  void info() {
    print('[$idDriver] $nama | Rating: $rating | Trip: $totalTrip | Lokasi: ${lokasiTerakhir ?? "-"}');
  }
}

void main() {
  var d1 = Driver('DRV01', 'Agus');
  var d2 = Driver('DRV02', 'Wati');

  d1.selesaikanTrip(5, 'Tunjungan Plaza');
  d1.selesaikanTrip(4, 'Stasiun Gubeng');

  d1.info();
  d2.info();

  // d1.idDriver = 'DRV99'; // ERROR: final tidak bisa diubah
}
```

**Output:**
```
[DRV01] Agus | Rating: 4.5 | Trip: 2 | Lokasi: Stasiun Gubeng
[DRV02] Wati | Rating: 5.0 | Trip: 0 | Lokasi: -
```

Data `d1` berubah, sedangkan `d2` tetap. Setiap object memiliki instance variable sendiri.

---

## 🎒 Homework

### Homework 1: Rekening (Aplikasi Bank Digital)

Buat class `Rekening` dengan ketentuan:
- **Instance variable:**
  - `nomorRekening` → `final`
  - `namaPemilik` → biasa
  - `saldo` → default `0`
  - `transaksiTerakhir` → nullable (`String?`)
- **Method:**
  - `setor(double jumlah)` menambah saldo dan mengisi `transaksiTerakhir`
  - `tarik(double jumlah)`: jika saldo kurang, tampilkan `"Saldo tidak cukup!"`
  - `cekSaldo()` menampilkan semua data
- Di `main()`, buat **2 rekening**, lakukan transaksi hanya pada salah satunya, lalu buktikan rekening lain tidak ikut berubah.

**Contoh output yang diharapkan:**
```
1234567 | Rudi | Saldo: 500000.0 | Terakhir: Setor 500000.0
7654321 | Maya | Saldo: 0.0 | Terakhir: -
```

### Homework 2: Sesi Login (Backend Aplikasi)

Buat class `SesiLogin` dengan ketentuan:
- **Instance variable:**
  - `userId` → `final`
  - `token` → `late String`
  - `isOnline` → default `false`
  - `waktuLogout` → nullable (`String?`)
- **Method:**
  - `login()` mengisi `token` (misal `"TKN-" + userId`) dan mengubah `isOnline` menjadi `true`
  - `logout(String waktu)` mengubah `isOnline` menjadi `false` dan mengisi `waktuLogout`
  - `status()` menampilkan semua data
- Di `main()`, buat 2 sesi: satu login lalu logout, satu hanya login.

**Tantangan:** coba panggil `print(sesi.token)` **sebelum** `login()`. Error apa yang muncul dan mengapa?

# 5. Implicit interfaces

## Bentuk Dasar

Di Dart, **setiap class otomatis menjadi interface**. Class lain dapat memakai `implements` untuk mengikuti "kontrak" class tersebut, dengan syarat **semua property dan method wajib ditulis ulang**.

```dart
// Class biasa = otomatis menjadi interface
class Kontrak {
  String nama = '';
  void aksi() {}
}

// Class yang mengikuti kontrak
class Implementasi implements Kontrak {
  @override
  String nama = 'Implementasi A';   // property wajib ditulis ulang

  @override
  void aksi() {                     // method wajib ditulis ulang
    print('$nama menjalankan aksi');
  }
}

void main() {
  Kontrak obj = Implementasi();     // bisa disimpan sebagai tipe Kontrak
  obj.aksi();
}
```

| Poin | Penjelasan |
|---|---|
| `implements` | Mengikuti kontrak class lain |
| Wajib ditulis ulang | Semua property dan method, tanpa ada kode yang diwariskan |
| `@override` | Penanda bahwa member berasal dari kontrak |
| Bisa lebih dari satu | `class A implements B, C` |
| Manfaat | Implementasi bisa diganti tanpa mengubah kode pemakainya |

---

## 📍 Check Point: Layanan Notifikasi OTP (Aplikasi Login)

```dart
class Notifikasi {
  String pengirim = 'System';
  void kirim(String tujuan, String pesan) {}
}

class EmailNotif implements Notifikasi {
  @override
  String pengirim = 'noreply@tokoku.com';

  @override
  void kirim(String tujuan, String pesan) {
    print('[EMAIL] $pengirim → $tujuan: $pesan');
  }
}

class WhatsAppNotif implements Notifikasi {
  @override
  String pengirim = 'TokoKu Official';

  @override
  void kirim(String tujuan, String pesan) {
    print('[WHATSAPP] $pengirim → $tujuan: $pesan');
  }
}

// Fungsi ini hanya mengenal "Notifikasi", tidak peduli jenis layanannya
void kirimOtp(Notifikasi layanan, String tujuan) {
  layanan.kirim(tujuan, 'Kode OTP Anda: 4821');
}

void main() {
  kirimOtp(EmailNotif(), 'andi@mail.com');
  kirimOtp(WhatsAppNotif(), '0812-3456-7890');
}
```

**Output:**
```
[EMAIL] noreply@tokoku.com → andi@mail.com: Kode OTP Anda: 4821
[WHATSAPP] TokoKu Official → 0812-3456-7890: Kode OTP Anda: 4821
```

Jika perusahaan ingin menambah layanan SMS, cukup buat class `SmsNotif implements Notifikasi`. Fungsi `kirimOtp()` tidak perlu diubah sama sekali.

Jika salah satu member tidak ditulis ulang (misalnya `pengirim` dihapus dari `EmailNotif`), Dart akan menampilkan error *Missing concrete implementation*.

---

## 🎒 Homework

### Homework 1: Penyimpanan Data (Aplikasi Catatan)

Gunakan kontrak berikut:

```dart
class Penyimpanan {
  String lokasi = '';
  void simpan(String data) {}
  void hapus(String data) {}
}
```

Tugas:
- Buat class `LocalStorage` dan `CloudStorage` yang `implements Penyimpanan`
  - `LocalStorage` → lokasi `"Memori HP"`
  - `CloudStorage` → lokasi `"Server Cloud"`
- Buat fungsi `backup(Penyimpanan p, String data)` yang memanggil `simpan()`
- Di `main()`, jalankan `backup()` dengan kedua jenis penyimpanan.

**Contoh output yang diharapkan:**
```
Menyimpan "Catatan Rapat" ke Memori HP
Menyimpan "Catatan Rapat" ke Server Cloud
```

### Homework 2: Mock API untuk Testing (Mobile Developer)

Dalam proyek nyata, developer sering membuat **data palsu (mock)** agar aplikasi bisa diuji tanpa memanggil server sungguhan.

```dart
class ApiCuaca {
  double ambilSuhu(String kota) {
    print('Menghubungi server cuaca...');
    return 0;
  }
}
```

Tugas:
- Buat `MockApiCuaca implements ApiCuaca` yang langsung mengembalikan data tetap:
  - Surabaya → `33.5`, Malang → `24.0`, kota lain → `28.0`
- Buat fungsi `tampilkanCuaca(ApiCuaca api, String kota)` yang mencetak suhu
- Di `main()`, uji fungsi tersebut dengan `MockApiCuaca` untuk 3 kota.

**Tantangan:** buat class `Kurir` yang `implements` **dua** class sekaligus, yaitu `Pengemudi` (method `antar()`) dan `Karyawan` (property `idKaryawan`). Apa saja yang wajib ditulis di class `Kurir`?

# 6. Class variables and methods
# OOP Dart: Class Variables & Methods

Class variables dan class methods ditandai dengan keyword **`static`**. Keduanya **milik class**, bukan milik object, sehingga dipanggil lewat nama class: `NamaClass.member`.

---

## 1. Class Variables (Static Variables)

### Bentuk Dasar

```dart
class NamaClass {
  static int nilaiBersama = 0;               // 1. Static variable: dipakai bersama semua object
  static const String konstanta = 'Tetap';   // 2. Static const: nilai tetap milik class

  String dataObject;                          // instance variable (pembanding)

  NamaClass(this.dataObject) {
    nilaiBersama++;                           // diakses dari dalam class
  }
}

void main() {
  NamaClass('A');
  NamaClass('B');
  print(NamaClass.nilaiBersama);              // 2 → diakses lewat nama class
  print(NamaClass.konstanta);                 // Tetap
}
```

| | Instance Variable | Class Variable (`static`) |
|---|---|---|
| Pemilik | Setiap object | Class |
| Jumlah salinan | Satu per object | Hanya satu, dipakai bersama |
| Cara akses | `obj.variabel` | `NamaClass.variabel` |
| Contoh nyata | Nama karyawan | Total karyawan, nama perusahaan |

### 📍 Check Point: ID Karyawan Otomatis (Sistem HRD)

```dart
class Karyawan {
  static const String perusahaan = 'PT Maju Jaya';
  static int jumlahKaryawan = 0;

  late final String id;
  String nama;

  Karyawan(this.nama) {
    jumlahKaryawan++;
    id = 'EMP-$jumlahKaryawan';
  }

  void info() => print('$id | $nama | ${Karyawan.perusahaan}');
}

void main() {
  var k1 = Karyawan('Budi');
  var k2 = Karyawan('Sari');
  var k3 = Karyawan('Doni');

  k1.info();
  k2.info();
  k3.info();
  print('Total karyawan: ${Karyawan.jumlahKaryawan}');
}
```

**Output:**
```
EMP-1 | Budi | PT Maju Jaya
EMP-2 | Sari | PT Maju Jaya
EMP-3 | Doni | PT Maju Jaya
Total karyawan: 3
```

`jumlahKaryawan` hanya ada **satu**, sehingga setiap object baru menambah penghitung yang sama dan ID tidak pernah kembar.

### 🎒 Homework 1: Nomor Antrean (Aplikasi Klinik/Bank)

Buat class `Antrean` dengan ketentuan:
- **Static variable:**
  - `static const String loket = 'CS'`
  - `static int nomorTerakhir = 0`
  - `static int kuotaHarian = 5`
- **Instance variable:** `namaPengunjung`, `nomorAntrean`
- Setiap object baru:
  - Mendapat nomor otomatis, contoh: `CS-001`, `CS-002`
  - Mengurangi `kuotaHarian`
  - Jika kuota habis, tampilkan `"Kuota hari ini sudah penuh!"`
- Di `main()`, buat **7 pengunjung**, lalu tampilkan sisa kuota.

**Tantangan:** coba tulis `print(pengunjung1.nomorTerakhir);`. Mengapa terjadi error?

---

## 2. Class Methods (Static Methods)

### Bentuk Dasar

```dart
class NamaClass {
  static int nilaiBersama = 10;
  String dataObject = 'x';

  static int hitung(int a, int b) {    // static method
    return a + b + nilaiBersama;       // ✅ boleh akses static variable
    // print(dataObject);              // ❌ tidak boleh akses instance variable
  }
}

void main() {
  print(NamaClass.hitung(2, 3));       // dipanggil tanpa membuat object → 15
}
```

| Poin | Penjelasan |
|---|---|
| Cara panggil | `NamaClass.method()`, tanpa membuat object |
| Boleh akses | Parameter dan static variable |
| Tidak boleh akses | Instance variable, instance method, dan `this` |
| Cocok untuk | Fungsi bantu (*helper/utility*) seperti format, validasi, dan konversi |

### 📍 Check Point: Helper Format & Validasi (Aplikasi E-Commerce)

```dart
class Helper {
  static String formatRupiah(int angka) {
    String s = angka.toString();
    String hasil = '';
    int hitung = 0;

    for (int i = s.length - 1; i >= 0; i--) {
      hasil = s[i] + hasil;
      hitung++;
      if (hitung % 3 == 0 && i != 0) hasil = '.$hasil';
    }
    return 'Rp $hasil';
  }

  static bool isEmailValid(String email) {
    return email.contains('@') && email.contains('.');
  }
}

void main() {
  print(Helper.formatRupiah(1500000));
  print(Helper.formatRupiah(75000));

  print(Helper.isEmailValid('andi@mail.com'));
  print(Helper.isEmailValid('andi-mail'));
}
```

**Output:**
```
Rp 1.500.000
Rp 75.000
true
false
```

Fungsi seperti ini dipakai di banyak halaman aplikasi (keranjang, checkout, form daftar) tanpa perlu membuat object `Helper`.

### 🎒 Homework 2: Kalkulator Gaji (Aplikasi Payroll)

Buat class `KalkulatorGaji` dengan ketentuan:
- **Static variable:** `static const double persenPajak = 5`
- **Static method:**
  - `hitungPajak(double gajiKotor)` mengembalikan nilai pajak
  - `gajiBersih(double gajiPokok, double tunjangan)` menghitung (gaji pokok + tunjangan) − pajak
  - `slip(String nama, double gajiPokok, double tunjangan)` mencetak slip gaji lengkap
- Di `main()`, cetak slip gaji untuk **3 karyawan** tanpa membuat object `KalkulatorGaji`.

**Contoh output yang diharapkan:**
```
=== SLIP GAJI: Budi ===
Gaji Pokok : 8000000.0
Tunjangan  : 1000000.0
Pajak (5%) : 450000.0
Gaji Bersih: 8550000.0
```

**Tantangan:** tambahkan instance variable `String namaHRD` ke class, lalu coba gunakan di dalam method `slip()`. Apa yang terjadi dan mengapa?

# Sumber

- https://dart.dev/language/classes
