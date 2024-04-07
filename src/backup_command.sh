volume_name=${args[volume]}
output_filename=${args[--out]}

# Check input not empty
if [  -z "$volume_name" ]; then
    echo "Name of the volume cannot be empty"
    exit 1
fi

# Check volume exists
if ! docker volume inspect "$volume_name" &> /dev/null; then
    echo "Volume '$volume_name' does not exist!"
    exit 1
fi

# Default filename
if [ -z "$output_filename" ]; then
    output_filename="bkup-volume-$volume_name-$(date +"%d-%m-%Y_%H_%M").tar"
fi

if ! [[ "$output_filename" =~ ^[a-zA-Z0-9_.-]+.tar$ ]]; then
    echo "Invalid output filename '$output_filename'."
    exit 1
fi

echo "[*] Backing up volume $volume_name to file: $output_filename ..."
docker run --rm -v $volume_name:/volume-data -v $PWD:/bkup alpine tar cf /bkup/$output_filename /volume-data &>/dev/null

if [ $? -eq 0 ]; then
    echo "[+] Backup completed successfuly"
else
    echo "[-] Backup failed"
fi

