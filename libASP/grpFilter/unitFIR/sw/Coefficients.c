/*------------------------------------------------*/
/*           Simple FIR Testing Driver            */
/*------------------------------------------------*/

#define HPS_ADDRESS	0xFF200000
#define FIR_COEFF_BASE1 0x1000 + HPS_ADDRESS
#define FIR_COEFF_BASE2 0x3000 + HPS_ADDRESS
#define REG1_COEFF_1 (volatile int*)(0x0 + FIR_COEFF_BASE1)
#define REG1_COEFF_2 (volatile int*)(0x4 + FIR_COEFF_BASE1)
#define REG1_COEFF_3 (volatile int*)(0x8 + FIR_COEFF_BASE1)
#define REG1_COEFF_4 (volatile int*)(0xC + FIR_COEFF_BASE1)
#define REG1_COEFF_5 (volatile int*)(0x10 + FIR_COEFF_BASE1)
#define REG1_COEFF_6 (volatile int*)(0x14 + FIR_COEFF_BASE1)

#define REG2_COEFF_1 (volatile int*)(0x0 + FIR_COEFF_BASE2)
#define REG2_COEFF_2 (volatile int*)(0x4 + FIR_COEFF_BASE2)
#define REG2_COEFF_3 (volatile int*)(0x8 + FIR_COEFF_BASE2)
#define REG2_COEFF_4 (volatile int*)(0xC + FIR_COEFF_BASE2)
#define REG2_COEFF_5 (volatile int*)(0x10 + FIR_COEFF_BASE2)
#define REG2_COEFF_6 (volatile int*)(0x14 + FIR_COEFF_BASE2)

int main()
{		

		*REG2_COEFF_1 = 0x00800000;
		*REG1_COEFF_1 = 0x00800000;
		//*REG2_COEFF_1 = 0x00000000;
		//*REG1_COEFF_1 = 0x00000000;
		*REG1_COEFF_2 = 0x00000000;
		*REG1_COEFF_3 = 0x00000000;
		*REG1_COEFF_4 = 0x00000000;
		*REG1_COEFF_5 = 0x00000000;
		*REG1_COEFF_6 = 0x00000000;

	while(1)
	{
		
	}
	return 0;
}
