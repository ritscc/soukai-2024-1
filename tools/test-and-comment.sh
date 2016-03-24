#!/bin/bash
t=`mktemp`
OPTION=--log-level=3 make test > $t
status=$?
cat $t
ruby tools/comment-pullreq.rb $t
rm $t
exit $status
