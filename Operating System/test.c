#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int val = 5;

int main(void) {
    pid_t pid = fork();

   	if (pid == 0) {
        val += 15;
        printf("CHILD  value = %d\n", val);
    return 0;
    } 
    else {
        wait(NULL);
        printf("PARENT value = %d\n", val);
        return 0;
    }
}
