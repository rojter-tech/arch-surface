#!/bin/bash
i3-msg "workspace 10; append_layout ~/.config/i3/workspaces/workspace10.json"
sleep 1
(urxvt &)
sleep 1
(remmina &)
sleep 1
(remmina /home/dreuter/.local/share/remmina/group_rdp_dreuter@rojteracerserv_rojteracerserv-rojter-lo.remmina &)
sleep 1
