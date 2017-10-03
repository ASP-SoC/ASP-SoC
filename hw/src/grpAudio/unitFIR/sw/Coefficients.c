/*------------------------------------------------*/
/*           Simple FIR Testing Driver            */
/*------------------------------------------------*/

#define FIR_COEFF_BASE 0x3000
#define REG_COEFF_1 (volatile double*)(0x0 + FIR_COEFF_BASE)
#define REG_COEFF_2 (volatile double*)(0x4 + FIR_COEFF_BASE)
#define REG_COEFF_3 (volatile double*)(0x8 + FIR_COEFF_BASE)
#define REG_COEFF_4 (volatile double*)(0xC + FIR_COEFF_BASE)
#define REG_COEFF_5 (volatile double*)(0x10 + FIR_COEFF_BASE)
#define REG_COEFF_6 (volatile double*)(0x14 + FIR_COEFF_BASE)

/* -0.000922175232814396 	-0.00273958133314404	-0.00255036555980435 	0.00355621457725423	0.0135493675451046 */

int main()
{
	
	while(1)
	{
		*REG_COEFF_1 = 1;
		*REG_COEFF_2 = 0;
		*REG_COEFF_3 = 0;
		*REG_COEFF_4 = 0;
		*REG_COEFF_5 = 0;
		*REG_COEFF_6 = 0;
	}
	return 0;
}
