backup_file=${args[backup-file]}
volume_name=${args[volume]}
force=${args[--force]}

# Check backup file exists
if [ ! -f $backup_file ]; then
	echo "Backup file '$backup_file' does not exist"
	exit 1
fi

# Check volume name is valid (todo: search exact patter for allowed volume names)
if ! [[ "$volume_name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    echo "Invalid volume name '$volume_name'"
    exit 1
fi

# Check if volume already exist with the same requested  name
if  docker volume inspect "$volume_name" &> /dev/null; then
	if [ ! -z $force ]; then
		echo "Deleting existing volume $volume_name"
		docker volume rm $volume_name
	else
		echo "volume '$volume_name' already exists, carefully re-run the command with --force if you want to override"
		exit 1
	fi
fi

# Copy backup file to a temporary location
temp_install_dir="/tmp/restore_tmp_$(date +%s)" 
mkdir -p $temp_install_dir
cp $backup_file $temp_install_dir

# Create volume and copy backup content
docker run --rm -v $volume_name:/restore -v $temp_install_dir:/backup alpine sh -c "cd /restore && tar xvf /backup/$backup_file --strip 1 && echo -e '\e[32m[+] Backup restored !\e[0m'"

# Clean up
rm -rf $temp_install_dir

