/**********************************************************************************
borfunctions.cpp: Implementation of the BCB/Delphi like functions for wx

Written by: Guru Kathiresan
Email: gururamnath@yahoo.com

You may use this class/code as you wish in your programs. Feel free to distribute it,and
email suggested changes to me.

Current Version: 0.1
Release Date: 10/20/2004

History:
Date Who What
--------------------------------------------------------------------
10/20/2004 Guru Kathiresan 0.1 Intial Release

**********************************************************************************/

#include "borfunctions.h"

//Conversion Functions
wxString IntToStr(int i)
{
wxString Result;
Result = Result.Format("%d",i);
return Result;
}

wxString FloatToStr(float f)
{
wxString Result;
Result = Result.Format("%f",f);
return Result;
}

long StrToInt(wxString &str)
{
long myVal;
str.ToLong(&myVal);
return myVal;
}

double StrToDouble(wxString &str)
{
double dblVal;
str.ToDouble(&dblVal);
return dblVal;
}

//String manipulation functions
wxString Copy(wxString &str, int Index, int Count)
{
wxString Result = str. SubString(Index,Index+Count);
return Result;
}

int Pos(wxString& substr, wxString& str)
{
return str.Find((char *)substr.c_str());

}
void Trim(wxString& str1)
{
str1 = str1.Trim();
}

wxString Trim(wxString str1)
{
return str1.Trim();
}

int Length(wxString str)
{
return str.Length();
}

wxString LowerCase(const wxString str)
{
return str.Lower();
}
wxString UpperCase(const wxString str)
{
return str.Upper();
}


int LastDelimiter ( wxString Delimiters, wxString Source)
{
for (int i=Source.Length();i>0 ; i-- )
{
if (Pos(wxString(Source.GetChar(i)),Delimiters) !=-1)
{
return i;
}
}
return -1;
}

bool AnsiStartsStr(wxString& substr, wxString& str)
{
return str.StartsWith(substr);
}

bool AnsiStartsText(wxString& substr, wxString& str)
{
return str.Upper().StartsWith(substr.Upper());
}

bool AnsiEndsStr(wxString& substr, wxString& str)
{
if (substr.Length() > str.Length())
return false;
if (substr.CmpNoCase(str.Right(substr.Length())) ==0 )
{
return true;
}
else
{
return false;
}
}
bool AnsiEndsText(wxString& substr, wxString& str)
{
return AnsiEndsStr(substr.Upper(), str.Upper());
}

wxArrayString StringToTokens(wxString str1,wxString strDelimiter,wxStringTokenizerMode mode)
{
wxArrayString Result;
wxStringTokenizer tkz(str1,strDelimiter,mode);

while ( tkz.HasMoreTokens() )
{
wxString token = tkz.GetNextToken();
Result.Add(token);
}


return Result;
}

wxString ArrayStringToString(const wxArrayString &aryStr)
{
wxString result;
for(int i=0;i<aryStr.GetCount();i++)
{
result+=aryStr.Item(i);
//FixMe: Add the generic delimiter here
result+="\r\n";
}
return result;
}

bool LoadArrayStringFromFile(wxString strFileName,wxArrayString &aryStr)
{
aryStr.Clear();
wxTextFile txtFile(strFileName);
txtFile.Open();
if (txtFile.IsOpened() == FALSE)
{
return false;
}
int TotalLines = txtFile.GetLineCount();
for(int i=0;i<txtFile.GetLineCount();i++)
{
aryStr.Add(txtFile.GetLine(i));
}
return true;

}

bool SaveArrayStringToFile(wxString strFileName,const wxArrayString &aryStr)
{
wxTextFile txtFile(strFileName);
txtFile.Create();

for(int i=0;i<aryStr.GetCount();i++)
{
txtFile.AddLine(aryStr.Item(i));
}
txtFile.Close();
return true;
}

bool LoadStringFromFile(wxString strFileName,wxString &strcontent)
{
wxTextFile txtFile(strFileName);
txtFile.Open();
if (txtFile.IsOpened() == FALSE)
{
return false;
}
strcontent="";
int TotalLines = txtFile.GetLineCount();
for(int i=0;i<txtFile.GetLineCount();i++)
{
strcontent += txtFile.GetLine(i);
}
return true;

}

bool SaveStringToFile(wxString strFileName,const wxString strcontent)
{
wxTextFile txtFile(strFileName);
txtFile.Create();
txtFile.AddLine(strcontent);
txtFile.Close();
return true;

}

bool IsStringEmpty(wxString str1)
{
if (str1.Trim().Upper().CmpNoCase("") ==0)
{
return true;
}
else
{
return false;
}
}



bool IsStringEqualsU(wxString str1,wxString str2)
{
if (str1.Trim().Upper().CmpNoCase(str2.Trim().Upper()) ==0)
{
return true;
}
else
{
return false;
}
}

bool IsStringEquals(wxString str1,wxString str2)
{
if (str1.Cmp(str2) ==0)
{
return true;
}
else
{
return false;
}
}


