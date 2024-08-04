#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *addIndent(char *beforeText);

int ROW_LENGTH = 1024;

/**
 * main method
 *
 * @var int
 */
int main(int argc, char **argv) {
  if (argc != 3) {
    fprintf(stderr, "expected 3 arguments but %d given.\n", argc);
  }

  char *readFileName = argv[1];
  char *writeFileName = argv[2];
  char readText[ROW_LENGTH];
  FILE *rfp;
  FILE *wfp;

  rfp = fopen(readFileName, "r");
  wfp = fopen(writeFileName, "w");
  fprintf(wfp, ".globl main\n\n");
  fprintf(wfp, "main:\n");

  while (fgets(readText, ROW_LENGTH, rfp) != NULL) {
    if (strcmp(readText, "\n") != 0) {
      fprintf(wfp, addIndent("mov w0, %d\n"), atoi(readText));
    }
  }

  fprintf(wfp, addIndent("ret\n"), NULL);
  fclose(wfp);
  fclose(rfp);

  return 0;
}

/**
 * add an indent
 * todo: あとで絶対抽象化する
 *
 * @param char *beforeText 変換前の文字列ポインタ
 *
 * @return char *
 */
char *addIndent(char *beforeText) {
  char *afterText = NULL;
  afterText = (char *)malloc(sizeof(beforeText) + 4);

  if (afterText == NULL) {
    printf("failed\n");
  }

  sprintf(afterText, "    %s", beforeText);

  return afterText;
}
