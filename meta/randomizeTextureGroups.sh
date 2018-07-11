# when run within this repository, this script assigns all sprites to a random texture group.
# run from the meta/ directory


for f in ../sprites/*; do
    tgp=$((($RANDOM % 90) + 1))
	echo "$tgp"
	sed --binary -i "s/<TextureGroup0>0<\/TextureGroup0>/<TextureGroup0>$tgp<\/TextureGroup0>/g" $f
done
