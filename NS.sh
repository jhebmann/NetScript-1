NETSURF_VERSION="3.6dev"
NETSCRIPT_DATE="20160814-1" 

if [ ! \( "$1" = "-q" -o "$1" = "--quick" \) ]
then
	echo "                                               "
	echo "-----------------------------------------------"
	echo "         NetScript for Netsurf $NETSURF_VERSION"
	echo "Crossed Compilation Cygwin (Windows) - AmigaOS3"
	echo "                                               "
	echo "       Created by DNADNL, EyMenZ & Tygre       "
	echo "                                               "
	echo "               A big thanks to :               "
	echo "          Chris Young, transcode-open          "
	echo "           and the amiga.org forums !          "
	echo "                                               "
	echo "     *** Script Version : $NETSCRIPT_DATE ***  "
	echo "-----------------------------------------------"
	echo "                                               "

	while [ \( "$compileWithDukTape" != "Y" -a "$compileWithDukTape" != "N" \) -a \( "$compileWithDukTape" != "y" -a "$compileWithDukTape" != "n" \) ]
		do read -p "(1/4) Do you want to compile NetSurf WITH DukTape ?(Y/n) : " compileWithDukTape
	done

	while [ \( "$keepFiles" != "Y" -a "$keepFiles" != "N" \) -a \( "$keepFiles" != "y" -a "$keepFiles" != "n" \) ]
		do read -p "(2/4) Do you need to KEEP the files and libraries used for the compilation AFTER the NetScript execution (to dig in the code) ? (Y/n) : " keepFiles
	done

	while [ \( "$keepOptNetSurf" != "Y" -a "$keepOptNetSurf" != "N" \) -a \( "$keepOptNetSurf" != "y" -a "$keepOptNetSurf" != "n" \) ]
		do read -p "(3/4) Do you want to KEEP the /opt/netsurf folder at the end of NetScript execution ? If you keep it, the future NetScript executions will be shorter. (Y/n) : " keepOptNetSurf
	done

	while [ \( "$cleanWorkspace" != "Y" -a "$cleanWorkspace" != "N" \) -a \( "$cleanWorkspace" != "y" -a "$cleanWorkspace" != "n" \) ]
		do read -p "(4/4) Do you want to CLEAN your Workspace folder $(PWD) (that means deleting the old files and libraries) BEFORE the NetScript execution ? If you clean it, NetScript will delete the actual files and libraries and download the fresh ones, so you will lose your modifications (if you did some). (Y/n) : " cleanWorkspace
	done

	if [ "$compileWithDukTape" = "Y" -o "$compileWithDukTape" = "y" ]
		then 
			echo "                                               "
			echo "-----------------------------------------------"
			echo "   You chose to compile NetSurf WITH DukTape   "
			echo "-----------------------------------------------"
			echo "                                               "
			NETSURF_DUKTAPE="WithDukTape"
		else
			echo "                                               "
			echo "-----------------------------------------------"
			echo " You chose to compile NetSurf WITHOUT DukTape  "
			echo "-----------------------------------------------"
			echo "                                               "
			NETSURF_DUKTAPE="NoDukTape"
	fi

	NETSURF_ARCHIVE_NAME="NetSurf_$NETSURF_VERSION""_$NETSURF_DUKTAPE""_AmigaOS3.tar"
	
	if [ "$keepFiles" = "Y" -o "$keepFiles" = "y" ]
		then 
			echo "                                               "
			echo "-----------------------------------------------"
			echo "       You chose to KEEP the files after       "
			echo "            the NetScript Execution            "
			echo "-----------------------------------------------"
			echo "                                               "
		else
			echo "                                               "
			echo "-----------------------------------------------"
			echo "      You chose to DELETE the files after      "
			echo "            the NetScript Execution            "
			echo "-----------------------------------------------"
			echo "                                               "
	fi

	if [ "$keepOptNetSurf" = "Y" -o "$keepOptNetSurf" = "y" ]
		then 
			echo "                                               "
			echo "-----------------------------------------------"
			echo "   You chose to KEEP the /opt/netsurf folder   "
			echo "       at the end of NetScript execution       "
			echo "    for future shorter NetScript executions    "
			echo "-----------------------------------------------"
			echo "                                               "
		else
			echo "                                               "
			echo "-----------------------------------------------"
			echo "  You chose to DELETE the /opt/netsurf folder  "
			echo "       at the end of NetScript execution       "
			echo " (future NetScript executions will be longer)  "
			echo "-----------------------------------------------"
			echo "                                               "
	fi

	if [ "$cleanWorkspace" = "Y" -o "$cleanWorkspace" = "y" ]
		then 
			echo "                                               "
			echo "-----------------------------------------------"
			echo "       You chose to CLEAN your Workspace       "
			echo "        BEFORE the NetScript execution         "
			echo "      to compile a fresh NetSurf version       "
			echo " (your previous modifications will be deleted) "
			echo "-----------------------------------------------"
			echo "                                               "
			
			echo "                                             "
			echo "_/>_/>_/>_/>_/>_/>_/>_/>_/>_/>_/>_/>_/>_/>_/>"
			echo "                  Cleaning                   "
			echo "_/>_/>_/>_/>_/>_/>_/>_/>_/>_/>_/>_/>_/>_/>_/>"
			echo "                                             "

			echo "Deleting old NetScript files..."

			rm -Rf buildsystem libcss libdom libhubbub libnsbmp libnsgif libnsutils libparserutils libsvgtiny libutf8proc libwapcaplet nsgenbind toolchains NetSurf_*_AmigaOS3.tar
			rm -Rf netsurf/*
			rm -Rf netsurf

			echo "Old NetScript files deleted !"
			
		else
			echo "                                               "
			echo "-----------------------------------------------"
			echo "   You chose to KEEP your Workspace as it is   "
			echo "        BEFORE the NetScript execution         "
			echo "      to compile a custom NetSurf version      "
			echo "         containing your modifications         "
			echo "  (your previous modifications will be saved)  "
			echo "-----------------------------------------------"
			echo "                                               "
			rm -Rf NetSurf_*_AmigaOS3.tar
	fi



	echo "                                              "
	echo "<><><><><><><><><><><><><><><><><><><><><><><>"
	echo "                 Cygwin Tools                 "
	echo "<><><><><><><><><><><><><><><><><><><><><><><>"
	echo "                                              "

	echo "Installing Cygwin tools..."

	lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
	install apt-cyg /bin
	apt-cyg install wget git make patch pkg-config apache2 python subversion gperf flex bison autoconf gcc-g++ gcc-tools-epoch2-automake libidn-devel kde-dev-scripts
	rm apt-cyg

	echo "Cygwin tools installed !"

	echo "                                               "
	echo "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+"
	echo "                  Toolchains                   "
	echo "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+"
	echo "                                               "

	echo "Verifying /opt/netsurf folder... "
	if [ ! -d "/opt/netsurf" ]
	then
		echo "/opt/netsurf folder doesn't exist."
		echo "NetScript is now going to download and compile the toolchains needed to create /opt/netsurf (the NetScript execution will be longer). "
		git clone git://git.netsurf-browser.org/toolchains.git
		./updateFiles.sh toolchains &
		cd toolchains/m68k-unknown-amigaos
		unlink /usr/bin/autom4te2.64
		ln -s /opt/gcc-tools/epoch2/bin/autom4te-2.64 /usr/bin/autom4te2.64
		make distclean
		make
		cd ../sdk
		make GCCSDK_INSTALL_CROSSBIN=/opt/netsurf/m68k-unknown-amigaos/cross/bin GCCSDK_INSTALL_ENV=/opt/netsurf/m68k-unknown-amigaos/env distclean
		make GCCSDK_INSTALL_CROSSBIN=/opt/netsurf/m68k-unknown-amigaos/cross/bin GCCSDK_INSTALL_ENV=/opt/netsurf/m68k-unknown-amigaos/env
		cd ../..

		mkdir -p /opt/netsurf/m68k/unknown/amigaos/cross/bin/m68k/unknown/amigaos
		cp /opt/netsurf/m68k-unknown-amigaos/cross/m68k-unknown-amigaos/bin/* /opt/netsurf/m68k/unknown/amigaos/cross/bin/m68k/unknown/amigaos

		cp /opt/netsurf/m68k/unknown/amigaos/cross/bin/m68k/unknown/amigaos/ar.exe /opt/netsurf/m68k/unknown/amigaos/cross/bin/m68k/unknown/amigaos/-ar.exe
		rm /opt/netsurf/m68k/unknown/amigaos/cross/bin/m68k/unknown/amigaos/ar.exe
	else
		echo "/opt/netsurf folder already exists."
		echo "NetScript doesn't need to download and compile the toolchains (the NetScript execution will be shorter). "
	fi

		export PATH=/opt/netsurf/m68k-unknown-amigaos/cross/bin:$PATH
		export PKG_CONFIG_PATH=/opt/netsurf/m68k-unknown-amigaos/env/lib/pkgconfig:$PKG_CONFIG_PATH

	echo "                                               "
	echo "$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$"
	echo "                 Build System                  "
	echo "$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$;$"
	echo "                                               "

	echo "Verifying buildsystem folder... "
	if [ ! -d "buildsystem" ]
	then
		echo "buildsystem folder doesn't exist. Downloading the fresh one..."
		git clone git://git.netsurf-browser.org/buildsystem.git
		cd buildsystem
		git pull
		make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos clean
	else
		echo "buildsystem folder already exists. Compiling with your modifications (if you did some)..."
		cd buildsystem
	fi

	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos
	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos install
	cd ..

	echo "                                               "
	echo "/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/"
	echo "                   Libnsgif                    "
	echo "/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/"
	echo "                                               "

	echo "Verifying libnsgif folder... "
	if [ ! -d "libnsgif" ]
	then
		echo "libnsgif folder doesn't exist. Downloading the fresh one..."
		git clone git://git.netsurf-browser.org/libnsgif.git
		cd libnsgif
		git pull
		make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos clean
	else
		echo "libnsgif folder already exists. Compiling with your modifications (if you did some)..."
		cd libnsgif
	fi

	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos
	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos install
	cd ..

	echo "                                               "
	echo "^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^"
	echo "                   Libnsbmp                    "
	echo "^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^"
	echo "                                               "

	echo "Verifying libnsbmp folder... "
	if [ ! -d "libnsbmp" ]
	then
		echo "libnsbmp folder doesn't exist. Downloading the fresh one..."
		git clone git://git.netsurf-browser.org/libnsbmp.git
		cd libnsbmp
		git pull
		make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos clean
	else
		echo "libnsbmp folder already exists. Compiling with your modifications (if you did some)..."
		cd libnsbmp
	fi

	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos
	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos install
	cd ..

	echo "                                               "
	echo "%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%"
	echo "                  Libwapcaplet                 "
	echo "%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%|%"
	echo "                                               "

	echo "Verifying libwapcaplet folder... "
	if [ ! -d "libwapcaplet" ]
	then
		echo "libwapcaplet folder doesn't exist. Downloading the fresh one..."
		git clone git://git.netsurf-browser.org/libwapcaplet.git
		cd libwapcaplet
		git pull
		make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos clean
	else
		echo "libwapcaplet folder already exists. Compiling with your modifications (if you did some)..."
		cd libwapcaplet
	fi

	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos
	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos install
	cd ..

	echo "                                               "
	echo "?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?"
	echo "                 Libparserutils                "
	echo "?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?!?"
	echo "                                               "

	echo "Verifying libparserutils folder... "
	if [ ! -d "libparserutils" ]
	then
		echo "libparserutils folder doesn't exist. Downloading the fresh one..."
		git clone git://git.netsurf-browser.org/libparserutils.git
		cd libparserutils
		git pull
		make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos clean
	else
		echo "libparserutils folder already exists. Compiling with your modifications (if you did some)..."
		cd libparserutils
	fi

	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos
	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos install
	cd ..

	echo "                                               "
	echo "OoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoO"
	echo "                   Libhubbub                   "
	echo "OoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoOoO"
	echo "                                               "

	echo "Verifying libhubbub folder... "
	if [ ! -d "libhubbub" ]
	then
		echo "libhubbub folder doesn't exist. Downloading the fresh one..."
		git clone git://git.netsurf-browser.org/libhubbub.git
		cd libhubbub
		git pull
		rm -Rf examples
		rm -Rf perf
		make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos clean
	else
		echo "libhubbub folder already exists. Compiling with your modifications (if you did some)..."
		cd libhubbub
	fi

	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos
	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos install
	cd ..

	echo "                                               "
	echo "#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#"
	echo "                    Libdom                     "
	echo "#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#"
	echo "                                               "

	echo "Verifying libdom folder... "
	if [ ! -d "libdom" ]
	then
		echo "libdom folder doesn't exist. Downloading the fresh one..."
		git clone git://git.netsurf-browser.org/libdom.git
		cd libdom
		git pull
		rm -Rf examples
		make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos clean
	else
		echo "libdom folder already exists. Compiling with your modifications (if you did some)..."
		cd libdom
	fi

	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos
	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos install
	cd ..

	echo "                                               "
	echo "*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
	echo "                    Libcss                     "
	echo "*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
	echo "                                               "

	echo "Verifying libcss folder... "
	if [ ! -d "libcss" ]
	then
		echo "libcss folder doesn't exist. Downloading the fresh one..."
		git clone git://git.netsurf-browser.org/libcss.git
		cd libcss
		git pull
		make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos clean
	else
		echo "libcss folder already exists. Compiling with your modifications (if you did some)..."
		cd libcss
	fi

	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos
	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos install
	cd ..

	echo "                                               "
	echo "_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_"
	echo "                   Libsvgtiny                  "
	echo "_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_&_"
	echo "                                               "

	echo "Verifying libsvgtiny folder... "
	if [ ! -d "libsvgtiny" ]
	then
		echo "libsvgtiny folder doesn't exist. Downloading the fresh one..."
		git clone git://git.netsurf-browser.org/libsvgtiny.git
		cd libsvgtiny
		git pull
		make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos clean
	else
		echo "libsvgtiny folder already exists. Compiling with your modifications (if you did some)..."
		cd libsvgtiny
	fi

	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos
	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos install
	cd ..

	echo "                                               "
	echo "@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@"
	echo "                  Libnsutils                   "
	echo "@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@¨@"
	echo "                                               "

	echo "Verifying libnsutils folder... "
	if [ ! -d "libnsutils" ]
	then
		echo "libnsutils folder doesn't exist. Downloading the fresh one..."
		git clone git://git.netsurf-browser.org/libnsutils.git
		cd libnsutils
		git pull
		make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos clean
	else
		echo "libnsutils folder already exists. Compiling with your modifications (if you did some)..."
		cd libnsutils
	fi

	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos
	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos install
	cd ..

	echo "                                               "
	echo "=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*="
	echo "                  Libutf8proc                  "
	echo "=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*="
	echo "                                               "

	echo "Verifying libutf8proc folder... "
	if [ ! -d "libutf8proc" ]
	then
		echo "libutf8proc folder doesn't exist. Downloading the fresh one..."
		git clone git://git.netsurf-browser.org/libutf8proc.git
		cd libutf8proc
		git pull
		make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos clean
	else
		echo "libutf8proc folder already exists. Compiling with your modifications (if you did some)..."
		cd libutf8proc
	fi

	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos
	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env HOST=m68k-unknown-amigaos install
	cd ..

	echo "                                               "
	echo "{=}~{=}~{=}~{=}~{=}~{=}~{=}~{=}~{=}~{=}~{=}~{=}"
	echo "                   Nsgenbind                   "
	echo "{=}~{=}~{=}~{=}~{=}~{=}~{=}~{=}~{=}~{=}~{=}~{=}"
	echo "                                               "

	echo "Verifying nsgenbind folder... "
	if [ ! -d "nsgenbind" ]
	then
		echo "nsgenbind folder doesn't exist. Downloading the fresh one..."
		git clone git://git.netsurf-browser.org/nsgenbind.git
		cd nsgenbind
		git pull
		make PREFIX=/opt/netsurf/m68k-unknown-amigaos/env clean
	else
		echo "nsgenbind folder already exists. Compiling with your modifications (if you did some)..."
		cd nsgenbind
	fi

	make PREFIX=/opt/netsurf/m68k-unknown-amigaos/env
	make PREFIX=/opt/netsurf/m68k-unknown-amigaos/env install
	cd ..

	unlink /usr/bin/nsgenbind
	ln -s $(PWD)/nsgenbind/build-i686-pc-cygwin-i686-pc-cygwin-release-binary/nsgenbind /usr/bin/nsgenbind

	echo "                                               "
	echo "~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~"
	echo "                    NetSurf                    "
	echo "~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~"
	echo "                                               "

	echo "Verifying netsurf folder... "
	if [ ! -d "netsurf" ]
	then
		echo "netsurf folder doesn't exist. Downloading the fresh one..."
		git clone git://git.netsurf-browser.org/netsurf.git
		./updateFiles.sh amiga &
		cd netsurf
		git pull
		make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env CC=m68k-unknown-amigaos-gcc clean
	else
		echo "netsurf folder already exists. Compiling with your modifications (if you did some)..."
		cd netsurf
	fi

	if [ "$compileWithDukTape" = "Y" -o "$compileWithDukTape" = "y" ]
		then 
			echo "                                               "
			echo "-----------------------------------------------"
			echo "                   REMINDER                    "
			echo "   You chose to compile NetSurf WITH DukTape   "
			echo "-----------------------------------------------"
			echo "                                               "
			echo override NETSURF_USE_DUKTAPE := YES >> Makefile.config.example
			cp Makefile.config.example Makefile.config
		else
			echo "                                               "
			echo "-----------------------------------------------"
			echo "                    REMINDER                   "
			echo "  You chose to compile NetSurf WITHOUT DukTape "
			echo "-----------------------------------------------"
			echo "                                               "
			echo override NETSURF_USE_DUKTAPE := NO >> Makefile.config.example
			cp Makefile.config.example Makefile.config
	fi

	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env CC=m68k-unknown-amigaos-gcc package
	mv NetSurf_Amiga/netsurf.tar ../$NETSURF_ARCHIVE_NAME
	cd ..

	if [ "$keepFiles" = "Y" -o "$keepFiles" = "y" ]
		then 
			echo "                                               "
			echo "-----------------------------------------------"
			echo "                    REMINDER                   "
			echo "       You chose to KEEP the files after       "
			echo "            the NetScript Execution            "
			echo "-----------------------------------------------"
			echo "                                               "
		else
			echo "                                               "
			echo "-----------------------------------------------"
			echo "                    REMINDER                   "
			echo "      You chose to DELETE the files after      "
			echo "            the NetScript Execution            "
			echo "-----------------------------------------------"
			echo "                                               "
			rm -Rf buildsystem libcss libdom libhubbub libnsbmp libnsgif libnsutils libparserutils libsvgtiny libutf8proc libwapcaplet nsgenbind toolchains
			rm -Rf netsurf/*
			rm -Rf netsurf
	fi

	if [ "$keepOptNetSurf" = "Y" -o "$keepOptNetSurf" = "y" ]
		then 
			echo "                                               "
			echo "-----------------------------------------------"
			echo "                   REMINDER                    "
			echo "   You chose to KEEP the /opt/netsurf folder   "
			echo "       at the end of NetScript execution       "
			echo "    for future shorter NetScript executions    "
			echo "-----------------------------------------------"
			echo "                                               "
		else
			echo "                                               "
			echo "-----------------------------------------------"
			echo "                   REMINDER                    "
			echo "  You chose to DELETE the /opt/netsurf folder  "
			echo "       at the end of NetScript execution       "
			echo " (future NetScript executions will be longer)  "
			echo "-----------------------------------------------"
			echo "                                               "
			rm -Rf /opt/netsurf
	fi

	if [ -f "$NETSURF_ARCHIVE_NAME" ]
		then
			echo "                                               "
			echo "-----------------------------------------------"
			echo "                  GOOD ENDING                  "
			echo "     Your NetSurf Archive is available in :    "
			echo "     $(PWD)"
			echo "                And is called :                "
			echo "     $NETSURF_ARCHIVE_NAME"
			echo "                                               "
			echo "     Unpack it into a folder reachable by      "
			echo "      your AmigaOS3 and then install it.       "
			echo "(LHA Archive Format is not supported by Cygwin,"
			echo "         sorry for the inconvenience)          "
			echo "                                               "
			echo "         Thanks for using NetScript !          "
			echo "             Spread the world ! ^^             "
			echo "-----------------------------------------------"
			echo "                                               "
		else
			echo "                                               "
			echo "-----------------------------------------------"
			echo "                  BAD ENDING                   "
			echo "    The NetSurf Archive hasn't been created.   "
			echo "       That means an issue has been done       "
			echo "          during the compilation. :-(          "
			echo "                                               "
			echo "      Please try to launch NetScript again     "
			echo "    in order to compile the toolchains again   "
			echo "      by deleting the /opt/netsurf folder      "
			echo "      and cleaning your Workspace folder       "
			echo "         (this could solve the issue).         " 
			echo "                                               "
			echo "You can also send to DNADNL the log file called"
			echo "               LOG_NetScript.txt               "
			echo "and located in $(PWD)"
			echo "           via the Amiga.org forums.           "
			echo "    DNADNL will do his best to answer you.     "
			echo "                                               "
			echo "         Sorry for the inconvenience !         "
			echo "-----------------------------------------------"
			echo "                                               "

			while [ \( "$deleteOptNetSurf" != "Y" -a "$deleteOptNetSurf" != "N" \) -a \( "$deleteOptNetSurf" != "y" -a "$deleteOptNetSurf" != "n" \) ]
				do read -p "(1/2) Do you want to DELETE the /opt/netsurf folder now in order to recompile it (this could solve the issue encountered) ? This question is asked even if you already deleted it, in that case, NetScript can't make the folder reappear. (Y/n) : " deleteOptNetSurf
			done
			
			while [ \( "$deleteFiles" != "Y" -a "$deleteFiles" != "N" \) -a \( "$deleteFiles" != "y" -a "$deleteFiles" != "n" \) ]
				do read -p "(2/2) Do you want to DELETE the files and libraries used for the compilation ? This question is asked even if you already deleted them, in that case, NetScript can't make the files and libraries reappear. (Y/n) : " deleteFiles
			done

			if [ "$deleteOptNetSurf" = "Y" -o "$deleteOptNetSurf" = "y" ]
				then 
					echo "                                               "
					echo "-----------------------------------------------"
					echo "  You chose to DELETE the /opt/netsurf folder  "
					echo "-----------------------------------------------"
					echo "                                               "
					rm -Rf /opt/netsurf
					echo "                                               "
					echo "-----------------------------------------------"
					echo "         /opt/netsurf folder deleted !         "
					echo "-----------------------------------------------"
					echo "                                               "
				else
					echo "                                               "
					echo "-----------------------------------------------"
					echo "   You chose to KEEP the /opt/netsurf folder   "
					echo "-----------------------------------------------"
					echo "                                               "
			fi
			
			if [ "$deleteFiles" = "Y" -o "$deleteFiles" = "y" ]
				then 
					echo "                                               "
					echo "-----------------------------------------------"
					echo "  You chose to DELETE the files and libraries  "
					echo "-----------------------------------------------"
					echo "                                               "
					rm -Rf buildsystem libcss libdom libhubbub libnsbmp libnsgif libnsutils libparserutils libsvgtiny libutf8proc libwapcaplet nsgenbind toolchains
					rm -Rf netsurf/*
					rm -Rf netsurf
					echo "                                               "
					echo "-----------------------------------------------"
					echo "         Files and libraries deleted !         "
					echo "-----------------------------------------------"
					echo "                                               "
				else
					echo "                                               "
					echo "-----------------------------------------------"
					echo "   You chose to KEEP the files and libraries   "
					echo "-----------------------------------------------"
					echo "                                               "
			fi

			echo "                                               "
			echo "-----------------------------------------------"
			echo "        Now, you can relaunch NetScript        "
			echo "    by using the \"./NetScript.sh\" command    "
			echo "     (sorry again for the inconvenience !)     "
			echo "                                               "
			echo "         Thanks for using NetScript !          "
			echo "             Spread the world ! ^^             "
			echo "-----------------------------------------------"
			echo "                                               "
	fi
	
	
else

	echo "                                               "
	echo "-----------------------------------------------"
	echo "         NetScript for Netsurf $NETSURF_VERSION"
	echo "Crossed Compilation Cygwin (Windows) - AmigaOS3"
	echo "                                               "
	echo "       Created by DNADNL, EyMenZ & Tygre       "
	echo "                                               "
	echo "               A big thanks to :               "
	echo "          Chris Young, transcode-open          "
	echo "           and the amiga.org forums !          "
	echo "                                               "
	echo "     *** Script Version : $NETSCRIPT_DATE ***  "
	echo "-----------------------------------------------"
	echo "                                               "
	
	echo "                                               "
	echo "-----------------------------------------------"
	echo "             ~~~~ QUICK MODE ~~~~              "
	echo "     This version only recompiles NetSurf      "
	echo "     You need to launch NetScript normally     "
	echo "    at least once to use this quick version    "
	echo "-----------------------------------------------"
	echo "                                               "

	while [ \( "$compileWithDukTape" != "Y" -a "$compileWithDukTape" != "N" \) -a \( "$compileWithDukTape" != "y" -a "$compileWithDukTape" != "n" \) ]
		do read -p "(1/1) Do you want to compile NetSurf WITH DukTape ?(Y/n) : " compileWithDukTape
	done

	if [ "$compileWithDukTape" = "Y" -o "$compileWithDukTape" = "y" ]
		then 
			echo "                                               "
			echo "-----------------------------------------------"
			echo "   You chose to compile NetSurf WITH DukTape   "
			echo "-----------------------------------------------"
			echo "                                               "
			NETSURF_DUKTAPE="WithDukTape"
		else
			echo "                                               "
			echo "-----------------------------------------------"
			echo " You chose to compile NetSurf WITHOUT DukTape  "
			echo "-----------------------------------------------"
			echo "                                               "
			NETSURF_DUKTAPE="NoDukTape"
	fi
	
	NETSURF_ARCHIVE_NAME="NetSurf_$NETSURF_VERSION""_$NETSURF_DUKTAPE""_AmigaOS3.tar"

	rm -Rf NetSurf_*_AmigaOS3.tar

	export PATH=/opt/netsurf/m68k-unknown-amigaos/cross/bin:$PATH
	export PKG_CONFIG_PATH=/opt/netsurf/m68k-unknown-amigaos/env/lib/pkgconfig:$PKG_CONFIG_PATH

	unlink /usr/bin/nsgenbind
	ln -s $(PWD)/nsgenbind/build-i686-pc-cygwin-i686-pc-cygwin-release-binary/nsgenbind /usr/bin/nsgenbind

	echo "                                               "
	echo "~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~"
	echo "                    NetSurf                    "
	echo "~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~'~.~"
	echo "                                               "

	cd netsurf
	
	if [ "$compileWithDukTape" = "Y" -o "$compileWithDukTape" = "y" ]
		then 
			echo "                                               "
			echo "-----------------------------------------------"
			echo "                   REMINDER                    "
			echo "   You chose to compile NetSurf WITH DukTape   "
			echo "-----------------------------------------------"
			echo "                                               "
			echo override NETSURF_USE_DUKTAPE := YES >> Makefile.config.example
			cp Makefile.config.example Makefile.config
		else
			echo "                                               "
			echo "-----------------------------------------------"
			echo "                    REMINDER                   "
			echo "  You chose to compile NetSurf WITHOUT DukTape "
			echo "-----------------------------------------------"
			echo "                                               "
			echo override NETSURF_USE_DUKTAPE := NO >> Makefile.config.example
			cp Makefile.config.example Makefile.config
	fi

	make TARGET=amigaos3 PREFIX=/opt/netsurf/m68k-unknown-amigaos/env CC=m68k-unknown-amigaos-gcc package
	mv NetSurf_Amiga/netsurf.tar ../$NETSURF_ARCHIVE_NAME
	cd ..

	if [ -f "$NETSURF_ARCHIVE_NAME" ]
		then
			echo "                                               "
			echo "-----------------------------------------------"
			echo "                  GOOD ENDING                  "
			echo "     Your NetSurf Archive is available in :    "
			echo "     $(PWD)"
			echo "                And is called :                "
			echo "     $NETSURF_ARCHIVE_NAME"
			echo "                                               "
			echo "     Unpack it into a folder reachable by      "
			echo "      your AmigaOS3 and then install it.       "
			echo "(LHA Archive Format is not supported by Cygwin,"
			echo "         sorry for the inconvenience)          "
			echo "                                               "
			echo "         Thanks for using NetScript !          "
			echo "             Spread the world ! ^^             "
			echo "-----------------------------------------------"
			echo "                                               "
		else
			echo "                                               "
			echo "-----------------------------------------------"
			echo "                  BAD ENDING                   "
			echo "    The NetSurf Archive hasn't been created.   "
			echo "       That means an issue has been done       "
			echo "          during the compilation. :-(          "
			echo "                                               "
			echo "      Please try to launch NetScript again     "
			echo "    by using the \"./NetScript.sh\" command    "
			echo "    in order to compile the toolchains again   "
			echo "      by deleting the /opt/netsurf folder      "
			echo "      and cleaning your Workspace folder       "
			echo "         (this could solve the issue).         " 
			echo "                                               "
			echo "You can also send to DNADNL the log file called"
			echo "               LOG_NetScript.txt               "
			echo "and located in $(PWD)"
			echo "           via the Amiga.org forums.           "
			echo "    DNADNL will do his best to answer you.     "
			echo "                                               "
			echo "         Sorry for the inconvenience !         "
			echo "                                               "
			echo "         Thanks for using NetScript !          "
			echo "             Spread the world ! ^^             "
			echo "-----------------------------------------------"
			echo "                                               "
	fi						
fi
