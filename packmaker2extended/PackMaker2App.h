//---------------------------------------------------------------------------
//
// Name:        PackMaker2App.h
// Author:      Programming
// Created:     14/05/2007 17:42:15
// Description: 
//
//---------------------------------------------------------------------------

#ifndef __PACKMAKER2FRMApp_h__
#define __PACKMAKER2FRMApp_h__

#ifdef __BORLANDC__
	#pragma hdrstop
#endif

#ifndef WX_PRECOMP
	#include <wx/wx.h>
#else
	#include <wx/wxprec.h>
#endif

class PackMaker2FrmApp : public wxApp
{
	public:
		bool OnInit();
		int OnExit();
};

#endif
