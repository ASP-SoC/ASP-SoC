#include <stdint.h>

volatile uint32_t* leds = (uint32_t*)0xFF200010;
volatile uint32_t* switches = (uint32_t*)0xFF200000;

int main(void){
	while(1)
		*leds = *switches;

	return 0;
}
