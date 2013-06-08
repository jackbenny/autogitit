#!/bin/bash

################################################################################
#									       #
# Copyright (C) 2013 Jack-Benny Persson <jack-benny@cyberinfo.se>              #
#                                                                              #
# This program is free software; you can redistribute it and/or modify         #
# it under the terms of the GNU General Public License as published by         #
# the Free Software Foundation; either version 2 of the License, or            #
# (at your option) any later version.                                          #
#                                                                              #
# This program is distributed in the hope that it will be useful,              #
# but WITHOUT ANY WARRANTY; without even the implied warranty of               #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the                 #
# GNU General Public License for more details.                                 #
#                                                                              #
# You should have received a copy of the GNU General Public License            #
# along with this program; if not, write to the Free Software                  #
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA      #
#                                                                              #
################################################################################

###############################################################################
#                                                                             #
# autogitit                                                                   #
# A simple shell script to automatically commit a directory to git.           #
# I myself use it as a kind of directory snapshot. I got the idea with        #
# directory snapshots while playing with Solaris 11. I wanted something       #
# similar but more universal without a specific filesystem and something      #
# that used commons tools, and Git was the obvious choice.                    #
#                                                                             #
###############################################################################

VERSION="Version 0.1"
AUTHOR="(c) 2013 Jack-Benny Persson (jack-benny@cyberinfo.se)"

## BEGIN SETTINGS ##

## Set this to the directory to auto commit ##
GITDIR="/home/jackbenny/gittest"

## END SETTINGS ##


## Other variables ##
WHICH="/usr/bin/which"
GIT="`${WHICH} git`"
DATE="`${WHICH} date`"

## Sanity checks ##
if [ ! -x $GIT ]; then
	printf "It seems you don't have git installed.\n"
	printf "Check the GIT variable in autogitit if your sure it's "
	printf "installed.\n"
	exit 1
fi

if [ ! -f $CONFIG ]; then
	printf "Can't find config file at $CONFIG\n"
	exit 1
fi

## Script begins here ##
TIMESTAMP=`${DATE} --rfc-3339=seconds`

## Define some functions ##
init()
{
	test -d $GITDIR/.git
		if [ $? -ne 0 ]; then
			printf "Initlizing $GITDIR\n"
			cd $GITDIR
			git init
			main
			exit 0
		else
			printf "It seems that $GITDIR is already a initalized"
			printf ". Continuing....\n"
			printf "Remove --init from commandline to silence this"
			printf " message\n"
			exit 1
		fi
}

main()
{
	cd $GITDIR

	git status | grep "nothing to commit" > /dev/null
	if [ $? -eq 0 ]; then
		exit 0
	else
		git add -A
		git commit -m "autogitit on $TIMESTAMP" > /dev/null
	fi
}

## Here we go ##
while [[ -n "$1" ]]; do
	case "$1" in

		--init)
		init
		;;
	esac
done

test -d $GITDIR/.git
	if [[ $? -ne 0 ]]; then
		printf "$GITDIR is not initalized as a git dir.\n"
		printf "Use --init to initalize.\n"
	else
main
fi
