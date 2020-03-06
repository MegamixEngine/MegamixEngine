#pragma once

#ifndef __unix__ 

#define external          \
	extern "C"            \
	__declspec(dllexport)

#else
#define external          \
	extern "C"

#endif

#define TEST_INIT size_t testnum = 0;
#define TEST_ASSERT(x) {if (!(x)) {printf("Assertion failed on line %d!\n", __LINE__); return -1;} else {testnum++;}}
#define TEST_END {printf("All %d tests passed.\n\n", static_cast<int32_t>(testnum)); return 0;}

typedef double ty_real;
typedef char* ty_string;

#include <iostream>