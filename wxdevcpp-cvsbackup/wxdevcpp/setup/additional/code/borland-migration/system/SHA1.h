/*
	100% free public domain implementation of the SHA-1
	algorithm by Dominik Reichl <dominik.reichl@t-online.de>


	=== Test Vectors (from FIPS PUB 180-1) ===

	SHA1("abc") =
		A9993E36 4706816A BA3E2571 7850C26C 9CD0D89D

	SHA1("abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq") =
		84983E44 1C3BD26E BAAE4AA1 F95129E5 E54670F1

	SHA1(A million repetitions of "a") =
		34AA973C D4C4DAA4 F61EEB2B DBAD2731 6534016F
*/

#ifndef ___SHA1_H___
#define ___SHA1_H___

#include <stdio.h>  // Needed for file access
#include <memory.h> // Needed for memset and memcpy
#include <string.h> // Needed for strcat and strcpy

// If you're compiling big endian, just comment out the following line
#define SHA1_LITTLE_ENDIAN

typedef union
{
	unsigned char c[64];
	unsigned long l[16];
} SHA1_WORKSPACE_BLOCK;

class CSHA1
{
public:
	// Two different formats for ReportHash(...)
	enum
	{
		REPORT_HEX = 0,
		REPORT_DIGIT = 1
	};

	// Constructor and Destructor
	CSHA1();
	virtual ~CSHA1();

	unsigned long m_state[5];
	unsigned long m_count[2];
	unsigned char m_buffer[64];
	unsigned char m_digest[20];

	void Reset();

	// Update the hash value
	void Update(unsigned char *data, unsigned int len);
	bool HashFile(char *szFileName);

	// Finalize hash and report
	void Final();
	void ReportHash(char *szReport, unsigned char uReportType = REPORT_HEX);
	void GetHash(unsigned char *uDest);

private:
	// Private SHA-1 transformation
	void Transform(unsigned long state[5], unsigned char buffer[64]);

	// Member variables
	unsigned char m_workspace[64];
	SHA1_WORKSPACE_BLOCK *m_block; // SHA1 pointer to the byte array above
};

#endif
