# when run within this repository, this script assigns all sprites to a random texture group.
# run from the meta/ directory
# This is an alternate and older form of the texture page optimization present in GMSCacheManager. Its efficiency is...well random. Use at your own risk.

for f in ../sprites/*; do
    tgp=$((($RANDOM % 114) + 1))
	echo "$tgp"
	sed --binary -i "s/<TextureGroup0>0<\/TextureGroup0>/<TextureGroup0>$tgp<\/TextureGroup0>/g" $f
done
