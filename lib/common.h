#pragma once

#define external          \
	extern "C"            \
	__declspec(dllexport)
	
#define TEST_INIT size_t testnum = 0;
#define TEST_ASSERT(x) {if (!(x)) {printf("Assertion failed on line %d!\n", __LINE__); return -1;} else {testnum++;}}
#define TEST_END {printf("All %d tests passed.\n\n", testnum); return 0;}

typedef double ty_real;
typedef char* ty_string;