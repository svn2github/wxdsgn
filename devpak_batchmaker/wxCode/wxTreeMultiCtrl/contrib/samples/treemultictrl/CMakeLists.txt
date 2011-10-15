##---------------------------------------------------------------------------
## $RCSfile: CMakeLists.txt,v $
## $Source: /cvsroot-fuse/wxcode/wxCode/components/treemultictrl/contrib/samples/treemultictrl/CMakeLists.txt,v $
## $Revision: 1.3 $
## $Date: 2005/08/16 19:32:04 $
##---------------------------------------------------------------------------
## Author:      Jorgen Bodde
## Copyright:   (c) Jorgen Bodde
## License:     wxWidgets License
##---------------------------------------------------------------------------

SET(SAMPLE_SRCS MultiCtrlTest.cpp)

IF(WIN32)
    SET(SAMPLE_SRCS ${SAMPLE_SRCS} MultiCtrlTest.rc)
ENDIF(WIN32)

ADD_EXECUTABLE(multictrltest WIN32 ${SAMPLE_SRCS})

IF(LINUX)
  ADD_DEFINITIONS( -DLINUX=1 )
ENDIF(LINUX)

# if the checkbox view functionality is not desired,
# exclude this part from the sample

IF(USE_CHECKBOXVIEW)
  ADD_DEFINITIONS( -DCHECKBOXVIEW=1 )
ELSE(USE_CHECKBOXVIEW)
  ADD_DEFINITIONS( -DCHECKBOXVIEW=0)
ENDIF(USE_CHECKBOXVIEW)

LINK_DIRECTORIES(${TREEMULTICTRL_BINARY_DIR}/contrib/lib ${LINK_DIRECTORIES} )

TARGET_LINK_LIBRARIES(multictrltest treemultictrl ${WXWIDGETS_LIBRARIES} )