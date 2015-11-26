local (xcolors = `` \n {xrdb -query | sed 's,^\*.color,,;t;d' | sort -n | cut -f2}) {
   # I hate 1-indexing
   XCOLORS = $xcolors(2 ...)
   XCOLORS_0 = $xcolors(1)
}
