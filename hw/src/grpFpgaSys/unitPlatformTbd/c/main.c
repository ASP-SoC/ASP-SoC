// base addresses pointer
volatile int *flanger = (int *) 0x0002020;

// main function
void main(){ 

	// infinite loop
	while (1){
		*flanger = 30;
		
	}
		
}