bool StrContains(wxString str1,wxString strToFind)
{
	if (Pos(strToFind,str1) == -1)
	{
		return false;
	}
	else
	{
	return true;
	}
}
bool StrContainsU(wxString str1,wxString strToFind)
{
	
return StrContains(str1.MakeUpper(),strToFind.MakeUpper());
}

//Dir and Files Manipulation
bool ForceDirectories(wxString& FullFileName)
{
wxFileName fn(FullFileName);
wxArrayString aryString = fn.GetDirs();
wxString PartialFullDir;
PartialFullDir = PartialFullDir.Format("%s%s%c%s%c",fn.GetVolume(),fn.GetVolumeSeparator(),fn.GetPathSeparator(),aryString.Item(0),fn.GetPathSeparator());
if (wxDir::Exists(PartialFullDir) == false)
{
fn.Mkdir(PartialFullDir);
}
for(int i=1;i<aryString.Count();i++)
{
PartialFullDir = PartialFullDir.Format("%s%s%c",PartialFullDir,aryString.Item(i),fn.GetPathSeparator());
if (wxDir::Exists(PartialFullDir) == false)
{
fn.Mkdir(PartialFullDir);
}

}
return true;
}

wxString ChangeFileExt(wxString FileName,wxString ext)
{
wxFileName fnobj(FileName);
fnobj.SetExt(ext);
return fnobj.GetFullPath();
}

wxString ExtractFileDir( const wxString FullFileName)
{
wxFileName fnobj(FullFileName);
return fnobj.GetPath();
}

wxString ExtractFileDrive( const wxString FullFileName)
{
//FixMe:
wxString result;
return result;
}

wxString ExtractFilePath ( const wxString FullFileName)
{
//FixMe:
wxFileName fnobj(FullFileName);
return fnobj.GetPath();
}

wxString ExtractFileName ( const wxString FullFileName)
{
wxFileName fnobj(FullFileName);
return fnobj.GetName();
}

wxString ExtractFileExt ( const wxString FullFileName)
{
wxFileName fnobj(FullFileName);
return fnobj.GetExt();
}

//System functions
bool CopyTextToClipboard(wxString strVal)
{
if (wxTheClipboard->Open())
{
wxTheClipboard->SetData( new wxTextDataObject(strVal) );
wxTheClipboard->Close();
return true;
}
else
{
return false;
}

}

//Date Time Functions
int TimeHour(wxDateTime dt)
{
return dt.GetHour();
}
int TimeMin(wxDateTime dt)
{
return dt.GetMinute();
}
int TimeSec(wxDateTime dt)
{
return dt.GetSecond();
}
int DateDay(wxDateTime dt)
{
return dt.GetDay();
}
int DateMonth(wxDateTime dt)
{
return dt.GetMonth();
}
int DateYear(wxDateTime dt)
{
return dt.GetYear();
}

wxString DateToString(wxDateTime dt)
{
return dt.FormatDate();
}

wxString TimeToString(wxDateTime dt)
{
return dt.FormatTime();
}

//Dialog related Functions
bool QuestionDlg(const wxString Msg,wxWindow* parent)
{
wxMessageDialog msgDlg(parent,Msg,_("Question"),wxYES_NO | wxICON_QUESTION);
if (msgDlg.ShowModal() == wxYES)
{
return true;
}
else
{
return false;
}
}
void InformationDlg(const wxString Msg,wxWindow* parent)
{
wxMessageDialog msgDlg(parent,Msg,_("Question"),wxOK | wxICON_INFORMATION);
msgDlg.ShowModal();
}

bool ConfirmationDlg(const wxString Msg,wxWindow* parent)
{
wxMessageDialog msgDlg(parent,Msg,_("Confirmation"),wxOK | wxCANCEL | wxICON_QUESTION);
if (msgDlg.ShowModal() == wxOK)
{
return true;
}
else
{
return false;
}
}

void ErrorDlg(const wxString Msg,wxWindow* parent)
{
wxMessageDialog msgDlg(parent,Msg,_("Error"),wxOK | wxICON_ERROR );
msgDlg.ShowModal();
}

wxString InputBox(wxString Caption, wxString Prompt, wxString Default,wxWindow *parent)
{
return ::wxGetTextFromUser(Prompt,Caption,Default,parent);
}

bool InputQuery(wxString Caption, wxString Prompt, wxString &UserValue,wxWindow *parent)
{
wxString Result = ::wxGetTextFromUser(Prompt,Caption,UserValue,parent);
if (wxIsEmpty(Result.Trim()) == true)
{
return false;
}
else
{
UserValue=Result;
return true;
}
}

int MessageDlg ( wxString Message , int DialogType, int Buttons,wxWindow *parent)
{
return ::wxMessageBox(Message,_("Message"), DialogType | Buttons,parent);
}

void ShowMessage ( const wxString Text,wxWindow *parent)
{
MessageDlg(Text,0,wxOK,parent);
} 