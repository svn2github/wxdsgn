
//XOR256.cpp

#include "XOR256.h"
#include <exception>

using namespace std;

char const* CStreamXOR256::m_szMessage = "Key Not Set";

//CONSTRUCTOR
CStreamXOR256::CStreamXOR256(string const& rostrKey, int iRounds)
{
	if(iRounds < 1)
		throw exception("Number of Rounds should be at least 1");
	m_iRounds = iRounds;
	m_iRounds1 = m_iRounds-1;
	m_pucSeqX = new unsigned char[m_iRounds];
	m_pucSeqM = new unsigned char[m_iRounds];
	int iKeyLen = rostrKey.size();
	if(iKeyLen < 1)
		throw exception("Key Lenght should be at least 1");
	m_oArcfourPRNG.SetKey((unsigned char*)rostrKey.c_str(), iKeyLen);
	m_ucPrev0 = m_oArcfourPRNG.Rand();
	m_ucPrev = m_ucPrev0;
}

//DESTRUCTOR
CStreamXOR256::~CStreamXOR256()
{
	if(m_pucSeqX != NULL)
		delete [] m_pucSeqX;
	if(m_pucSeqM != NULL)
		delete [] m_pucSeqM;
}

void CStreamXOR256::Reset()
{
	m_oArcfourPRNG.Reset();
	m_oArcfourPRNG.Rand();
	m_ucPrev = m_ucPrev0;
}

//Encryption Function
void CStreamXOR256::Encrypt(string const& rostrIn, string& rostrOut)
{
	rostrOut.resize(rostrIn.size());
	unsigned char ucCipher;
	for(int i=0; i<rostrIn.size(); i++)
	{
		//The first round
		m_ucPrev ^= rostrIn[i];
		ucCipher = (m_ucPrev ^ m_oArcfourPRNG.Rand()) + m_oArcfourPRNG.Rand();
		//The last m_iRounds-1 rounds
		for(int j=1; j<m_iRounds; j++)
		{
			ucCipher ^= m_oArcfourPRNG.Rand();
			ucCipher += m_oArcfourPRNG.Rand();
		}
		rostrOut[i] = ucCipher;
	}
}

//Decryption Function
void CStreamXOR256::Decrypt(string const& rostrIn, string& rostrOut)
{
	rostrOut.resize(rostrIn.size());
	unsigned char* pucSeqX;
	unsigned char* pucSeqM;
	unsigned char ucPlain;
	int i, j;
	for(i=0; i<rostrIn.size(); i++)
	{
		//Calculate the constants
		pucSeqX = m_pucSeqX;
		pucSeqM = m_pucSeqM;
		for(j=0; j<m_iRounds; j++)
		{
			*(pucSeqX++) = m_oArcfourPRNG.Rand();
			*(pucSeqM++) = m_oArcfourPRNG.Rand();
		}
		//The last m_iRounds-1 rounds
		ucPlain = rostrIn[i];
		pucSeqX = m_pucSeqX + m_iRounds1;
		pucSeqM = m_pucSeqM + m_iRounds1;
		for(j=m_iRounds-1; j>0; j--,pucSeqX--,pucSeqM--)
		{
			if(*pucSeqM <= ucPlain)
				ucPlain -= *pucSeqM;
			else
				(ucPlain += ~*pucSeqM)++;
			ucPlain ^= *pucSeqX;
		}
		//First round
		if(*m_pucSeqM <= ucPlain)
			ucPlain -= *m_pucSeqM;
		else
			(ucPlain += ~*m_pucSeqM)++;
		ucPlain ^= m_ucPrev ^ *m_pucSeqX;
		rostrOut[i] = ucPlain;
		m_ucPrev ^= ucPlain;
	}
}

