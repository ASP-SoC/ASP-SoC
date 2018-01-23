#include "../../../../../grpAudioCodec/unitAudioCodecConfig/sw/driver/wm8731.h"
#include "ARM_A9_HPS_bridges.h"

#define LW_BASE 0xFF200000

#define LED	24
#define KEY 25

#define IN 0
#define OUT 1

#define ON 1
#define OFF 0


#define LSB 0.00000011920928955078125f

#define LOOP_DELAY 1000000

// hps key and led
volatile int *GPIO1_DR_OUT = (int *)	0xFF709000;
volatile int *GPIO1_DDR = (int *) 		0xFF709004;
volatile int *GPIO1_DR_IN = (int *) 	0xFF709050;

volatile int *SWITCHES = (int *) 		0xFF200000;
volatile int *KEYS = (int *) 			0xFF200020;
volatile int *HEX0_2 = (int *) 			0xFF200040;
volatile int *HEX3_5 = (int *) 			0xFF200030;
volatile int *LEDS = (int *) 			0xFF200010;

int write_LW(unsigned int *data,int offset, int len){
  volatile unsigned int *addr = (unsigned int *) (LW_BASE + offset);
  int i = 0;
    
  while(i < len){
    *addr = data[i];
    i++;
  }
  return 0;
}


// function prototypes
void __delay();
int toHex(int num);
void printHex(volatile int *hex_base, int number);

int main(void){
  unsigned int led_data = 0xAAA;
  unsigned int fir_left[128];
  unsigned int i;
  unsigned int mul[2] = {0x8FFFFF, 0x8FFFFF};
  unsigned int delay=10;
  unsigned int white_noise_enable = 0;
  unsigned int seven_seg1 = 0x39 | (0x5C<<7) | (0x6D<<14);
  unsigned int seven_seg2 = (0x73) | (0x6D<<7) | (0x77<<14);  

  unsigned int text_led[10] = {0x77,0x6D,0x73,0x40,0x6D,0x5C,0x39,0x00,0x00,0x00};
  
  for(i=0;i<128;i++){
    fir_left[i] = (unsigned int) (0);
  }
  
  //fir_left[0]=0x4FFFFF;

  write_LW(&seven_seg1,PIO_HEX0_2_BASE,1);
  write_LW(&seven_seg2,PIO_HEX3_5_BASE,1);
  

  write_LW(&white_noise_enable,ASP_WHITE_NOISE_RIGHT_BASE,1);
  write_LW(&white_noise_enable,ASP_WHITE_NOISE_LEFT_BASE,1);
  
  write_LW(&delay,ASP_DELAY_LEFT_BASE,1);
  write_LW(&delay,ASP_DELAY_RIGHT_BASE,1);
  write_LW(mul,ASP_MULT_OUT_BASE,2);
  

  write_LW(fir_left,ASP_FIR_LEFT_BASE,1);
  write_LW(fir_left,ASP_FIR_RIGHT_BASE,1);
 
  
  // show number on hex
  //printHex(HEX0_2,0);
  //printHex(HEX3_5,0);

  
  
  while(1){ // infinite loop
    static int text_counter = 0;
    
    __delay();
    led_data=0xAAAA;
    write_LW(&led_data,PIO_LEDS_BASE,1);

    __delay();
    led_data=0x5555;
    write_LW(&led_data,PIO_LEDS_BASE,1);



    
    seven_seg2 = (text_led[text_counter] << 14) | (text_led[(text_counter+1)%10] << 7) | (text_led[(text_counter+2)%10]);
    seven_seg1 = (text_led[(text_counter+3)%10] << 14) | (text_led[(text_counter+4)%10] << 7) | (text_led[(text_counter+5)%10]);

    write_LW(&seven_seg1,PIO_HEX0_2_BASE,1);
    write_LW(&seven_seg2,PIO_HEX3_5_BASE,1);
    
    
    if(text_counter == 9){
      text_counter = 0;
    }else{
      text_counter++;
    }
    
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


void __delay(){
  int i;
  for(i=0;i<LOOP_DELAY;i++);
}
