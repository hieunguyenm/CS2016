#include <pthread.h>
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NUM_CONSUMER_THREADS 3
#define NUM_TOTAL_THREADS (NUM_CONSUMER_THREADS + 1)
#define BUFF_SIZE 100;

struct shared_data
{
  pthread_mutex_t mutex;
  pthread_cond_t buf_full;
  pthread_cond_t buf_empty;
  int threadUsed;
  unsigned int printed:1;
  unsigned int toPrint:1;
  char* input_string;
};

void* mainThreadFunction(void* shared_data);
void* consumerFunction(void* threadId);
void* printerThreadFunction(void* threadId);

int main (int argc, char** argv)
{ 
  // Creating main thread
  pthread_t main_thread;
  printf("Creating main thread\n");
  int rc = pthread_create(&main_thread, NULL, mainThreadFunction, (void*) *argv);
  if(rc)
  {
    printf("ERROR return code from pthread_create(): %d\n", rc);
    exit(-1);
  }

  // Waiting for main thread to close
  pthread_join(main_thread, NULL);

  return 0;
}

void* mainThreadFunction(void* argv)
{
  struct shared_data shared_data;
  
  pthread_mutex_init(&shared_data.mutex, NULL);
  pthread_cond_init(&shared_data.cond1, NULL);
  pthread_cond_init(&shared_data.cond2, NULL);

  shared_data.printed = 0;
  shared_data.toPrint = 0;

  printf("Main thread created\n");

  pthread_t threads[NUM_TOTAL_THREADS];

  int rc;
  // Creating consumer threads
  for(int t = 0;(t < NUM_CONSUMER_THREADS);t++)
  {
    printf("Creating thread\n");
    rc = pthread_create(&threads[t], NULL, consumerFunction, (void*) &shared_data);
    if(rc)
    {
      printf("ERROR return code from pthread_create(): %d\n", rc);
      exit(-1);
    }
  }

	
  // Creating printer thread
  printf("Creating printer thread\n");
  rc = pthread_create(&threads[NUM_TOTAL_THREADS - 1], NULL, printerThreadFunction, (void*) &shared_data);
  if(rc)
  {
    printf("ERROR return code from pthread_create(): %d\n", rc);
    exit(-1);
  }
  
	//getLine 
	char *buffer;
  size_t bufsize = BUFF_SIZE;
  
  int finished = 0;
  while(!finished)
  {
		buffer = (char *) malloc(bufsize * sizeof(char));
		if(buffer == NULL)
		{
			printf("ERROR: U DUM");
			exit(-1);
		}
	
		getline(&buffer, &bufsize, stdin);
		
		if(strcmp("\n", buffer) == 0)
			finished = 1;
		
		pthread_mutex_lock(&shared_data.mutex);
		strcpy(&shared_data.input_string, &buffer);
		shared_data.toPrint = 1;
		pthread_cond_signal (&cond);
		pthread_mutex_unlock(&shared_data.mutex);
	}
	
  pthread_exit(NULL);
}

void* consumerFunction(void* shared_data)
{
	pthread_mutex_lock(&shared_data->mutex);
	while(!shared_data->toPrint)
		pthread_cond_wait(&shared_data->buf_full, &shared_data->mutex);
  pthread_exit(NULL);
}

void* printerThreadFunction(void* shared_data)
{
  pthread_exit(NULL);
}
