#!/bin/bash -e

# Setups alternatives for GCC.
#
# Usage:
#
#     sudo ./setup-gcc-alternatives.sh
#
# To change the version, use the following commands:
#
#     sudo ./switch-version.sh 11
#
# To check the version:
#
#     g++ --version

VERSIONS=(4.8 5 6 7 8 9 10 11)

update-alternatives --remove-all gcc 2> /dev/null || echo > /dev/null
update-alternatives --remove-all g++ 2> /dev/null || echo > /dev/null
update-alternatives --remove-all cpp 2> /dev/null || echo > /dev/null

install_alternative () {
    local VERSION=$1
    local PRIORITY=$2
    
    if [ ! -f "/usr/bin/gcc-$1" ] ||
       [ ! -f "/usr/bin/g++-$1" ] ||
       [ ! -f "/usr/bin/cpp-$1" ]; then
        return
    fi
    
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-$VERSION $PRIORITY
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-$VERSION $PRIORITY
    update-alternatives --install /usr/bin/cpp cpp /usr/bin/cpp-$VERSION $PRIORITY
}

PRIORITY=10
for VERSION in ${VERSIONS[*]}
do
    install_alternative $VERSION $PRIORITY
    PRIORITY=$(expr $PRIORITY + 10)
done

exit

update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30
update-alternatives --set cc /usr/bin/gcc

update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30
update-alternatives --set c++ /usr/bin/g++

