#!/bin/bash
printf "[{"
#sudo ps aux | grep " DataFlowEngine " | grep -v grep | awk '{print t "\""$14"\":\""$6"\""} {t=","}'
sudo ps aux | grep " DataFlowEngine " | grep -v grep | awk '{print t "\""$14"\":{\"mem\":\""$6"\",\"proc\":\""$3"\"}"} {t=","}'
printf "}]"
