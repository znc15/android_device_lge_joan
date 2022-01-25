#! /vendor/bin/sh

# Copyright (c) 2012-2013, 2016-2018, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Enable bus-dcvs
echo "bw_hwmon" > /sys/class/devfreq/soc:qcom,cpubw/governor
echo 50 > /sys/class/devfreq/soc:qcom,cpubw/polling_interval
echo 4 > /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/sample_ms
echo 34 > /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/io_percent
echo 20 > /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/hist_memory
echo 10 > /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/hyst_length
echo 0 >/sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/low_power_ceil_mbps
echo 34 > /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/low_power_io_percent
echo 20 > /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/low_power_delay
echo 0 > /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/guard_band_mbps
echo 250 > /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/up_scale
echo 1600 > /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/idle_mbps
echo "mem_latency" > /sys/class/devfreq/soc:qcom,memlat-cpu0/governor
echo 10 > /sys/class/devfreq/soc:qcom,memlat-cpu0/polling_interval
echo "mem_latency" > /sys/class/devfreq/soc:qcom,memlat-cpu2/governor
echo 10 > /sys/class/devfreq/soc:qcom,memlat-cpu2/polling_interval

for memlat in /sys/class/devfreq/*qcom,memlat-cpu*
do
    echo "mem_latency" > $memlat/governor
    echo 10 > $memlat/polling_interval
    echo 400 > $memlat/mem_latency/ratio_ceil
done
setprop persist.vendor.mmi.misc_dev_path $real_path

sleep 5

echo 1 > /sys/devices/system/cpu/cpu0/online
echo 1 > /sys/devices/system/cpu/cpu4/online
echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo 1900800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 2457600 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 300000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo 5000 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/iowait_boost_enable
echo 500 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
echo 5000 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/iowait_boost_enable
echo 500 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
echo 1 > /dev/stune/background/schedtune.boost
echo 5 > /dev/stune/foreground/schedtune.boost
echo 5 > /dev/stune/top-app/schedtune.boost
echo 1 > /dev/stune/rt/schedtune.boost
echo 0 > /dev/stune/system-background/schedtune.boost
echo 1 > /dev/stune/schedtune.sched_boost
echo 1 > /dev/stune/schedtune.prefer_idle
echo 1 > /dev/stune/top-app/schedtune.sched_boost
echo 1 > /dev/stune/top-app/schedtune.prefer_idle
echo 1 > /dev/stune/rt/schedtune.sched_boost
echo 1 > /dev/stune/rt/schedtune.prefer_idle
echo 1 > /dev/stune/foreground/schedtune.sched_boost
echo 1 > /dev/stune/foreground/schedtune.prefer_idle
echo 0 > /dev/stune/background/schedtune.sched_boost
echo 0 > /dev/stune/background/schedtune.prefer_idle
echo 0 > /dev/stune/system-background/schedtune.sched_boost
echo 0 > /dev/stune/system-background/schedtune.prefer_idle
echo zen > /sys/block/sda/queue/scheduler
echo 128 > /sys/block/sda/queue/read_ahead_kb
echo "cubic" > /proc/sys/net/ipv4/tcp_congestion_control
echo 762 > /sys/class/devfreq/soc:qcom,cpubw/min_freq
echo 762 > /sys/class/devfreq/soc:qcom,mincpubw/min_freq
echo 0 > /sys/block/sda/queue/iostats
echo 0 > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost
echo 0-2 > /dev/cpuset/background/cpus
echo 0-2,4-7 > /dev/cpuset/foreground/cpus
echo 0-7 > /dev/cpuset/top-app/cpus
echo 0-3 > /dev/cpuset/system-background/cpus
echo 0-3 > /dev/cpuset/camera-daemon/cpus
echo 0 > /sys/module/msm_thermal/parameters/enabled
echo 0 > /sys/module/msm_thermal/core_control/enabled
echo 0 > /sys/module/msm_thermal/vdd_restriction/enabled
echo "msm-adreno-tz" > /sys/class/kgsl/kgsl-3d0/devfreq/governor
echo 710000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
echo 257000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
echo 6 > /sys/class/kgsl/kgsl-3d0/min_pwrlevel
echo 0 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
echo 6 > /sys/class/kgsl/kgsl-3d0/default_pwrlevel
