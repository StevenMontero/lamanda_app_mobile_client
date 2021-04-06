class PriceCalculator {
  PriceCalculator();

  static double get nailCuttingPrice {
    return 3000.0;
  }

  static double get earCleaning {
    return 3000.0;
  }

  static double get teethCleaning {
    return 4000.0;
  }

  static double get veterinaryConsultation {
    return 12000.0;
  }

  static double calculatePriceHairCutAndWashPet({
    required double weightPet,
    required String kindPet,
  }) {
    double _price = 0;
    switch (kindPet) {
      case 'Perro':
        if (weightPet < 12.0) {
          _price = 11500.0;
        } else if (weightPet >= 12.0 && weightPet < 25.0) {
          _price = 15000.0;
        } else if (weightPet >= 25.0 && weightPet < 40.0) {
          _price = 19000.0;
        } else {
          _price = 22000.0;
        }
        break;
      case 'Gato':
        _price = 12000.0;
        break;
      default:
    }
    return _price;
  }

  static double calculateWashPet(
      {required double weightPet,
      required String kindPet,
      required String kindHair}) {
    double _price = 0;
    switch (kindPet) {
      case 'Perro':
        switch (kindHair) {
          case 'Largo':
            if (weightPet < 12.0) {
              _price = 11500.0;
            } else if (weightPet >= 12.0 && weightPet < 25.0) {
              _price = 15000.0;
            } else if (weightPet >= 25.0 && weightPet < 40.0) {
              _price = 19000.0;
            } else {
              _price = 22000.0;
            }
            break;
          case 'Corto':
            if (weightPet < 8.0) {
              _price = 7000.0;
            } else if (weightPet >= 8.0 && weightPet < 12.0) {
              _price = 10000.0;
            } else {
              _price = 12000.0;
            }
            break;
        }
        break;
      case 'Gato':
        _price = 12000.0;
        break;
    }
    return _price;
  }

  static double calculatePriceHotelDay(
      {required double weightPet, required String kindPet, required int days}) {
    double _price = 0;
    switch (kindPet) {
      case 'Perro':
        if (weightPet < 12.0) {
          _price = 6000.0;
        } else if (weightPet >= 12.0 && weightPet < 25.0) {
          _price = 8000.0;
        } else {
          _price = 10000.0;
        }
        break;
      case 'Gato':
        _price = 8000.0;
        break;
      default:
    }
    return days > 0 ? _price * days : 10000.0;
  }

  static double calculatePriceDayCare({required int hours}) {
    if (hours == 7) return 6000.0;
    return hours > 0 ? hours * 1500 : 1500;
  }
}
