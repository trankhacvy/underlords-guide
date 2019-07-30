int occuranceInList<T>(List<T> list, T element){
  int count = 0;
  for(var i in list) {
    if(element == i) count++;
  }

  return count;
}