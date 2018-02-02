#include "../../../../../grpAudioCodec/unitAudioCodecConfig/sw/driver/wm8731.h"
#include "ARM_A9_HPS_bridges.h"
#include <stdio.h>

#define LW_BASE 0xFF200000

#define LED	24
#define KEY 25

#define IN 0
#define OUT 1

#define ON 1
#define OFF 0


#define LSB 0.00000011920928955078125f

#define LOOP_DELAY 1000000


// function prototypes
void __delay();
int toHex(int num);
void printHex(volatile int *hex_base, int number);
int write_LW(unsigned int *data,int offset, int len);
void rotate_display_hex(unsigned char *text, int len);

int main(void){
  unsigned int led_data = 0xAAA;

  // Low-pass filter with fg=0.3
  int fir_lp[128] = {-525 ,2432 ,3524 ,1703 ,-1811 ,-4234 ,-3285 ,792 ,4950 ,5446 ,1054 ,-5263 ,-8121 ,-4123 ,4551 ,10919 ,8609 ,-2094 ,-13097 ,-14355 ,-2757 ,13616 ,20741 ,10379 ,-11283 ,-26643 ,-20673 ,4950 ,30481 ,32913 ,6232 ,-30358 ,-45655 ,-22576 ,24272 ,56744 ,43636 ,-10366 ,-63397 ,-68071 ,-12834 ,62325 ,93576 ,46269 ,-49823 ,-116872 ,-90359 ,21631 ,133636 ,145374 ,27863 ,-138082 ,-212562 ,-108368 ,121153 ,297626 ,243694 ,-62703 ,-424951 ,-522329 ,-118440 ,752057 ,1754741 ,2422425 ,2422425 ,1754741 ,752057 ,-118440 ,-522329 ,-424951 ,-62703 ,243694 ,297626 ,121153 ,-108368 ,-212562 ,-138082 ,27863 ,145374 ,133636 ,21631 ,-90359 ,-116872 ,-49823 ,46269 ,93576 ,62325 ,-12834 ,-68071 ,-63397 ,-10366 ,43636 ,56744 ,24272 ,-22576 ,-45655 ,-30358 ,6232 ,32913 ,30481 ,4950 ,-20673 ,-26643 ,-11283 ,10379 ,20741 ,13616 ,-2757 ,-14355 ,-13097 ,-2094 ,8609 ,10919 ,4551 ,-4123 ,-8121 ,-5263 ,1054 ,5446 ,4950 ,792 ,-3285 ,-4234 ,-1811 ,1703 ,3524 ,2432 ,-525};

  unsigned int mul[2] = {0.5/LSB, 0.25/LSB};
  unsigned int delay=10;
  unsigned int white_noise_enable = 0;
  unsigned int seven_seg1 = 0x39 | (0x5C<<7) | (0x6D<<14);
  unsigned int seven_seg2 = (0x73) | (0x6D<<7) | (0x77<<14);

  unsigned int fir_enable = 1;

  unsigned char text_led[10] = {0x77,0x6D,0x73,0x40,0x6D,0x5C,0x39,0x00,0x00,0x00};

  write_LW(&seven_seg1,PIO_HEX0_2_BASE,1);
  write_LW(&seven_seg2,PIO_HEX3_5_BASE,1);
  

  write_LW(&white_noise_enable,ASP_WHITE_NOISE_RIGHT_BASE,1);
  write_LW(&white_noise_enable,ASP_WHITE_NOISE_LEFT_BASE,1);
  
  write_LW(&delay,ASP_DELAY_LEFT_BASE,1);
  write_LW(&delay,ASP_DELAY_RIGHT_BASE,1);
  write_LW(mul,ASP_MULT_OUT_BASE,2);
  

  write_LW((unsigned int *)fir_lp,ASP_FIR_LEFT_S0_COEFFS_BASE,128);
  write_LW((unsigned int *)fir_lp,ASP_FIR_RIGHT_S0_COEFFS_BASE,128);

  write_LW(&fir_enable,ASP_FIR_LEFT_S1_ENABLE_BASE,1);
  write_LW(&fir_enable,ASP_FIR_RIGHT_S1_ENABLE_BASE,1);
  
  while(1){ // infinite loop
    __delay();
    led_data = ~led_data;
    write_LW(&led_data,PIO_LEDS_BASE,1);

    rotate_display_hex(text_led,sizeof(text_led));
  }
  
  return 0;
}

int write_LW(unsigned int *data,int offset, int len){
  volatile unsigned int *addr = (unsigned int *) (LW_BASE + offset);
  int i = 0;
  
  while(i < len){
    //printf("writing: 0x%08x to0x08x\n", addr);
    
    *addr = data[i];
    i++;
    addr++;
  }
  return 0;
}

void rotate_display_hex(unsigned char *text, int len){
  static int text_counter = 0;
  unsigned int seven_seg1, seven_seg2;

  seven_seg2 = (text[text_counter] << 14) | (text[(text_counter+1)%10] << 7) | (text[(text_counter+2)%10]);
  seven_seg1 = (text[(text_counter+3)%10] << 14) | (text[(text_counter+4)%10] << 7) | (text[(text_counter+5)%10]);

  write_LW(&seven_seg1,PIO_HEX0_2_BASE,1);
  write_LW(&seven_seg2,PIO_HEX3_5_BASE,1);

  
  if(text_counter == 9){
    text_counter = 0;
  }else{
    text_counter++;
  }

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
