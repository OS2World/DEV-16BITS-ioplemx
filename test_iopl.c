#include <stdio.h>
#include <stdlib.h>
#include <os2.h>

/*
  declare the assembler function as 16 bit
*/

VOID _THUNK_FUNCTION (TEST) (ULONG);

/*
  build an interface between the calling programm and the thunk function
*/

USHORT fill_array(ULONG i)
{
   return((USHORT)
      (_THUNK_PROLOG(4);
       _THUNK_FAR16(i);
       _THUNK_CALL(TEST)));
}

int main( void )
{
   ULONG i=0;
   USHORT j=1;
   SHORT *t;
   FILE *ergfile;

/*
  allocate the memory, where the assembler routine will write to
*/
   printf("\nallocating 1,048,577 short integers...");
   t = (SHORT*)calloc(1048577,sizeof(SHORT));
   printf("done.\n\n");

/*
  convert the flat pointer to 16bit format..
*/
   i = _emx_32to16(t);

/*
  ...and call the routine
*/
   printf("calling IOPL routine to fill array...");
   j = fill_array(i);
   printf("done.\n\n");

/*
  write some data points to a file, so we can see that it works
*/
   printf("writing every 64th datapoint to file...");
   ergfile = fopen("test.dat","w");
   for(i=0;i<1048577;i++)
      if( !(i%64)) fprintf(ergfile,"array[%6d]=%6d\n",i,t[i]);
   close(ergfile);
   printf("done.\n");

/*
  free the allocated memory
*/
   free(t);
}
