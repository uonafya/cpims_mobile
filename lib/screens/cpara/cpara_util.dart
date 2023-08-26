String convertOptionStandardFormat({required String text}){
  switch(text.toLowerCase()){
    case "yes":
      return "AYES";
    case "no":
      return "ANNO";
    case "n/a":
      default:
        return "ANNA";
  }
}

String overallChildrenBenchmark({required List<String> childrenOptions}){
  String selectedOption = "yes";

  if(childrenOptions.isEmpty){
    return "no";
  }

  for(String option in childrenOptions){
    print("list : ${option}");
    if(option.toLowerCase() == "no" || option == "null"){
      return "no";
    }
  }

  return selectedOption;
}