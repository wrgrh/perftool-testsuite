#!/bin/bash

#
#	cleanup.sh of perf archive test
#	Author: Michael Petlan <mpetlan@redhat.com>
#
#

# include working environment
. ../common/init.sh
. ./settings.sh

# clean all the buildid-caches created within this test
touch $CURRENT_TEST_DIR/BUILDIDDIRS
while read line; do
	BUILDIDDIR="$line"
	if [[ " ${BUILDIDDIR}/*" =~ ' /*' ]] || [[ "$BUILDIDDIR" =~ /$ ]]; then
		true # skipping deletion
	else
		rm -rf $BUILDIDDIR/.b*
		rm -rf $BUILDIDDIR/*
		rmdir $BUILDIDDIR 2> /dev/null
	fi
done < $CURRENT_TEST_DIR/BUILDIDDIRS
rm -f $CURRENT_TEST_DIR/BUILDIDDIRS

if [ ! -n "$PERFSUITE_RUN_DIR" ]; then
	find . -name \*.log | xargs -r rm
	find . -name \*.err | xargs -r rm
	find . -name \*.list | xargs -r rm
	rm -f perf.data*
fi

print_overall_results 0
exit $?
