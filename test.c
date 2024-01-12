#include <unistd.h>


void printFunct(int num){
    char buffer[20];
        // 使用 sprintf 將數字轉換為字串
    int len = sprintf(buffer, "%d\n", num);

    // 使用 write 函數將字串寫入標準輸出
    write(1, buffer, len);

}
int main() {
    int number = 50;
    char buffer[20];  // 設定緩衝區大小，這裡設定為足夠容納數字的大小

    // 使用 sprintf 將數字轉換為字串
    printFunct(number);



    return 0;
}