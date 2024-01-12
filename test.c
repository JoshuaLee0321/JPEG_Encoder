#include <unistd.h>

int main() {
    char buf[20];
    for(int i = 0; i< 10; i++) {
        int len = sprintf(buf, "%d", i);
        write(1, buf, len);
    }
    return 0;
}