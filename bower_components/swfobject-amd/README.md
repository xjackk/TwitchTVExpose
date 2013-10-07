WARNING: This is a fork
=======================

I've forked swfobject because of this comment: https://github.com/swfobject/swfobject/pull/12#issuecomment-8253145

Apparently the swfobject authors don't care about modularizing or keeping things small.
Also they seem to be keep on fragmentation rather than improving the central repos, so here we go, unix all over again.

Assumptions for this fork and the programmers using it:
* The programmer knows what he is doing
* The author wants module loader compatibility
* The author doesn't call swfobject.embedswf before the page has loaded


If you want to read swfobject own documentation go here: https://github.com/swfobject/swfobject
