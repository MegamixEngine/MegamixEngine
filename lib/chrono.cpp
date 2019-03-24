/* Permits nanosecond time resolution.
   This should be used for profiling only, since not all computers can implement this. */

#include "common.h"

#include <chrono>

typedef std::chrono::time_point<std::chrono::high_resolution_clock> chrono_t;

chrono_t reference;

// resets timer to 0.
external ty_real
chrono_reset()
{
	reference = std::chrono::high_resolution_clock::now();
	return 0;
}

// current time in seconds, to a resolution at most of milliseconds.
external ty_real
chrono_get()
{
	chrono_t now = std::chrono::high_resolution_clock::now();
	std::chrono::duration<ty_real> diff = now - reference;
	return diff.count();
}

#ifndef IS_DLL

void busywork(long int amount)
{
	volatile long int i = -amount;
	volatile long int j = amount;
	while (i < j)
	{
		i++;
		j += i % 2;
	}
}

int main(int argc, char** argv)
{
	TEST_INIT;
	
	chrono_reset();
	// busy work
	busywork(0x800000);
	
	// *some* amount of time must have passed.
	printf("Time interval for arbitrary busywork was measured as %f ms\n", chrono_get() * 1000.0);
	TEST_ASSERT(chrono_get() > 0);
	
	// one minute is too long for just about any machine.
	TEST_ASSERT(chrono_get() < 60);
	
	// determine granularity.
	double granularity = 0;
	long int amount = 0xc00000;
	printf("Measuring granularity...\n");
	
	while (true)
	{
		chrono_reset();
		busywork(amount);
		// multiply by 87.5%
		amount = (amount >> 1) + (amount >> 2) + (amount >> 3);
		double measured = chrono_get();
		if (measured == 0)
		{
			break;
		}
		else
		{
			granularity = measured;
		}
	}
	
	printf("Granularity is %f ms,\n...which is %f us,\n...or %f ns.\n", granularity * 1000, (granularity * 1000) * 1000, (granularity * 1000) * 1000) * 1000);
	
	if (granularity > 0.0005)
	{
		printf("Unfortunately, your machine does not support high-precision timing.\n");
	}
	
	TEST_END;
}
#endif