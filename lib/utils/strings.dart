String convertBooleanStringToDBBoolen(String boolen) {
  if (boolen.toUpperCase() == 'YES') {
    return 'AYES';
  } else {
    return 'ANNO';
  }
}
