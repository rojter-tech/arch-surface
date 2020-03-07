#!/bin/bash
sleep 1
i3-msg "workspace 10; append_layout ~/.config/i3/workspaces/workspace10.json"
(urxvt &)
(remmina &)
(remmina /home/dreuter/.local/share/remmina/group_rdp_dreuter@rojteracerserv_rojteracerserv-rojter-lo.remmina &)
