#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void) {
    setuid(0);
    setgid(0);

    puts("Follow no path... Make your own!!! Life is what you make it...");
    puts("Your faitfhully,");

    system("whoami");

    return 0;
}
