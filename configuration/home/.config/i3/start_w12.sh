#!/bin/bash
i3-msg "workspace 12; append_layout ~/.config/i3/workspaces/workspace12.json"
sleep 1
(teams &)
(urxvt &)
(urxvt &)