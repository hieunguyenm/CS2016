#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define _GNU_SOURCE

#define NUM_CONSUMER_THREADS 3
#define NUM_TOTAL_THREADS (NUM_CONSUMER_THREADS + 1)
#define BUFF_SIZE 100;

pthread_mutex_t mutex;
pthread_cond_t consumer_cond;
pthread_cond_t printer_cond;

struct shared_data
{
  char* input_string;
  unsigned int finished:1;
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

  pthread_mutex_init(&mutex, NULL);
  pthread_cond_init(&consumer_cond, NULL);
  pthread_cond_init(&printer_cond, NULL);

  // shared_data.printed = 0;
  // shared_data.toPrint = 0;

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

  while(!shared_data.finished)
  {
		buffer = (char *) malloc(bufsize * sizeof(char));
		if(buffer == NULL)
		{
			printf("ERROR something went very wrong");
			exit(-1);
		}

		getline(&buffer, &bufsize, stdin);

		if(strcmp("\n", buffer) == 0)
			shared_data.finished = 1;

		pthread_mutex_lock(&mutex);
		strcpy(&shared_data.input_string, &buffer);
		pthread_mutex_unlock(&mutex);
    pthread_cond_signal(&consumer_cond);
	}

  pthread_exit(NULL);
}

void* consumerFunction(void* shared_data_p)
{
  printf("Thread created\n");

  pthread_mutex_lock(&mutex);
  pthread_cond_wait(&consumer_cond, &mutex);
  printf("%s\n", shared_data_p->input_string);
  pthread_mutex_unlock(&mutex);

  pthread_exit(NULL);
}

void* printerThreadFunction(void* shared_data)
{
  printf("Printer thread created\n");
  pthread_exit(NULL);
}
