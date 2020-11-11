post_pkg_postinst() {
	if [[ "$(hostname)" != "samsonov" ]]
	then
		F=${PKGDIR}/${CATEGORY}/${PN}-${PVR}.tbz2
		if [[ -f $F ]]
		then
			rm $F;
			M="$F"
		else
			M="$F not found"
		fi
		echo "$(date) ${PN}-${PVR} ($M)" >> /kaka.txt ;
	fi
}
