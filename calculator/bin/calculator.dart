import 'dart:io';

void main() {
  print("Ifodani kiriting ---> ");
  String ifoda = stdin.readLineSync()!;

  try {
    int natija = ifodaniBaholash(ifoda);
    print("Ifoda natijasi: $natija");
  } catch (e) {
    print("Xatolik yuz berdi: $e");
  }
}

int ifodaniBaholash(String ifoda) {
  ifoda = ifoda.replaceAll(' ', '');

  while (ifoda.contains('(')) {
    int boshlanish = ifoda.lastIndexOf('(');
    int tugash = ifoda.indexOf(')', boshlanish);
    if (tugash == -1) {
      throw Exception('Qavslar noto\'g\'ri qo\'yilgan');
    }
    String qavsIchidagi = ifoda.substring(boshlanish + 1, tugash);
    int qiymat = oddiyIfodaniHisobla(qavsIchidagi);
    ifoda = ifoda.substring(0, boshlanish) +
        qiymat.toString() +
        ifoda.substring(tugash + 1);
  }

  return oddiyIfodaniHisobla(ifoda);
}

int oddiyIfodaniHisobla(String ifoda) {
  List<String> qismlar = [];
  String yiguvchi = '';
  for (int i = 0; i < ifoda.length; i++) {
    String belgi = ifoda[i];
    if (belgi == '+' || belgi == '-' || belgi == '*' || belgi == '/') {
      qismlar.add(yiguvchi);
      qismlar.add(belgi);
      yiguvchi = '';
    } else {
      yiguvchi += belgi;
    }
  }
  qismlar.add(yiguvchi);

  for (int i = 0; i < qismlar.length; i++) {
    if (qismlar[i] == '*' || qismlar[i] == '/') {
      int left = int.parse(qismlar[i - 1]);
      int right = int.parse(qismlar[i + 1]);
      int natija = qismlar[i] == '*' ? left * right : left ~/ right;
      qismlar[i - 1] = natija.toString();
      qismlar.removeAt(i);
      qismlar.removeAt(i);
      i--;
    }
  }

  int yakuniyNatija = int.parse(qismlar[0]);
  for (int i = 1; i < qismlar.length; i += 2) {
    String operator = qismlar[i];
    int nextSon = int.parse(qismlar[i + 1]);
    if (operator == '+') {
      yakuniyNatija += nextSon;
    } else if (operator == '-') {
      yakuniyNatija -= nextSon;
    }
  }

  return yakuniyNatija;
}
