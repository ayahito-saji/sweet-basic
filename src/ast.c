#include "ast.h"
#include "y.tab.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

struct astnode *root = NULL;
unsigned int astline = 1;

struct astnode *astnode_new(enum asttype type) {

  struct astnode *p = (struct astnode*) malloc((int) sizeof(struct astnode));
  p->type = type;
  p->child = NULL;
  p->next = NULL;
  p->line = astline;
  // printf("新しいノード:%p %d\n", p, type);
  return p;
}

void astnode_add(struct astnode *parent, struct astnode *node) {
  if (node == NULL) return;
  // printf("子供の追加:%p -> %p\n", parent, node);
  if (parent->child == NULL) {
    /* first child */
    parent->child = node;
  } else {
    struct astnode *last = parent->child;
    while(last->next != NULL) last = last->next;
    last->next = node;
  }
}

struct astnode *astnode_num(double val) {
  if (val <= 524287 && val >= -524287) {
    struct astnode *p = (struct astnode*) malloc((int) sizeof(struct astnode));
    p->type = NUMBER;
    p->child = NULL;
    p->next = NULL;
    p->num = (int) (val * (1 << 12));
    p->line = astline;
    // printf("新しいノード:%p %d %d\n", p, p->type, p->num);
    return p;
  } else {
    printf("Overflow(%d)\n", astline);
    exit(1);
  }
}

struct astnode *astnode_str(char *val) {
  int len = strlen(val);
  if (len <= 256+2) {
    struct astnode *p = (struct astnode*) malloc((int) sizeof(struct astnode));
    char *str = (char *) malloc(sizeof(char) * 256+1);
    strncpy(str, val+1, len-2);
    *(str+len-2) = '\0';
    p->type = STRING;
    p->child = NULL;
    p->next = NULL;
    p->str = str;
    p->line = astline;
    return p;
  } else {
    printf("String too long(%d)\n", astline);
    exit(1);
  }
}

struct astnode *astnode_sbl(char *val) {
  int len = strlen(val);
  if (len <= 16) {
    struct astnode *p = (struct astnode*) malloc((int) sizeof(struct astnode));
    char *str = (char *) malloc(sizeof(char) * len+1);
    strncpy(str, val, len);
    *(str+len) = '\0';
    p->type = SYMBOL;
    p->child = NULL;
    p->next = NULL;
    p->str = str;
    p->line = astline;
    return p;
  } else {
    printf("String too long(%d)\n", astline);
    exit(1);
  }
}

void view_ast (struct astnode *tree, int indent) {
  char c, str[256];
  int i, len;

  printf("%*s", indent, "");
  switch (tree->type) {
    case NUMBER:
      sprintf(str, "%.3f", round(tree->num / (4.096))/1000.0);
      len = strlen(str);
      for (i=len-1; i>=0; i--) {
        c = *(str + i);
        if (c == '0') { *(str + i) = '\0'; }
        else if (c == '.') { *(str + i) = '\0';break; }
        else { break; }
      }
      printf("%s(%d)\n", str, tree->line);
      break;
    case STRING:
      printf("\"%s\"(%d)\n", tree->str, tree->line);
      break;
    case SYMBOL:
      printf("%s(%d)\n", tree->str, tree->line);
      break;
    case ADD:
      printf("+(%d)\n", tree->line);
      break;
    case SUB:
      printf("-(%d)\n", tree->line);
      break;
    case MUL:
      printf("*(%d)\n", tree->line);
      break;
    case DIV:
      printf("/(%d)\n", tree->line);
      break;
    case ARGUMENTS:
      printf("argv(%d)\n", tree->line);
      break;
    case INSTRUCTION:
      printf("inst(%d)\n", tree->line);
      break;
    case STATEMENT:
      printf(":(%d)\n", tree->line);
      break;
    case STATEMENTS:
      printf("¥n(%d)\n", tree->line);
      break;
    case PROGRAM:
      printf("root\n");
      break;
  }
  struct astnode *child = tree->child;
  while (child != NULL) {
    view_ast(child, indent + 2);
    child = child->next;
  }
}
