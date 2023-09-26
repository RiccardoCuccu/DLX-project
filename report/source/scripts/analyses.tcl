set_analysis_view -setup {default} -hold {default}
reset_parasitics
extractRC
rcOut -setload dlx.setload -rc_corner standard
rcOut -setres dlx.setres -rc_corner standard
rcOut -spf dlxspf -rc_corner standard
rcOut -spef dlx.spef -rc_corner standard
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix DLX_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix DLX_postRoute -outDir timingReports
getAnalysisMode -checkType
getAnalysisMode -checkType
get_time_unit
report_timing -machine_readable -max_paths 10000 -max_slack 0.75 -path_exceptions all -late > top.mtarpt
load_timing_debug_report -name default_report top.mtarpt
verifyConnectivity -type all -error 1000 -warning 50
reportGateCount -level 5 -limit 100 -outfile dlx.gateCount
saveNetlist dlx.v
all_hold_analysis_views 
all_setup_analysis_views 
write_sdf  -ideal_clock_network dlx.sdf
