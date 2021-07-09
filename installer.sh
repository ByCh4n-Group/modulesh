#!/bin/bash

#    modulesh - more than snake, a script management tool for bourne again shell
#    Copyright (C) 2021  lazypwny751
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

# variables
latestthemissource="https://github.com/ByCh4n-Group/themis/archive/refs/tags/1.0.1.tar.gz"
latestthemismakefile="https://raw.githubusercontent.com/ByCh4n-Group/themis/main/Makefile"

version="1.0.0"
maintainer="lazypwny751"
moduletriggers="/usr/local/lib/modulesh"

# Reset
reset='\033[0m'           # Text Reset

# Regular Colors
red='\033[0;31m'          # Red
green='\033[0;32m'        # Green
yellow='\033[0;33m'       # Yellow
blue='\033[0;34m'         # Blue
purple='\033[0;35m'       # Purple
cyan='\033[0;36m'         # Cyan

## text-utils demo
error() {
    echo -e "${red}[-] Error Occured${reset}: ${1}"
    [[ ${2} = "fatal" ]] && exit 1
}

success() {
    echo -e "${green}[+] Successfully${reset}: ${1}"
}

case ${1} in
    [iI][nN][sS][tT][aA][lL][lL]|--[iI][nN][sS][tT][aA][lL][lL]|-[iI])
        ping -q -w1 -c1 google.com &>/dev/null || error "No internet connection" fatal
        [ ${UID} != 0 ] && error "Please run it as root privalages '${blue}sudo bash ${0} --install${reset}'" fatal
        wget ${latestthemissource}
        cd $(tar -xvf $(basename ${latestthemissource}) | tail -n 1 | tr "/" " " | awk '{print $1}') && make install
        cd .. && rm -rf ${OLDPWD}
        rm $(basename ${latestthemissource})
        [ -d ${moduletriggers} ] && rm -rf ${moduletriggers}
        mkdir -p ${moduletriggers} /usr/share/doc/packages/modulesh /usr/share/licenses/modulesh
        chown ${SUDO_USER:-$USER}:$(cat /etc/group | awk -F: '{ print $1}' | grep -w ${SUDO_USER:-$USER} || echo "users") ${moduletriggers}
        cp ./README.md /usr/share/doc/packages/modulesh
        cp ./LICENSE /usr/share/licenses/modulesh
        install -m 755 ./usr/bin/modulesh /usr/bin
        themis --localinstall ./basic-modules/color-1.0.0.tar.gz ./basic-modules/net-utils-1.0.0.tar.gz ./basic-modules/os-utils-1.0.0.tar.gz ./basic-modules/spinners-1.0.0.tar.gz ./basic-modules/text-utils-1.0.0.tar.gz
        success "installed.."
    ;;
    [uU][nN][iI][nN][sS][tT][aA][lL][lL]|--[uU][nN][iI][nN][sS][tT][aA][lL][lL]|-[uU])
        ping -q -w1 -c1 google.com &>/dev/null || error "No internet connection" fatal
        [ ${UID} != 0 ] && error "Please run it as root privalages '${blue}sudo bash ${0} --uninstall${reset}'" fatal
        mkdir ./themis && cd ./themis
        wget ${latestthemismakefile} && make uninstall
        cd .. && rm -rf ./themis
        rm -rf ${moduletriggers} /usr/share/doc/packages/modulesh /usr/share/licenses/modulesh /usr/bin/modulesh
        success "uninstalled.."
    ;;
    [rR][eE][iI][nN][sS][tT][aA][lL][lL]|--[rR][eE][iI][nN][sS][tT][aA][lL][lL]|-[rR])
        ping -q -w1 -c1 google.com &>/dev/null || error "No internet connection" fatal
        [ ${UID} != 0 ] && error "Please run it as root privalages '${blue}sudo bash ${0} --reinstall${reset}'" fatal
        mkdir ./themis && cd ./themis
        wget ${latestthemismakefile} && make uninstall
        cd .. && rm -rf ./themis
        rm -rf ${moduletriggers} /usr/share/doc/packages/modulesh /usr/share/licenses/modulesh /usr/bin/modulesh
        wget ${latestthemissource}
        cd $(tar -xvf $(basename ${latestthemissource}) | tail -n 1 | tr "/" " " | awk '{print $1}') && make install
        cd .. && rm -rf ${OLDPWD}
        rm $(basename ${latestthemissource})
        [ -d ${moduletriggers} ] && rm -rf ${moduletriggers}
        mkdir -p ${moduletriggers} /usr/share/doc/packages/modulesh /usr/share/licenses/modulesh
        chown ${SUDO_USER:-$USER}:$(cat /etc/group | awk -F: '{ print $1}' | grep -w ${SUDO_USER:-$USER} || echo "users") ${moduletriggers}
        cp ./README.md /usr/share/doc/packages/modulesh
        cp ./LICENSE /usr/share/licenses/modulesh
        install -m 755 ./usr/bin/modulesh /usr/bin
        themis --localinstall ./basic-modules/color-1.0.0.tar.gz ./basic-modules/net-utils-1.0.0.tar.gz ./basic-modules/os-utils-1.0.0.tar.gz ./basic-modules/spinners-1.0.0.tar.gz ./basic-modules/text-utils-1.0.0.tar.gz
        success "reinstalled.."
    ;;
    *)
        echo "Unknow option there are three (3) flags: --install, --uninstall, --reinstall"
        exit 1
    ;;
esac