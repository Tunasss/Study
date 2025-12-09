#include <iostream>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/time.h>
#include <iomanip>

using namespace std;

int main(int argc, char *argv[]) {
    if (argc < 2) {
        cerr << "Usage: " << argv[0] << " <command>" << endl;
        return 1;
    }

    struct timeval start, end;

    gettimeofday(&start, NULL);

    pid_t pid = fork();

    if (pid < 0) {
        cerr << "Fork failed!" << endl;
        return 1;
    } else if (pid == 0) {
        execvp(argv[1], &argv[1]);
        cerr << "Command execution failed" << endl;
        return 1;
    } else {
        wait(NULL);

        gettimeofday(&end, NULL);

        double time_taken;
        time_taken = (end.tv_sec - start.tv_sec) * 1e6;
        time_taken = (time_taken + (end.tv_usec - start.tv_usec)) * 1e-6;

        cout << "Execution time: " << fixed << setprecision(5) << time_taken << endl;
    }

    return 0;
}