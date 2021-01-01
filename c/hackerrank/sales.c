#include <stdio.h>

int checkTypes(int* types, int ar_count, int check){
  for (int i=0; i<ar_count; i++){
    if (check==types[i]){
      return 1;
    }
  }
  return 0;
}

int setNextType(int* types, int typesCount, int type){
  types[typesCount] = type;
  return 0;
}

int getIndex(int* types, int ar_count, int type){
  for (int i=0; i<ar_count; i++){
    if (type==types[i]){
      return i;
    }
  }
}

int sockMerchant(int n, int ar_count, int* ar) {
    int counts[ar_count];
    int types[ar_count];
    types[0] = ar[0];
    int typesCount = 1;
    int totalPairs;

    //setup types array
    for (int i=1; i<n; i++){
      if (checkTypes(types, ar_count, ar[i])==0){
        setNextType(types, typesCount, ar[i]);
        typesCount++;
      }
    }

    //add up sum of each socktype
    for (int i=0; i<n; i++){
      int typeIndex = getIndex(types, ar_count, ar[i]);
      counts[typeIndex]++;
    }

    //sum pairs and ignore extras socks
    for (int i=0; i<ar_count; i++){
      int count = counts[i];
      totalPairs += ((count -(count%2))/2);
    }
    return totalPairs;
}
int unitTest(){
    int ar[] = {10, 20, 20, 10, 10, 30, 50, 10, 20};
    printf("totalPairs is %d\n", sockMerchant(9, 4, ar));
    return 0;
}
int main(){
    unitTest();
    return 0;
}
