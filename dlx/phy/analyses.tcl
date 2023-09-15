# After launching Innovus, select "File" > "Import Design."

set_analysis_view -setup {default} -hold {default}
reset_parasitics
extractRC
rcOut -setload dlx.setload -rc_corner standard
rcOut -setres dlx.setres -rc_corner standard
rcOut -spf dlxspf -rc_corner standard
rcOut -spef dlx.spef -rc_corner standard
