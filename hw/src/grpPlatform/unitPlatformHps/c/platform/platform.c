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
volatile int *KEYS = (int *) 			0xFF200010;
volatile int *HEX0_2 = (int *) 			0xFF200020;
volatile int *HEX3_5 = (int *) 			0xFF200030;
volatile int *LEDS = (int *) 			0xFF200040;

void main(){
	// set direction
	// led output, key input
	*GPIO1_DDR = (OUT << LED) | (IN << KEY);

	while(1){ // infinite loop
		if(*GPIO1_DR_IN & (1 << KEY)){ // key not pressed
			*GPIO1_DR_OUT = 0; // turn led off
		}
		else { // key pressed
			*GPIO1_DR_OUT = (1 << LED); // turn led on
		}
		
		*LEDS = *SWITCHES;
	}
}
