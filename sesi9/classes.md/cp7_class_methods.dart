class Helper {
  static String formatRupiah(int angka) {
    String s = angka.toString();
    String hasil = '';
    int hitung = 0;

    //tiga digit = titik .
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
