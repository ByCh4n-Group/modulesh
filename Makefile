latestthemissource=https://github.com/ByCh4n-Group/themis/archive/refs/tags/v1.0.0.tar.gz
latestthemismakefile=https://raw.githubusercontent.com/ByCh4n-Group/themis/main/Makefile
basenameofsource=v1.0.0.tar.gz
dirnameofsource=themis-1.0.0

define installthemis
	wget ${latestthemissource}
	tar -xvf ${basenameofsource}
	cd ${dirnameofsource} ; sudo make install
	rm -rf ${dirnameofsource} ${basenameofsource}
endef

define rmthemis
	mkdir themis
	cd themis ; wget ${latestthemismakefile} ; sudo make uninstall
	rm -rf themis
endef

install:
	$(installthemis)
	mkdir -p /usr/local/lib/modulesh /usr/share/doc/packages/modulesh /usr/share/licenses/modulesh
	chown ${SUDO_USER:-${USER}}:${SUDO_USER:-${USER}} /usr/local/lib/modulesh || chown chown ${SUDO_USER:-${USER}}:users /usr/local/lib/modulesh 
	cp ./README.md /usr/share/doc/packages/modulesh
	cp ./LICENSE /usr/share/licenses/modulesh
	install -m 755 ./usr/bin/modulesh /usr/bin

uninstall:
	$(rmthemis)
	rm -rf /usr/local/lib/modulesh /usr/share/doc/packages/modulesh /usr/share/licenses/modulesh /usr/bin/modulesh

reinstall:
	$(getusername)
	$(rmthemis)
	rm -rf /usr/local/lib/modulesh /usr/share/doc/packages/modulesh /usr/share/licenses/modulesh /usr/bin/modulesh
	$(installthemis)
	mkdir -p /usr/local/lib/modulesh /usr/share/doc/packages/modulesh /usr/share/licenses/modulesh
	chown $(shell bash ./user.sh):$(shell bash ./user.sh) /usr/local/lib/modulesh || chown $(shell bash ./user.sh):users /usr/local/lib/modulesh
	cp ./README.md /usr/share/doc/packages/modulesh
	cp ./LICENSE /usr/share/licenses/modulesh
	install -m 755 ./usr/bin/modulesh /usr/bin
