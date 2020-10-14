#**************************************************************************************#
#
# GNUstep makefile to build OSXFUSE/framework for the GNUstep environment
#
# See http://www.gnustep.org/resources/documentation/Developer/Make/Manual/make_toc.html
#    for details about the GNUstep Makefile system
#
#**************************************************************************************#

# Include the common variables defined by the Makefile Package
include $(GNUSTEP_MAKEFILES)/common.make

# Build a tool project.
# Note: There is not much documentation. Read $GNUSTEP_MAKEFILES/Instance/framework.make for information

TOOL_NAME = HelloFS
# CTOOL_NAME =

# Tool preprocessor, compiler and linker flags and include directories
$(TOOL_NAME)_INCLUDE_DIRS	=
$(TOOL_NAME)_CPPFLAGS 		= -D_FILE_OFFSET_BITS=64
$(TOOL_NAME)_CFLAGS 		=
$(TOOL_NAME)_OBJCFLAGS 	=
$(TOOL_NAME)_LDFLAGS		= -lOSXFUSE

# Tool Objective C files
$(TOOL_NAME)_OBJC_FILES 	= main.m \
								HelloFuseFileSystem.m \
								HelloController.m

include $(GNUSTEP_MAKEFILES)/tool.make
#include $(GNUSTEP_MAKEFILES)/ctool.make


