#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define NUM_CONSUMER_THREADS 3
#define NUM_TOTAL_THREADS (NUM_CONSUMER_THREADS + 1)

void* mainThreadFunction();
void* consumerFunction(void *threadId);
void* printerThreadFunction(void *threadId);

int main (int argc, const char *argv[])
{
  // Creating main thread
  pthread_t mainThread;
  printf("Creating main thread\n");
  int rc = pthread_create(&mainThread, NULL, mainThreadFunction, NULL);
  if(rc)
  {
    printf("ERROR return code from pthread_create(): %d\n", rc);
    exit(-1);
  }

  // Waiting for main thread to close
  pthread_join(mainThread, NULL);

  return 0;
}

void* mainThreadFunction()
{
  printf("Main thread created\n");

  pthread_t threads[NUM_TOTAL_THREADS];

  int rc;
  // Creating consumer threads
  for(int t = 0;(t < NUM_CONSUMER_THREADS);t++)
  {
    printf("Creating thread\n");
    rc = pthread_create(&threads[t], NULL, consumerFunction, (void *) t);
    if(rc)
    {
      printf("ERROR return code from pthread_create(): %d\n", rc);
      exit(-1);
    }
  }

  // Creating printer thread
  printf("Creating printer thread\n");
  rc = pthread_create(&threads[NUM_TOTAL_THREADS - 1], NULL, printerThreadFunction, (void *) (NUM_TOTAL_THREADS - 1));
  if(rc)
  {
    printf("ERROR return code from pthread_create(): %d\n", rc);
    exit(-1);
  }

  pthread_exit(NULL);
}

void* consumerFunction(void *threadId)
{
  printf("Consumer thread id: %d\n", threadId);
  pthread_exit(NULL);
}

void* printerThreadFunction(void *threadId)
{
  printf("Printer thread id: %d\n", threadId);
  pthread_exit(NULL);
}
