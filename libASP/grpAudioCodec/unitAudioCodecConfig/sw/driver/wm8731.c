#include "wm8731.h"

/*
 * Pointers to the registers of the Audio/Video-Configuration block.
 */
unsigned int volatile * const WM8731IF_STATUS = (unsigned int*) (WM8731_BASE + WM8731IF_STATUS_OFFSET);
unsigned int volatile * const WM8731IF_ADDR = (unsigned int*) (WM8731_BASE + WM8731IF_ADDR_OFFSET);
unsigned int volatile * const WM8731IF_DATA = (unsigned int*) (WM8731_BASE + WM8731IF_DATA_OFFSET);


// audio pll output clock: 12.288MHz, sample rate: 48kHz, BOSR: 256fs(0), SR: 0x00

/*
 * Internal structure representing the register set of the wm8711
 * Default values are entered here.
 */
tWM8731 wm8731 = {
	WM8731_DEFAULT_VOLUME_LINE,			// default volume left line in, unmuted, no simultaneous load
	WM8731_DEFAULT_VOLUME_LINE,			// default volume right line in, unmuted, no simultaneous load
	WM8731_DEFAULT_VOLUME_HEADPHONE,	// default volume left headphone, unmuted, no simultaneous load
	WM8731_DEFAULT_VOLUME_HEADPHONE,	// default volume right headphone, unmuted, no simultaneous load
	1<<WM8731_AAudioPathCTRL_DACSEL_OFFS,			// no boost, don't mute mic, select Line-In, disable bypass, select DAC, no sidetone
	0x00,								// no ADC high pass, no deemp, dac mute, clear DC offset
	0x00,								// linein on, mic on, adc on, dac on, outputs on, oscillator on, clkout on, POWERON
	(WM8731_DAudioIntFormat_FORMAT_LeftJust << WM8731_DAudioIntFormat_FORMAT_OFFS)  | (WM8731_DAudioIntFormat_IWL_24 << WM8731_DAudioIntFormat_IWL_OFFS) | (1<<WM8731_DAudioIntFormat_MS_OFFS),			// left justified, 24 bit, DACLRC low: right, no swap, master mode, no BLCK invert
	0x00,								// normal mode, 256fs oversampling, sample rate 48kHz, no CLKIDIV2 , CLKODIV2 not used
	0x01,								// activate interface
	0x01, 								// no reset
};


int WriteReg(int addr, int val){
	*WM8731IF_ADDR = addr;
	while(((*WM8731IF_STATUS) & (1<<WM8731_READY_BIT_OFFS)) == 0);	// wait on Ready bit to be set

	*WM8731IF_DATA = val;
	while(((*WM8731IF_STATUS) & (1<<WM8731_READY_BIT_OFFS)) == 0);	// wait on Ready bit to be set

	if(((*WM8731IF_STATUS) & (1<<WM8731_ACK_BIT_OFFS)) == 0){			// error in write
		return -1;
	}

	return 0;
}



int SetVolume(TChannel ch, TSourceSink ss, int vol){
	if( vol > WM8731_MAX_VOL ){					//clip the volume to the max range
		vol = WM8731_MAX_VOL;
	}else if(vol < WM8731_MIN_VOL){
		vol = WM8731_MIN_VOL;
	}

	if(ss == LINE){
		if(ch == LEFT){				
			wm8731.LLineIN = vol;			//mute is overwritten
		}else if(ch == RIGHT){
			wm8731.RLineIN = vol;			//mute is overwritten
		}

	}else if( ss == HEADPHONE ){
		if(ch == LEFT){				
			wm8731.LHeadOUT = vol;			//mute is overwritten
		}else if(ch == RIGHT){
			wm8731.RHeadOUT = vol;			//mute is overwritten
		}
	}

	
	

	return 0;
}

int WriteRegSet(){
	int i;
	int * pStructure = &(wm8731.LLineIN);

	for(i=0; i<WM8731_NROF_REGS; i++){
		WriteReg(i, *pStructure);
		pStructure++;
	}

	return 0;
}


