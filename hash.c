#include <math.h>
#include <stdio.h>
#include <string.h>

int main() {
  printf("Enter in data to be hashed: " );
  char data;
  scanf("%c", data);
  printf("the has is %u\n", hash(data));
  return 0;
}

int hash(char s){
  int h = 0;
  for(int i=0; i<s.length();i++){
    h += s.charAt(i)*pow(31, s.length-i);
  }
return h;
}
