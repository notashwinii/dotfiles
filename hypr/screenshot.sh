#!/bin/bash

# Create the Pictures directory if it doesn't exist
mkdir -p ~/Pictures

# Take a screenshot with a timestamp
grim ~/Pictures/screenshot_$(date '+%Y-%m-%d_%H-%M-%S').png

