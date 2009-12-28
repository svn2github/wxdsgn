unit wxversion;

interface

const

{$IFDEF WIN32}
  pd                   = '\';
{$ENDIF}

resourcestring
  // misc strings
  DEVCPP = 'wxDev-C++';
  WXDEVCPP_VERSION = '7.3.0.1';

  // EAB Comment: I think this would be better if stored on a config file and not compiled along with the plugin.
  COMMON_CPP_INCLUDE_DIR      =
//The Dir are taken from bottom to up. So I added the dir in the inverted order in which
//they are picked by the parser.
                       'include' + pd + 'common;'
                       +'include' + pd + 'common' + pd + 'wx;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'xrc;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'xml;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'svg;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'stc;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'protocol;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'plot;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'ogl;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'net;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'mmedia;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'html;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'gizmos;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'fl;'
                       //+ 'include' + pd + 'common' + pd+ 'wx' + pd + 'animate;'     EAB TODO: not found
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'generic;'
                       + 'include' + pd + 'common' + pd+ 'wx' + pd + 'msw;'                       
                       + 'include' + pd + '3rdparty;'
                       + 'include' + pd + '3rdparty' + pd + 'wx;'
                       + 'include' + pd + '3rdparty' + pd + 'wx'+ pd + 'things;'
                       + 'include' + pd + '3rdparty' + pd + 'wx'+ pd + 'treemultictrl;'
                       + 'include' + pd + '3rdparty' + pd + 'wx'+ pd + 'sheet;'
                       + 'include' + pd + '3rdparty' + pd + 'wx'+ pd + 'plotctrl;'
                       + 'include' + pd + '3rdparty' + pd + 'wx'+ pd + 'chartart'
                       ;
                       { + 'include' + pd + 'common' + pd+ '3rdparty;'
                       + 'include' + pd + 'common' + pd+ '3rdparty' + pd + 'wx;'      EAB TODO: check these paths.
                       + 'include' + pd + 'common' + pd+ '3rdparty' + pd + 'wx'+ pd + 'things;'
                       + 'include' + pd + 'common' + pd+ '3rdparty' + pd + 'wx'+ pd + 'treemultictrl;'
                       + 'include' + pd + 'common' + pd+ '3rdparty' + pd + 'wx'+ pd + 'sheet;'
                       + 'include' + pd + 'common' + pd+ '3rdparty' + pd + 'wx'+ pd + 'plotctrl;'
                       + 'include' + pd + 'common' + pd+ '3rdparty' + pd + 'wx'+ pd + 'ifm;'
                       + 'include' + pd + 'common' + pd+ '3rdparty' + pd + 'wx'+ pd + 'chartart'
                       ; }

  // file fxtensions 
  LIB_EXT = '.lib';
  OBJ_EXT = '.obj';
  
  //Filters
  
  FLT_WXFORMS = 'wxWidgets Forms (*.wxForm)|*.wxForm';
  FLT_XRC = 'XRC/XML files (*.xml) |*.xml';
  // FLT_RES              = 'Resource scripts (*.rc)|*.rc';   <-- EAB TODO: Not needed here?

  const

  C_EXT                = '.c';
  CPP_EXT              = '.cpp';
  CC_EXT               = '.cc';
  CXX_EXT              = '.cxx';
  CP2_EXT              = '.c++';
  CP_EXT               = '.cp';
  H_EXT                = '.h';
  HPP_EXT              = '.hpp';
  RC_EXT               = '.rc';
  RES_EXT              = '.res';
  RH_EXT               = '.rh';

  //  source file extensions
  APP_SUFFIX = 'App';
  WXFORM_EXT = '.wxform';
  XRC_EXT = '.xml';
    // file type arrays used in getfileex in utils
  resTypes: array[0..3] of string[4] = (RES_EXT, RC_EXT, RH_EXT, XRC_EXT);
  

implementation

end.  