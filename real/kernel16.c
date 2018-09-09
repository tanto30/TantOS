// =========================================================
// 8888888888888               888     .d88888b.   .d8888b.
// 8888888888888               888    d88P" "Y88b d88P  Y88b
//      888                    888    888     888 Y88b.
//      888   8888b.  88888b.  888888 888     888  "Y888b.
//      888      "88b 888 "88b 888    888     888     "Y88b.
//      888  .d888888 888  888 888    888     888       "888
//      888  888  888 888  888 Y88b.  Y88b. .d88P Y88b  d88P
//      888  "Y888888 888  888  "Y888  "Y88888P"   "Y8888P"
// =========================================================
//                    By Jonathan Banin
// =========================================================
// GDT - Stores the segments of protected mode
void print_nl(){
    __asm__ __volatile__ ("mov $0xe0a, %ax \n\t int $0x10 \n\t mov $0xe0d, %ax \n\t int $0x10");
}

void print(const char *s){
    while(*s){
        __asm__ __volatile__("int  $0x10" : : "a"(0x0E00 | *s), "b"(7));
        s++;
    }
    print_nl();
}
void main(){
    int i = 0;
    print("SUCCESS");
    print("s");
    while(1);
}