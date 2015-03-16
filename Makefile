PREFIX=/usr
CC=clang
CXX=clang
CFLAGS=-c -Wall -I/usr/local/include/boost
CXXFLAGS=-c -Wall -I/usr/local/include/boost
LDFLAGS=/usr/local/lib/libboost_system.a -lstdc++ # boost_system-xgcc40-mt-1_36
SOURCES = usbmux.cpp usbmux-proxy.cpp
OBJECTS=$(SOURCES:.cpp=.o)
EXECUTABLE =usbmux-proxy
REMOVE=rm -Rf
STRIP=echo Skip strip...
INSTALL=install

CERTNAME="Developer ID Application: Andy Vandijck (GSF3NR4NQ5)"
CODESIGN=codesign -s $(CERTNAME)

all: $(SOURCES) $(EXECUTABLE)

install: $(EXECUTABLE)
	$(INSTALL) $< $(PREFIX)/bin/$<	

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o "$@"
	$(STRIP) "$@"
	$(CODESIGN) "$@" -f

.cpp.o:
	$(CC) $(CFLAGS) $< -o $@

clean:
	$(REMOVE) *.o "$(EXECUTABLE).unstr" "$(EXECUTABLE)"

