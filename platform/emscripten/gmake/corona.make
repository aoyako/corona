# GNU Make project makefile autogenerated by Premake
ifndef config
  config=Debug
endif

ifndef verbose
  SILENT = @
endif

CC = gcc
CXX = g++
AR = ar

ifndef RESCOMP
  ifdef WINDRES
    RESCOMP = $(WINDRES)
  else
    RESCOMP = windres
  endif
endif

ifeq ($(config),Debug)
  OBJDIR     = obj/Debug/corona
  # TARGETDIR  = ../../../Build/gmake/bin/Debug
  TARGETDIR  = obj/Debug
  TARGET     = $(TARGETDIR)/libcorona.a
  TARGET_JS  = $(TARGETDIR)/libcorona.js
  DEFINES   += -DRtt_DEBUG -DLUA_USE_APICHECK -DRtt_EMSCRIPTEN_ENV
  INCLUDES  += -I../../../librtt -I../../../external/lua-5.1.3/src -I..
  ALL_CPPFLAGS  += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS    += $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -g
  ALL_CXXFLAGS  += $(CXXFLAGS) $(ALL_CFLAGS) -fno-exceptions -fno-rtti
  ALL_RESFLAGS  += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  ALL_LDFLAGS   += $(LDFLAGS) -L../../../Build/gmake/bin/Debug
#  LDDEPS    += obj/Debug/libBox2D.a obj/Debug/libRenderer.a obj/Debug/liblfs.a obj/Debug/liblpeg.a obj/Debug/liblua.a obj/Debug/libratatouille.a obj/Debug/librtt.a obj/Debug/libz.a obj/Debug/libjpeg.a obj/Debug/libpng.a
#  LIBS      += $(LDDEPS)
  LINKCMD    = $(AR) -rcs $(TARGET) obj/Debug/libBox2D.a obj/Debug/libRenderer.a obj/Debug/liblfs.a obj/Debug/liblpeg.a obj/Debug/liblua.a obj/Debug/libratatouille.a obj/Debug/librtt.a obj/Debug/libz.a obj/Debug/libjpeg.a obj/Debug/libpng.a
  #LINKCMD    = $(CXX) -g -o $(TARGET) $(RESOURCES) $(ARCH) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  #	$(CXX) -g -o $(TARGET_JS) $(TARGET)
  endef
endif

ifeq ($(config),Release)
  OBJDIR     = obj/Release/corona
  # TARGETDIR  = ../../../Build/gmake/bin/Release
  TARGETDIR  = obj/Release
  TARGET     = $(TARGETDIR)/libcorona.a
  TARGET_JS  = $(TARGETDIR)/libcorona.js
  DEFINES   += -DNDEBUG -DRtt_EMSCRIPTEN_ENV
  INCLUDES  += -I../../../librtt -I../../../external/lua-5.1.3/src -I..
  ALL_CPPFLAGS  += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS    += $(CFLAGS) $(ALL_CPPFLAGS) $(ARCH) -O2
  ALL_CXXFLAGS  += $(CXXFLAGS) $(ALL_CFLAGS) -fno-exceptions -fno-rtti
  ALL_RESFLAGS  += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  ALL_LDFLAGS   += $(LDFLAGS) -L../../../Build/gmake/bin/Release -Wl,-x
#  LDDEPS    += obj/Debug/libBox2D.a obj/Debug/libRenderer.a obj/Debug/liblfs.a obj/Debug/liblpeg.a obj/Debug/liblua.a obj/Debug/libratatouille.a obj/Debug/librtt.a obj/Debug/libz.a obj/Debug/libjpeg.a obj/Debug/libpng.a
#  LIBS      += $(LDDEPS)
  LINKCMD    = $(AR) -rcs $(TARGET) obj/Release/libBox2D.a obj/Release/libRenderer.a obj/Release/liblfs.a obj/Release/liblpeg.a obj/Release/liblua.a obj/Release/libratatouille.a obj/Release/librtt.a obj/Release/libz.a obj/Release/libjpeg.a obj/Release/libpng.a
  #LINKCMD    = $(CXX) -O2 -o $(TARGET) $(RESOURCES) $(ARCH) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  #	$(CXX) -O2 -o $(TARGET_JS) $(TARGET)
  endef
endif

RESOURCES := \

SHELLTYPE := msdos
ifeq (,$(ComSpec)$(COMSPEC))
  SHELLTYPE := posix
endif
ifeq (/bin,$(findstring /bin,$(SHELL)))
  SHELLTYPE := posix
endif

.PHONY: clean prebuild prelink

all: $(TARGETDIR) $(OBJDIR) prebuild prelink $(TARGET)
	@:

$(TARGET): $(GCH) $(LDDEPS) $(RESOURCES)
	@echo Linking corona
	$(SILENT) $(LINKCMD)
	$(POSTBUILDCMDS)

$(TARGETDIR):
	@echo Creating $(TARGETDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(TARGETDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(TARGETDIR))
endif

$(OBJDIR):
	@echo Creating $(OBJDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif

clean:
	@echo Cleaning corona
ifeq (posix,$(SHELLTYPE))
	$(SILENT) rm -f  $(TARGET)
	$(SILENT) rm -rf $(OBJDIR)
else
	$(SILENT) if exist $(subst /,\\,$(TARGET)) del $(subst /,\\,$(TARGET))
	$(SILENT) if exist $(subst /,\\,$(OBJDIR)) rmdir /s /q $(subst /,\\,$(OBJDIR))
endif

prebuild:
	$(PREBUILDCMDS)

prelink:
	$(PRELINKCMDS)

ifneq (,$(PCH))
$(GCH): $(PCH)
	@echo $(notdir $<)
	$(SILENT) $(CXX) -x c++-header $(ALL_CXXFLAGS) -MMD -MP $(DEFINES) $(INCLUDES) -o "$@" -MF "$(@:%.gch=%.d)" -c "$<"
endif

-include $(OBJECTS:%.o=%.d)
ifneq (,$(PCH))
  -include $(OBJDIR)/$(notdir $(PCH)).d
endif