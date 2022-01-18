#!/system/bin/sh
#说明
#如果你想设置默认调度
#请把"setprop persist.spectrum.profile"改成对应参数即可
#实例:0对应均衡模式(默认),1对应性能模式,2对应省电模式,3对应游戏模式
#改完之后是这样 setprop persist.spectrum.profile 2 
#开机之后应用的模式就是省电模式
#请不要动"setprop persist.fastspeed.boot" 否则会无法开机
if [ ! -f /data/property/persist.spectrum.profile ]; then
    setprop persist.spectrum.profile 0
    # setprop persist.fastspeed.boot 1
fi
