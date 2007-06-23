// wxlibversion.cpp
// Turns a string like 2.5.1 into just 25
// Used for our devpak maker in wxDev-C++
// 
// Tony Reina
// 23 June 2007
// Freeware/Public domain

#include <cstdlib>
#include <vector>
#include <iostream>

// This is the name to use for the command shell variable
#define ENV_VAR_NAME  "WXLIBVERSION"

using namespace std;

// Break the input string up by the token (default is .)
void Tokenize(const string& str,
                      vector<string>& tokens,
                      const string& delimiters = ".")
{
    // Skip delimiters at beginning.
    string::size_type lastPos = str.find_first_not_of(delimiters, 0);
    // Find first "non-delimiter".
    string::size_type pos     = str.find_first_of(delimiters, lastPos);

    while (string::npos != pos || string::npos != lastPos)
    {
        // Found a token, add it to the vector.
        tokens.push_back(str.substr(lastPos, pos - lastPos));
        // Skip delimiters.  Note the "not_of"
        lastPos = str.find_first_not_of(delimiters, pos);
        // Find next "non-delimiter"
        pos = str.find_first_of(delimiters, lastPos);
    }
}


int main(int argc, char *argv[])
{
 
    // If less than 2 arguments, then print error message
    if (argc < 2) {
        cout <<  "Takes the wxWidgets library "
              "version name and strips the periods "
              "from the string." << endl << endl;
        cout << "Usage: wxlibversion.exe WXLIBVERSION" << endl;
        cout << "e.g. wxlibversion.exe 2.5.6" << endl;
        cout << "          will output" << endl;
        cout << "             SET " ENV_VAR_NAME "=25" << endl << endl;
        return EXIT_FAILURE;
    }
    else {
     
        string input(argv[1]);
        vector<string> tokenized;
   
        Tokenize(input, tokenized, ".");
    
        cout << "SET " ENV_VAR_NAME "=";
    
        // Just output the first two numbers (or less)
        for (int i = 0; i < (tokenized.size() >= 2 ? 2 : tokenized.size()); i++)
            cout << tokenized.at(i);
       
        cout << endl;
        return EXIT_SUCCESS;
    }
}
