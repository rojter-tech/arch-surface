#!/bin/bash
sleep 1
i3-msg "workspace 10; append_layout ~/.config/i3/workspace_10.json"
(spotify &)
