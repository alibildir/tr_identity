class tcValidate {
  tcValidate();

  bool tcValidator(String tcNo) {
    var sayiDizi = parcala(tcNo);

    if (sayiDizi != null) {
      bool kosul1 = (sayiDizi[0] +
                  sayiDizi[1] +
                  sayiDizi[2] +
                  sayiDizi[3] +
                  sayiDizi[4] +
                  sayiDizi[5] +
                  sayiDizi[6] +
                  sayiDizi[7] +
                  sayiDizi[8] +
                  sayiDizi[9]) %
              10 ==
          sayiDizi[10];
      bool kosul2 = (((sayiDizi[0] +
                          sayiDizi[2] +
                          sayiDizi[4] +
                          sayiDizi[6] +
                          sayiDizi[8]) *
                      7) +
                  ((sayiDizi[1] + sayiDizi[3] + sayiDizi[5] + sayiDizi[7]) *
                      9)) %
              10 ==
          sayiDizi[9];
      bool kosul3 = ((sayiDizi[0] +
                      sayiDizi[2] +
                      sayiDizi[4] +
                      sayiDizi[6] +
                      sayiDizi[8]) *
                  8) %
              10 ==
          sayiDizi[10];

      return kosul1 && kosul2 && kosul3;
    }
    return false;
  }

  parcala(String tcNo) {
    List<int> sayilar = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    if (tcNo == null || tcNo.length != 11) {
      return null;
    }

    for (int i = 0; i < 11; i++) {
      sayilar[i] = int.parse(tcNo.substring(i, (i + 1)));
    }
    return sayilar;
  }

  bool isYear(String value) {
    if (value.length != 4) return false;
    int yearOfBirth = 0;
    if (int.tryParse(value) != null) {yearOfBirth=int.parse(value);} else {return false;}
    if ((yearOfBirth < 1900) || (yearOfBirth > DateTime.now().year)) {
      return false;
    }
    return true;
  }
}
