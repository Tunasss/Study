#include <iostream>
#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <cstring>

#define BUFFER_SIZE 4096

using namespace std;

int main(int argc, char *argv[]) {
    if (argc != 3) {
        cerr << "Usage: " << argv[0] << " <source_file> <destination_file>" << endl;
        return 1;
    }

    const char* sourceFile = argv[1];
    const char* destFile = argv[2];

    int pipefd[2];
    if (pipe(pipefd) == -1) {
        perror("Pipe failed");
        return 1;
    }

    pid_t pid = fork();

    if (pid < 0) {
        perror("Fork failed");
        return 1;
    } 
    else if (pid > 0) {
        close(pipefd[0]); 

        int inputFd = open(sourceFile, O_RDONLY);
        if (inputFd == -1) {
            perror("Error opening source file");
            close(pipefd[1]);
            return 1;
        }

        char buffer[BUFFER_SIZE];
        ssize_t bytesRead;
        while ((bytesRead = read(inputFd, buffer, BUFFER_SIZE)) > 0) {
            if (write(pipefd[1], buffer, bytesRead) != bytesRead) {
                perror("Error writing to pipe");
                break;
            }
        }

        close(inputFd);
        close(pipefd[1]);

        wait(NULL);
    } 
    else {
        close(pipefd[1]); 

        int outputFd = open(destFile, O_WRONLY | O_CREAT | O_TRUNC, 0666);
        if (outputFd == -1) {
            perror("Error opening destination file");
            close(pipefd[0]);
            return 1;
        }

        char buffer[BUFFER_SIZE];
        ssize_t bytesRead;
        while ((bytesRead = read(pipefd[0], buffer, BUFFER_SIZE)) > 0) {
            if (write(outputFd, buffer, bytesRead) != bytesRead) {
                perror("Error writing to destination file");
                break;
            }
        }

        close(outputFd);
        close(pipefd[0]);
    }

    return 0;
}