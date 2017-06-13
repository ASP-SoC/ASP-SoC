#----------------------------------*-tcl-*-
# set Root as relativ path ./src/grp<aGROUP>/unit<aUNIT>/sim/
if {![info exists Root]} {
  set Root ../../..
}

if {[info exists worklibdir]} {
} else {
  if {[info exists ::env(TEMP)]} {
    set worklibdir $env(TEMP)
  } else {
    set worklibdir ${Root}/..
  }
}
echo worklibdir = $worklibdir

#----------------------------- work
vlib      ${worklibdir}/work
vmap work ${worklibdir}/work
