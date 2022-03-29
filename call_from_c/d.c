#include <stdio.h>


extern int rprintf (const char*, ...);

int main(int argc, char **argv) {
    // rprintf ("%%");
    rprintf("%s I love %x na %b%%%c \nI %s %x %d%%%c%b\n", "QWEEQWEQWEQW", 3802, 8, '!', "love", 3802, 100, 33, 255);
    return 0;
}