#!/bin/sh

test -e files && echo "---building files.tar---" 
echo ""
cd files && tar cvf ../files.tar * && cd ..
echo ""
test -e templates && echo "---building templates.tar---"
echo ""
cd templates && tar cvf ../templates.tar * && cd ..
echo ""
echo "---building de.wbb3addons.portal.shoutbox.fork.i2c.tar---"
echo ""
tar cvf de.wbb3addons.portal.shoutbox.fork.i2c.tar * --exclude acptemplates --exclude files --exclude templates --exclude README --exclude build.sh --exclude *.*~ --exclude .git
echo ""
echo "---cleaning directory---"
test -e files.tar && rm files.tar
test -e templates.tar && rm templates.tar
echo "---done---"
exit 0
