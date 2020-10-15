#**************************************************************************************#
#
# GNUstep makefile to build LoopbackFS for the GNUstep environment
#
# See http://www.gnustep.org/resources/documentation/Developer/Make/Manual/make_toc.html
#    for details about the GNUstep Makefile system
#
#**************************************************************************************#

# Include the common variables defined by the Makefile Package
include $(GNUSTEP_MAKEFILES)/common.make

# Build a tool project.
# Note: There is not much documentation. Read $GNUSTEP_MAKEFILES/Instance/framework.make for information

TOOL_NAME = LoopbackFS
# CTOOL_NAME =

# Tool preprocessor, compiler and linker flags and include directories
$(TOOL_NAME)_INCLUDE_DIRS	= -I../Support
$(TOOL_NAME)_CPPFLAGS 		= -D_FILE_OFFSET_BITS=64
$(TOOL_NAME)_CFLAGS 		=
$(TOOL_NAME)_OBJCFLAGS 	=
$(TOOL_NAME)_LDFLAGS		= -lOSXFUSE

# Tool Objective C files
$(TOOL_NAME)_OBJC_FILES 	= main.m \
								../Support/NSError+POSIX.m \
								LoopbackFS.m \
								LoopbackController.m

include $(GNUSTEP_MAKEFILES)/tool.make
#include $(GNUSTEP_MAKEFILES)/ctool.make


