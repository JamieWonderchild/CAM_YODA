#include <math.h>
#include <stdio.h>
#include <string.h>

int hash(char s){
  int h = 0;
  for(int i=0; i<s.length();i++){
    h += s.charAt(i)*pow(31, s.length-i);
  }
return h;
}
