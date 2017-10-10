/* 
 * This module provides communication to the WM8731 audio codec using
 * the audio/video configuration block from the University Program
 *
 * The configuration block only provides write access to the registers of
 * the WM8731 so the codec has to be reinitialized and all the values have 
 * to be kept in memory. 
 * 
 *
 */
#ifndef WM8731_H_INCLUDED
#define WM8731_H_INCLUDED 

#ifndef WM8731_BASE
	#define WM8731_BASE 0xFF200050
	#warning "WM8731_BASE not defined, defining it as 0xFF200000"
#endif

#define WM8731IF_STATUS_OFFSET 0x04
#define WM8731IF_ADDR_OFFSET 0x08
#define WM8731IF_DATA_OFFSET 0x0C

#define WM8731_ACK_BIT_OFFS 0x00
#define WM8731_READY_BIT_OFFS 0x01


#define WM8731_NROF_REGS			11

#define WM8731_LLineIN 			0x00000000
#define WM8731_RLineIN 			0x00000001
#define WM8731_LHeadOUT 		0x00000002
#define WM8731_RHeadOUT 		0x00000003
#define WM8731_AAudioPathCTRL 	0x00000004
#define WM8731_DAudioPathCTRL 	0x00000005
#define WM8731_PwrDownCTRL 		0x00000006
#define WM8731_DAudioIntFormat 	0x00000007
#define WM8731_SamplingCTRL		0x00000008
#define WM8731_ActiveCTRL	 	0x00000009
#define WM8731_Reset	 		0x0000000A


#define WM8731_LLineIN_LINVOL_OFFS		0x00
#define WM8731_LLineIN_LINMUTE_OFFS		0x07
#define WM8731_LLineIN_LRINBOTH_OFFS	0x08

#define WM8731_RLineIN_RINVOL_OFFS		0x00
#define WM8731_RLineIN_RINMUTE_OFFS		0x07
#define WM8731_RLineIN_RLINBOTH_OFFS	0x08

#define WM8731_LHeadOUT_LHPVOL_OFFS		0x00
#define WM8731_LHeadOUT_LZCEN_OFFS		0x07
#define WM8731_LHeadOUT_LRHPBOTH_OFFS	0x08

#define WM8731_RHeadOUT_RHPVOL_OFFS		0x00
#define WM8731_RHeadOUT_RZCEN_OFFS		0x07
#define WM8731_RHeadOUT_RLHPBOTH_OFFS	0x08

#define WM8731_AAudioPathCTRL_MICBOOST_OFFS		0x00
#define WM8731_AAudioPathCTRL_MUTEMIC_OFFS		0x01
#define WM8731_AAudioPathCTRL_INSEL_OFFS		0x02
#define WM8731_AAudioPathCTRL_BYPASS_OFFS		0x03
#define WM8731_AAudioPathCTRL_DACSEL_OFFS		0x04
#define WM8731_AAudioPathCTRL_SIDETONE_OFFS		0x05
#define WM8731_AAudioPathCTRL_SIDEATT_OFFS		0x06

#define WM8731_DAudioPathCTRL_ADCHPD_OFFS		0x00
#define WM8731_DAudioPathCTRL_DEEMP_OFFS		0x01
#define WM8731_DAudioPathCTRL_DACMU_OFFS		0x03
#define WM8731_DAudioPathCTRL_HPOR_OFFS			0x04

#define WM8731_PwrDownCTRL_LINEINPD_OFFS		0x00
#define WM8731_PwrDownCTRL_MICPD_OFFS			0x01
#define WM8731_PwrDownCTRL_ADCPD_OFFS			0x02
#define WM8731_PwrDownCTRL_DACPD_OFFS			0x03
#define WM8731_PwrDownCTRL_OUTPD_OFFS			0x04
#define WM8731_PwrDownCTRL_OSCPD_OFFS			0x05
#define WM8731_PwrDownCTRL_CLKOUTPD_OFFS		0x06
#define WM8731_PwrDownCTRL_POWEROFFS_OFFS		0x07

#define WM8731_DAudioIntFormat_FORMAT_OFFS		0x00
#define WM8731_DAudioIntFormat_IWL_OFFS			0x02
#define WM8731_DAudioIntFormat_LRP_OFFS			0x04
#define WM8731_DAudioIntFormat_LRSWAP_OFFS		0x05
#define WM8731_DAudioIntFormat_MS_OFFS			0x06
#define WM8731_DAudioIntFormat_BCLKINV_OFFS		0x07

#define WM8731_SamplingCTRL_USBNORMAL_OFFS		0x00
#define WM8731_SamplingCTRL_BOSR_OFFS			0x01
#define WM8731_SamplingCTRL_SR_OFFS 			0x02
#define WM8731_SamplingCTRL_CLKIDIV2_OFFS		0x06
#define WM8731_SamplingCTRL_CLKODIV2_OFFS		0x07

#define WM8731_ActiveCTRL_ACTIVE_OFFS 			0x00

#define WM8731_Reset_RESET_OFFS 				0x00


#define WM8731_DAudioIntFormat_IWL_32 0x03
#define WM8731_DAudioIntFormat_IWL_24 0x02
#define WM8731_DAudioIntFormat_IWL_20 0x01
#define WM8731_DAudioIntFormat_IWL_16 0x00

#define WM8731_DAudioIntFormat_FORMAT_DSP 0x3
#define WM8731_DAudioIntFormat_FORMAT_I2S 0x2
#define WM8731_DAudioIntFormat_FORMAT_LeftJust 0x1
#define WM8731_DAudioIntFormat_FORMAT_RightJust 0x0


#define WM8731_MAX_VOL 0x1F
#define WM8731_MIN_VOL 0x00

// 0x00: -34.5dB, 0x1F: 12dB, 1.5dB steps
#define WM8731_DEFAULT_VOLUME_LINE 23			//0dB

// 0b0110000: -73dB, 0b1111111: 6dB, 1dB steps
#define WM8731_DEFAULT_VOLUME_HEADPHONE 121			//0dB


/*
 * Structure that contains the whole register set of the WM8731
 */
typedef struct{
	volatile unsigned int LLineIN;
	volatile unsigned int RLineIN;
	volatile unsigned int LHeadOUT;
	volatile unsigned int RHeadOUT;
	volatile unsigned int AAudioPathCTRL;
	volatile unsigned int DAudioPathCTRL;
	volatile unsigned int PwrDownCTRL;
	volatile unsigned int DAudioIntFormat;
	volatile unsigned int SamplingCTRL;
	volatile unsigned int ActiveCTRL;
	volatile unsigned int Reset;
}tWM8731;


/*
 * Typedefs for use with various functions of the driver (select channel, In/Output...)
 */
typedef enum channel {LEFT,RIGHT} TChannel;
typedef enum source_sink {LINE,HEADPHONE} TSourceSink;

/*
 * Write a 32 bit register to the wm8731 using the Audio/Video-Configuration 
 * from the altera university program.
 * returns 0 on success, -1 on error
 */
int WriteReg(int addr, int val);

/*
 * Set the volume of a selected channel and source/sink.
 */
int SetVolume(TChannel ch, TSourceSink ss, int vol);

/*
 * Writes the whole register set (11 Registers) stored in the internal 
 * structure to the chip.
 */
int WriteRegSet();

#endif //WM8731_H_INCLUDED 
