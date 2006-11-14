
//XOR256.h

#ifndef __XOR256_H__
#define __XOR256_H__

#include "ArcfourPRNG.h"
#include <string>

using namespace std;

class CStreamXOR256
{
public:
	//CONSTRUCTOR
	CStreamXOR256(string const& rostrKey, int iRounds);
	//DESTRUCTOR
	virtual ~CStreamXOR256();
	void Reset();
	void Encrypt(string const& rostrIn, string& rostrOut);
	void Decrypt(string const& rostrIn, string& rostrOut);

protected:
	static char const* m_szMessage;
	//PRNG
	CArcfourPRNG m_oArcfourPRNG;
	//Number of Rounds
	int m_iRounds;
	int m_iRounds1; //m_iRounds-1
	unsigned char* m_pucSeqX;
	unsigned char* m_pucSeqM;
	unsigned char m_ucPrev0;
	unsigned char m_ucPrev;
};

#endif //__XOR256_H__

