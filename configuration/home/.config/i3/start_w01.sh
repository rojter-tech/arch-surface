#!/bin/bash
sleep 2
i3-msg "workspace 1; append_layout ~/.config/i3/workspaces/workspace01.json"
(firefox &)