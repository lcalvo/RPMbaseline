#!/bin/bash

# rpm query for rpm database installed 

rpm -qa --queryformat "%{NAME}.%{ARCH}:%{VERSION}:%{INSTALLTIME:date}:%{SIZE}\n"
