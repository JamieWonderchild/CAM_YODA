#include <math.h>
#include <stdio.h>
#include <string.h>

int hash(char s[]){
  int h = 0;
  for(int i=0; i<strlen(s);i++){
    h += s[i]*pow(31, strlen(s)-i);//s.charAt(0) * 31^(n-1) + s.charAt(1) * 31^(n-2) + ... + s.charAt(n-1)
  }
return h;
}

int main() {

char h[] = "how are you";
int x = hash(h);
  printf("%d\n", x);
  return 0;
}
