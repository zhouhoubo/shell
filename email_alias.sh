#!/bin/sh

# addmacalias - Adds a new alias to the email alias database on Mac OS X.
#   This presumes that you've enabled sendmail, which can be kind of
#   tricky. Go to http://www.macdevcenter.com/ and search for "sendmail"
#   for some good reference works.

showaliases="nidump aliases ."

if [ "$(/usr/bin/whoami)" != "root" ] ; then
  echo "$(basename $0): You must be root to run this command." >&2
  exit 1
fi

if [ $# -eq 0 ] ; then
  echo -n "Alias to create: "
  read alias
else
  alias=$1
fi

# Now let's check to see if that alias already exists...
if $showaliases | grep "${alias}:" >/dev/null 2>&1 ; then
  echo "$0: mail alias $alias already exists" >&2
  exit 1
fi

# Looks good. let's get the RHS and inject it into NetInfo

echo -n "pointing to: "
read rhs # the right-hand side of the alias

niutil -create . /aliases/$alias
niutil -createprop . /aliases/$alias name $alias
niutil -createprop . /aliases/$alias members "$rhs"

echo "Alias $alias created without incident."

exit 0

