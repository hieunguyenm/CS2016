#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct data
{
  int int1;
  int int2;
  int int3;
  char testString[50];
}data1,data2;

void printData(struct data *data)
{
  printf("int1: %d\n", data->int1);
  printf("int2: %d\n", data->int2);
  printf("int3: %d\n", data->int3);
  printf("testString: %s\n", data->testString);
}

int main(int argc, char **argv)
{
  data1.int1 = 1;
  data1.int2 = 2;
  data1.int3 = 3;
  strcpy(data1.testString, "Data struct 1");

  data2.int1 = 4;
  data2.int2 = 5;
  data2.int3 = 6;
  strcpy(data2.testString, "Data struct 2");

  printData(&data1);
  printData(&data2);
}
