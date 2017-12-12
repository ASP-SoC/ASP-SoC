#----------------------------------*-tcl-*-
# set Root as relativ path ./src/grp<aGROUP>/unit<aUNIT>/sim/
if {![info exists Root]} {
  set Root ../../..
}

if {[info exists worklibdir]} {
} else {
  if {[info exists ::env(MY_WORKLIB_PATH)]} {
    set worklibdir $env(MY_WORKLIB_PATH)
  } else {
    set worklibdir ${Root}/..
  }
}
echo worklibdir = $worklibdir

#----------------------------- ieee_proposed
vlib      ${worklibdir}/ieee_proposed
vmap ieee_proposed ${worklibdir}/ieee_proposed

#----------------------------- work
vlib      ${worklibdir}/work
vmap work ${worklibdir}/work


