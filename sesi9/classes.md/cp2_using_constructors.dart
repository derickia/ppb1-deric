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
