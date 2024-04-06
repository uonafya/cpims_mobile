String convertBooleanStringToDBBoolen(String boolen) {
  if (boolen.toUpperCase() == 'YES') {
    return 'AYES';
  } else {
    return 'ANNO';
  }
}

//ALSO when fetching from the database, convert the AYES and ANNO to YES and NO
String convertDBBoolenToBooleanString(String boolen) {
  if (boolen.toUpperCase() == 'AYES') {
    return 'YES';
  } else {
    return 'NO';
  }
}
