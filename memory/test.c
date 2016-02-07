
#define N 1000000

#include <stdio.h>
#include <stdlib.h>
#include "memuse1.h"

long memuse1(void);

int main( void ) {

  long m1;

  long *mem;

  int i;

  m1 = memuse1();
  printf( "use1 %ld\n", m1 );

  mem = malloc( N * sizeof( *mem ) );
  for( i = 0; i < N; i++ )
    mem[ i ] = i;
  for( i = 1; i < N; i++ )
    mem[ i ] = mem[ i ] + mem[ i - 1 ];

  m1 = memuse1();
  printf( "use1 %ld\n", m1 );
  printf( "MEM %ld\n", mem[ 3244 ] );

  free( mem );

  m1 = memuse1();
  printf( "use1 %ld\n", m1 );


  return EXIT_SUCCESS;

}

