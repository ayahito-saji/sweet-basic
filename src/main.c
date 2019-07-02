#include <stdio.h>

int main(int argc, char **argv) {
  if (argc == 1) {
    printf("Sweet BASIC v0.0.1\n");
    return 0;
  }

  FILE *fp;
  int chr;
  fp = fopen(argv[1], "r");
  if (fp == NULL) {
    printf("Load failed\n");
    return 1;
  }

  while ((chr = fgetc(fp)) != EOF) {
    printf("%c", chr);
  }
  fclose(fp);

  return 0;
}
