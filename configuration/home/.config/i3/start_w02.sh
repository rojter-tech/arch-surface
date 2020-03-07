#!/bin/bash
sleep 2
i3-msg "workspace 2; append_layout ~/.config/i3/workspaces/workspace02.json"
(firefox-developer-edition &)