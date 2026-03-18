#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>
#include <time.h>

#define MAX_ARY 100

int a[MAX_ARY];
int count = 0;

pthread_mutex_t mutex;
sem_t sem_items;

void *thread_generate(void *arg) {
    while (1) {
        int num = rand() % 100;
        
        pthread_mutex_lock(&mutex);
        if (count < MAX_ARY) {SS
            a[count] = num;
            count++;
            printf("[Thread 1] Added %d. Count: %d\n", num, count);
            sem_post(&sem_items);
        } else {
            printf("[Thread 1] Array full!\n");
        }
        pthread_mutex_unlock(&mutex);
        
        sleep(1); 
    }
}

void *thread_remove(void *arg) {
    while (1) {
        if (sem_trywait(&sem_items) == 0) {
            pthread_mutex_lock(&mutex);
            if (count > 0) {
                int val = a[count - 1];
                count--;
                printf("[Thread 2] Removed %d. Count: %d\n", val, count);
            }
            pthread_mutex_unlock(&mutex);
        } else {
            printf("[Thread 2] Nothing in array a\n");
        }
        
        sleep(2);
    }
}

int main() {
    srand(time(NULL));
    
    pthread_t t1, t2;
    
    sem_init(&sem_items, 0, 0);
    pthread_mutex_init(&mutex, NULL);

    pthread_create(&t1, NULL, thread_generate, NULL);
    pthread_create(&t2, NULL, thread_remove, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    sem_destroy(&sem_items);
    pthread_mutex_destroy(&mutex);

    return 0;
}
