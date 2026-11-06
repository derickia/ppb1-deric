class Karyawan {
  static const String perusahaan = 'PT Mundur Jaya';
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
