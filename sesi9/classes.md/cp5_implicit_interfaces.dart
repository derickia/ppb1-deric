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
