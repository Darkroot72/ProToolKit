#!/usr/bin/env bash


export_json_log() {
log_header "Export JSON"
local out="Report_${START_TS}.json"
{
echo "{"
echo " \"host\": \"${HOST}\","
echo " \"timestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\","
echo " \"log\": ["
sed -e 's/\\/\\\\/g'
