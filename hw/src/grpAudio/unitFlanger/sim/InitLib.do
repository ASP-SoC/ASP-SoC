#----------------------------------*-tcl-*-
# set Root as relativ path ./src/grp<aGROUP>/unit<aUNIT>/sim/
if {![info exists Root]} {
  set Root ../../..
}

if {[info exists worklibdir]} {
} else {
  if {[info exists ::env(MY_WORKLIB_PATH)]} {
    set worklibdir $env(MY_WORKLIB_PATH)
  }
  elseif {[info exists ::env(TEMP)]} {
    set worklibdir $env(TEMP)
  } else {
    set worklibdir ${Root}/..
  }
}
echo worklibdir = $worklibdir

#----------------------------- work
vlib      ${worklibdir}/work
vmap work ${worklibdir}/work
