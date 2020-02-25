
all: test

gen:src/gen/sensors-libsensors-sensors_sensors_h.ads

src/gen/sensors-libsensors-sensors_sensors_h.ads:/usr/include/sensors/sensors.h
	rm -rf .gen src/gen ; mkdir -p .gen src/gen
	echo "#include <sensors/error.h>" >.gen/gen.cc
	echo "#include <sensors/sensors.h>" >>.gen/gen.cc
	cd .gen; gcc -C -c gen.cc  -fdump-ada-spec -fada-spec-parent=Sensors.libSensors
	cp .gen/*sensors_error_h.ads src/gen
	cp .gen/*sensors_sensors_h.ads src/gen
	sed -f all.sed -i src/gen/*.ads
	gprbuild -p -P sensors.gpr

prereqisits:
	if [ -e /etc/debian_version ] ; then\
		sudo apt-get install -y libsensors4-dev lm-sensors ;\
	fi

test:
	${MAKE} -C tests all

clean:
	git clean -xdf
