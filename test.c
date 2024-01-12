#include <stdio.h>
#include <time.h>
long gettime(){
    struct timespec tv;
    clock_gettime(0, &tv);
    printf("current tick: %ld", tv.tv_nsec);
    return tv.tv_nsec;
}
int main() {
    gettime();
    return 0;
}
