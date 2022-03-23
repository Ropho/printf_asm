#include <stdio.h>


extern int rprintf (const char*, ...);

int main(int argc, char **argv) {

    rprintf ("%x %c %c %c %c %s %c %d    !", 123, '2', '3', '4', '5', "22", '7', 4444);

    return 0;
}