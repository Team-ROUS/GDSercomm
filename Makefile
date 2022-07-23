all: bin/libGDSercomm.dylib

godot_headers: 
	git clone --depth=1 -b 3.x git@github.com:GodotNativeTools/godot_headers.git

sercomm.zip:
	curl -Lo sercomm.zip https://github.com/ingeniamc/sercomm/archive/refs/heads/master.zip

sercomm: sercomm.zip
	unzip sercomm.zip
	mv sercomm-master sercomm

lib/libsercomm.a: godot_headers sercomm
	cd sercomm/ && cmake -H. -Bbuild -DBUILD_SHARED_LIBS=0
	cd sercomm/ && cmake --build build
	mkdir -p lib
	cp sercomm/build/config.h sercomm/include/public/sercomm/
	cp sercomm/build/libsercomm.a lib/

venv:
	python3 -m venv venv
	source venv/bin/activate && pip3 install scons

bin/libGDSercomm.dylib: lib/libsercomm.a venv
	source venv/bin/activate && scons p=osx

clean:
	rm -rf sercomm.zip sercomm
	rm -rf godot_headers lib/libsercomm.a bin/libGDSercomm.dylib
	rm -rf venv
