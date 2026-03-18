#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

sem_t sem_t1_done;
sem_t sem_t2_done;
sem_t sem_t3_done;

void *worker_t1(void *arg) {
    printf("Thread T1 is running...\n");
    sleep(1);
    printf("Thread T1 finished.\n");
    
    sem_post(&sem_t1_done);
    sem_post(&sem_t1_done);
    
    return NULL;
}

void *worker_t2(void *arg) {
    sem_wait(&sem_t1_done);
    
    printf("Thread T2 is running...\n");
    sleep(1);
    printf("Thread T2 finished.\n");
    
    sem_post(&sem_t2_done);
    return NULL;
}

void *worker_t3(void *arg) {
    sem_wait(&sem_t1_done); 
    
    printf("Thread T3 is running...\n");
    sleep(1);
    printf("Thread T3 finished.\n");
    
    sem_post(&sem_t3_done);
    return NULL;
}

void *worker_t4(void *arg) {
    sem_wait(&sem_t2_done);
    sem_wait(&sem_t3_done);
    
    printf("Thread T4 is running (after T2 and T3)...\n");
    printf("Thread T4 finished.\n");
    
    return NULL;
}

int main() {
    pthread_t t1, t2, t3, t4;

    sem_init(&sem_t1_done, 0, 0);
    sem_init(&sem_t2_done, 0, 0);
    sem_init(&sem_t3_done, 0, 0);

    pthread_create(&t1, NULL, worker_t1, NULL);
    pthread_create(&t2, NULL, worker_t2, NULL);
    pthread_create(&t3, NULL, worker_t3, NULL);
    pthread_create(&t4, NULL, worker_t4, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    pthread_join(t3, NULL);
    pthread_join(t4, NULL);

    sem_destroy(&sem_t1_done);
    sem_destroy(&sem_t2_done);
    sem_destroy(&sem_t3_done);

    return 0;
}
