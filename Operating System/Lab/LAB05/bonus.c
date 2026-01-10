#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

int x1, x2, x3, x4, x5, x6;
int w, v, y, z, ans;

sem_t sem_a_done;
sem_t sem_b_done;
sem_t sem_c_done;
sem_t sem_d_done;
sem_t sem_e_done;
sem_t sem_f_done;

void *calc_a(void *arg) {
    w = x1 * x2;
    printf("[a] w = %d\n", w);
    
    sem_post(&sem_a_done);
    sem_post(&sem_a_done);
    return NULL;
}

void *calc_b(void *arg) {
    v = x3 * x4;
    printf("[b] v = %d\n", v);
    
    sem_post(&sem_b_done);
    sem_post(&sem_b_done);
    return NULL;
}

void *calc_c(void *arg) {
    sem_wait(&sem_b_done);
    
    y = v * x5;
    printf("[c] y_init = %d\n", y);
    
    sem_post(&sem_c_done);
    return NULL;
}

void *calc_d(void *arg) {
    sem_wait(&sem_b_done);
    
    z = v * x6;
    printf("[d] z_init = %d\n", z);
    
    sem_post(&sem_d_done);
    return NULL;
}

void *calc_e(void *arg) {
    sem_wait(&sem_a_done);
    sem_wait(&sem_c_done);
    
    y = w * y;
    printf("[e] y_final = %d\n", y);
    
    sem_post(&sem_e_done);
    return NULL;
}

void *calc_f(void *arg) {
    sem_wait(&sem_a_done);
    sem_wait(&sem_d_done);
    
    z = w * z;
    printf("[f] z_final = %d\n", z);
    
    sem_post(&sem_f_done);
    return NULL;
}

void *calc_g(void *arg) {
    sem_wait(&sem_e_done);
    sem_wait(&sem_f_done);
    
    ans = y + z;
    printf("[g] ans = %d\n", ans);
    return NULL;
}

int main() {
    printf("Nhap gia tri x1: ");
    scanf("%d", &x1);
    printf("Nhap gia tri x2: ");
    scanf("%d", &x2);
    printf("Nhap gia tri x3: ");
    scanf("%d", &x3);
    printf("Nhap gia tri x4: ");
    scanf("%d", &x4);
    printf("Nhap gia tri x5: ");
    scanf("%d", &x5);
    printf("Nhap gia tri x6: ");
    scanf("%d", &x6);

    printf("\n--- Bat dau tinh toan ---\n");

    pthread_t ta, tb, tc, td, te, tf, tg;

    sem_init(&sem_a_done, 0, 0);
    sem_init(&sem_b_done, 0, 0);
    sem_init(&sem_c_done, 0, 0);
    sem_init(&sem_d_done, 0, 0);
    sem_init(&sem_e_done, 0, 0);
    sem_init(&sem_f_done, 0, 0);

    pthread_create(&ta, NULL, calc_a, NULL);
    pthread_create(&tb, NULL, calc_b, NULL);
    pthread_create(&tc, NULL, calc_c, NULL);
    pthread_create(&td, NULL, calc_d, NULL);
    pthread_create(&te, NULL, calc_e, NULL);
    pthread_create(&tf, NULL, calc_f, NULL);
    pthread_create(&tg, NULL, calc_g, NULL);

    pthread_join(ta, NULL);
    pthread_join(tb, NULL);
    pthread_join(tc, NULL);
    pthread_join(td, NULL);
    pthread_join(te, NULL);
    pthread_join(tf, NULL);
    pthread_join(tg, NULL);

    sem_destroy(&sem_a_done);
    sem_destroy(&sem_b_done);
    sem_destroy(&sem_c_done);
    sem_destroy(&sem_d_done);
    sem_destroy(&sem_e_done);
    sem_destroy(&sem_f_done);

    return 0;
}
