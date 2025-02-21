#include <stdio.h>
#include <stdlib.h>
#include <gpio.h>
#include <iosim.h>

//---------------------------------------------------------
#define MY_ID 208389577*10 
#define MY_N 24 
#define vec (*(volatile unsigned int (*)[MY_N])(0x00002000)) // dereferences a pointer to an array of MY_N elements  
//#define vec (*(volatile unsigned int (*)[MY_N])(0x00001ffc)) // dereferences a pointer to an array of MY_N elements  
#define my_index_addr 0x00001ffc
//#define my_index_addr 0x00001ff8
#define done_flag_addr 0xffffffff
 
//---------------------------------------------------------

int main(void) { 
  
  int n = MY_N ;

  for (int i = 0 ; i < n-1 ; i++)
    for (int j = 0 ; j < n-i-1 ; j++) { 		
      if (vec[j] > vec[j+1]) {
		// Swapping
        unsigned int swap = vec[j];
        vec[j]   = vec[j+1];
        vec[j+1] = swap;
      }
  }

for (int i=0 ; i<n ; i++)
    if (vec[i] == MY_ID) {
      *((volatile unsigned int *) my_index_addr) = i;
      break;
    }


 *((volatile unsigned char *) done_flag_addr) = 1 ;
 
 return 0; 

}
