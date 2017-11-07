#include "../../../../../grpAudioCodec/unitAudioCodecConfig/sw/driver/wm8731.h"

#define LED	24
#define KEY 25

#define IN 0
#define OUT 1

#define ON 1
#define OFF 0

// hps key and led
volatile int *GPIO1_DR_OUT = (int *)	0xFF709000;
volatile int *GPIO1_DDR = (int *) 		0xFF709004;
volatile int *GPIO1_DR_IN = (int *) 	0xFF709050;

volatile int *SWITCHES = (int *) 		0xFF200000;
volatile int *KEYS = (int *) 			0xFF200020;
volatile int *HEX0_2 = (int *) 			0xFF200040;
volatile int *HEX3_5 = (int *) 			0xFF200030;
volatile int *LEDS = (int *) 			0xFF200010;

// function prototypes
int toHex(int num);
void printHex(volatile int *hex_base, int number);

int main(void){
	unsigned int counter = 0;
	int vol = 50;

	// set direction
	// led output, key input
	*GPIO1_DDR = (OUT << LED) | (IN << KEY);

	// show number on hex
	printHex(HEX0_2,0);
	printHex(HEX3_5,0);

	while(1){ // infinite loop
		if(*GPIO1_DR_IN & (1 << KEY)){ // key not pressed
			*GPIO1_DR_OUT = 0; // turn led off
		}
		else { // key pressed
			*GPIO1_DR_OUT = (1 << LED); // turn led on
		}

		
		counter++;
		if(counter % 20000 == 0){
			//volume
			if(*KEYS & 0x01){  // volume up
				vol++;
			}
			else if (*KEYS & 0x02){ // volume down
				vol--;
			}

			if(*KEYS & 0x04){
				vol = 50;
			}

			if(vol > 100){
				vol = 100;
			}
			else if(vol < 0){
				vol = 0;
			}
			printHex(HEX0_2,vol);

			SetVolume(LEFT, LINE, vol/3);
			SetVolume(RIGHT, LINE, vol/3);
		
			WriteRegSet();
		}
		
		*LEDS = *SWITCHES;
	}

	return 0;
}

// print number between 0 and 999 to 7 segment display
void printHex(volatile int *hex_base, int number){
	
	*hex_base = 0; // turn all segments off
	*hex_base |= toHex(number % 10);
	number = number / 10;
	*hex_base |= (toHex(number % 10) << 7);
	number = number / 10;
	*hex_base |= (toHex(number % 10) << 14);
}

// convert integer 0-15 to hex
int toHex(int num){
	switch(num){
		case 0: return 0b0111111; break;
		case 1: return 0b0000110; break;
		case 2: return 0b1011011; break;
		case 3: return 0b1001111; break;
		case 4: return 0b1100110; break;
		case 5: return 0b1101101; break;
		case 6: return 0b1111101; break;
		case 7: return 0b0000111; break;
		case 8: return 0b1111111; break;
		case 9: return 0b1101111; break;
		case 10: return 0b1110111; break;
		case 11: return 0b1111100; break;
		case 12: return 0b0111001; break;
		case 13: return 0b1011110; break;
		case 14: return 0b1111001; break;
		case 15: return 0b1110001; break;
		default: return 0;
	}
}
