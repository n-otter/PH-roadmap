#include <errno.h>
#include <sys/types.h>
#include <sys/resource.h>
#include <unistd.h>

long memuse1( void ) {

  /* Approximate memory usage of calling process in kbytes
     getrusage() method */

  struct rusage usage;

  long result;

  errno = 0;
  if( 0 == getrusage( RUSAGE_SELF, &usage ) )
    result = usage.ru_maxrss;
  else
    result = -errno;

  return result;

}
