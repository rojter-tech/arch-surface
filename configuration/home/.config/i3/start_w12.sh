#!/bin/bash
sleep 2
i3-msg "workspace 12; append_layout ~/.config/i3/workspaces/workspace12.json"
(teams &)
sleep 1
(urxvt &)
(urxvt &)
(urxvt &)