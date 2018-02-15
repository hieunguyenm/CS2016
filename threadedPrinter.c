#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define NUM_CONSUMER_THREADS 3
#define NUM_TOTAL_THREADS (NUM_CONSUMER_THREADS + 1)

struct shared_data
{
  pthread_mutex_t mutex;
  pthread_cond_t cond1;
  pthread_cond_t cond2;
  unsigned int finished:1;
  unsigned int printed:1;
};

void* mainThreadFunction(struct shared_data* shared_data);
void* consumerFunction(void* threadId);
void* printerThreadFunction(void* threadId);

int main (int argc, char** argv)
{
  struct shared_data shared_data;

  pthread_mutex_init(&shared_data.mutex, NULL);
  pthread_cond_init(&shared_data.cond1, NULL);
  pthread_cond_init(&shared_data.cond2, NULL);

  shared_data.finished = 0;
  shared_data.printed = 1;

  // Creating main thread
  pthread_t main_thread;
  printf("Creating main thread\n");
  int rc = pthread_create(&main_thread, NULL, mainThreadFunction, &shared_data);
  if(rc)
  {
    printf("ERROR return code from pthread_create(): %d\n", rc);
    exit(-1);
  }

  // Waiting for main thread to close
  pthread_join(main_thread, NULL);

  return 0;
}

void* mainThreadFunction(struct shared_data* shared_data)
{
  printf("Main thread created\n");

  pthread_t threads[NUM_TOTAL_THREADS];

  int rc;
  // Creating consumer threads
  for(int t = 0;(t < NUM_CONSUMER_THREADS);t++)
  {
    printf("Creating thread\n");
    rc = pthread_create(&threads[t], NULL, consumerFunction, (void*) t);
    if(rc)
    {
      printf("ERROR return code from pthread_create(): %d\n", rc);
      exit(-1);
    }
  }

  // Creating printer thread
  printf("Creating printer thread\n");
  rc = pthread_create(&threads[NUM_TOTAL_THREADS - 1], NULL, printerThreadFunction, (void*) (NUM_TOTAL_THREADS - 1));
  if(rc)
  {
    printf("ERROR return code from pthread_create(): %d\n", rc);
    exit(-1);
  }

  pthread_exit(NULL);
}

void* consumerFunction(void* threadId)
{
  printf("Consumer thread id: %d\n", threadId);
  pthread_exit(NULL);
}

void* printerThreadFunction(void* threadId)
{
  printf("Printer thread id: %d\n", threadId);
  pthread_exit(NULL);
}
