F=/var/log/ebuild-timings.txt
mkdir -p $(dirname $F)
touch $F

for i in pkg_pretend pkg_setup src_unpack src_prepare src_configure src_compile src_test src_install pkg_preinst pkg_postinst
do
	eval "pre_$i()  { local SANDBOX_WRITE=${SANDBOX_WRITE}; addwrite /var/log/ebuild-timings.txt; echo \$(cat /proc/uptime | cut -d' ' -f1) \${PN}-\${PVR} $i BEGIN >> /var/log/ebuild-timings.txt ; }"
	eval "post_$i() { local SANDBOX_WRITE=${SANDBOX_WRITE}; addwrite /var/log/ebuild-timings.txt; echo \$(cat /proc/uptime | cut -d' ' -f1) \${PN}-\${PVR} $i END >> /var/log/ebuild-timings.txt ; }"
done

