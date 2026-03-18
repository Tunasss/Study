#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

// 4 last digit of SID: 2452 "1943"
#define SID 1943

int products = 0;
int sells = 0;

sem_t sem_items;
sem_t sem_space;
pthread_mutex_t mutex;

void *producer(void *arg) {
    while (1) {
        sem_wait(&sem_space);
        pthread_mutex_lock(&mutex);
        products++;
        printf("Produced! Products: %d, Sells: %d, Inventory: %d\n", products, sells, products - sells);
        pthread_mutex_unlock(&mutex);
        sem_post(&sem_items);
        
        sleep(1);
    }
}

void *consumer(void *arg) {
    while (1) {
        sem_wait(&sem_items);
        pthread_mutex_lock(&mutex);
        sells++;
        printf("Sold!     Products: %d, Sells: %d, Inventory: %d\n", products, sells, products - sells);
        pthread_mutex_unlock(&mutex);
        sem_post(&sem_space);
        
        sleep(2); 
    }
}

int main() {
    pthread_t t1, t2;
    
    sem_init(&sem_items, 0, 0);
    sem_init(&sem_space, 0, SID);
    pthread_mutex_init(&mutex, NULL);

    pthread_create(&t1, NULL, producer, NULL);
    pthread_create(&t2, NULL, consumer, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    sem_destroy(&sem_items);
    sem_destroy(&sem_space);
    pthread_mutex_destroy(&mutex);

    return 0;
}
