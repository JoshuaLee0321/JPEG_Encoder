#include <stdio.h>
#include <time.h>
long gettime(){
    struct timespec tv;
    clock_gettime(0, &tv);
    printf("current tick: %ld", tv.tv_nsec);
    return tv.tv_nsec;
}
int main() {
    int a = 39;
    for(int i = 0; i< 100; i++) {

        a = i * 38;
        printf("%d", a);
    }
    return 0;
}
