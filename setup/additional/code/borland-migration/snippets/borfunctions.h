/**********************************************************************************
borfunctions.h: Declaration of the BCB/Delphi like functions for wx

Written by: Guru Kathiresan
Email: later

You may use this class/code as you wish in your programs. Feel free to distribute it,and
email suggested changes to me.

Current Version: 0.1
Release Date: 10/20/2004

History:
Date Who What
--------------------------------------------------------------------
10/20/2004 Guru Kathiresan 0.1 Intial Release

**********************************************************************************/


#include <wx/wx.h>
#include <wx/string.h>
#include <wx/filename.h>
#include <wx/dir.h>
#include <wx/textfile.h>
#include <wx/arrstr.h>
#include <wx/clipbrd.h>
#include <wx/tokenzr.h>
#include <wx/string.h>

//Conversion Functions
wxString IntToStr(int i);
wxString FloatToStr(float f);
long StrToInt(wxString &str);
double StrToDouble(wxString &str);

//String Manipulation
wxString Copy(wxString &str, int Index, int Count);
int Pos(wxString& substr, wxString& str);
void Trim(wxString& str1);
wxString Trim(const wxString str1);
int Length(wxString str);
wxString LowerCase(const wxString str);
wxString UpperCase(const wxString str);
int LastDelimiter ( wxString Delimiters, wxString Source);

bool AnsiStartsStr(wxString& substr, wxString& str);
bool AnsiStartsText(wxString& substr, wxString& str);

bool AnsiEndsStr(wxString& substr, wxString& str);
bool AnsiEndsText(wxString& substr, wxString& str);


wxArrayString StringToTokens(wxString str1,wxString strDelimiter,wxStringTokenizerMode mode);
wxString ArrayStringToString(const wxArrayString aryStr);

bool LoadArrayStringFromFile(wxString strFileName,wxArrayString &aryStr);
bool SaveArrayStringToFile(wxString strFileName,const wxArrayString aryStr);

bool LoadStringFromFile(wxString strFileName,wxString &strcontent);
bool SaveStringToFile(wxString strFileName,const wxString strcontent);

bool IsStringEmpty(wxString str1);
bool IsStringEqualsU(wxString str1,wxString str2);
bool IsStringEquals(wxString str1,wxString str2);

bool StrContains(wxString str1,wxString strToFind);
bool StrContainsU(wxString str1,wxString strToFind);

//Files and Dir functions
bool ForceDirectories(wxString& FullFileName);
wxString ChangeFileExt(wxString FileName,wxString ext) ;
wxString ExtractFileDir( const wxString FullFileName);
wxString ExtractFileDrive( const wxString FullFileName);
wxString ExtractFilePath ( const wxString FullFileName);
wxString ExtractFileName ( const wxString FullFileName);
wxString ExtractFileExt ( const wxString FullFileName);

//System functions
bool CopyTextToClipboard(wxString strVal);

//Date Time Functions
int TimeHour(wxDateTime dt);
int TimeMin(wxDateTime dt);
int TimeSec(wxDateTime dt);

int DateDay(wxDateTime dt);
int DateMonth(wxDateTime dt);
int DateYear(wxDateTime dt);

wxString DateToString(wxDateTime dt);
wxString TimeToString(wxDateTime dt);

wxString TimeAMString(wxDateTime dt);
wxString TimePMString(wxDateTime dt);

wxDateTime IncMonth(const wxDateTime dt);
wxDateTime IncMonth(const wxDateTime dt);
wxDateTime IncYear(const wxDateTime dt);

void IncMonth(wxDateTime &dt);
void IncMonth(wxDateTime &dt);
void IncYear(wxDateTime &dt);

//Dialog Related Functions
bool QuestionDlg(const wxString Msg,wxWindow* parent /*= NULL*/);
void InformationDlg(const wxString Msg,wxWindow* parent /*= NULL*/);
bool ConfirmationDlg(const wxString Msg,wxWindow* parent/*= NULL*/);
void ErrorDlg(const wxString Msg,wxWindow* parent /*= NULL*/);

wxString InputBox(wxString Caption, wxString Prompt, wxString Default,wxWindow* parent/*= NULL*/);
bool InputQuery(wxString Caption, wxString Prompt, wxString &UserValue,wxWindow* parent/*= NULL*/);
int MessageDlg ( wxString Message , int DialogType, int Buttons,wxWindow* parent/*= NULL*/);
void ShowMessage ( const wxString Text,wxWindow* parent/*= NULL*/);
