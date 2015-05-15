#!/bin/bash

echo Starting HAProxy...

haproxy -f /data/haproxy/haproxy.conf
