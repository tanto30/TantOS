//
// Created by tanto on 9/9/2018.
//
void main(){
    int i = 0;
    print("SUCCESS");
    while(1);
}

void print(const char *s){
    while(*s){
        __asm__ __volatile__("int  $0x10" : : "a"(0x0E00 | *s), "b"(7));
        s++;
    }
}