#ifndef __BASE_H
#define __BASE_H

class MainApp: public wxApp
{
  public:
      virtual bool OnInit();
};

class MainFrame: public wxFrame
{
  public:
      MainFrame(const wxString &title, const wxPoint &pos, const wxSize &size);
      void OnQuit(wxCommandEvent &event);
  private:
      DECLARE_EVENT_TABLE()
};

enum
{
   ID_MAINWIN_QUIT = wxID_HIGHEST+1
};


#endif
