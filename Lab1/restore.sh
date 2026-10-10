
dir=$1
malicious_dir=$2
interval=$3

while true
do
if [ -z "$(ls -A $malicious_dir)" ]
then
    echo "No malicious files to review."
    exit 
fi

files=$(ls $malicious_dir)
i=1

for file in $files
do
    echo $i"."$file
    i=`expr $i + 1`
done

echo "Choose a file number:"
read num

i=1
for file in $files
do
    if [ $i -eq $num ]
    then
        break
    fi
    i=`expr $i + 1`
done

if [ $i -ne $num ]
then
    echo "Invalid file number."
    exit
fi

echo "1. Restore this file"
echo "2. Permanently delete this file"
echo "3. Leave this file as-is"
echo "Choose an option:"
read option

case $option in
    1)
         cp $malicious_dir/$file $dir
	 rm $malicious_dir/$file
         echo "Restored $file to $dir."
        ;;

    2)
         rm $malicious_dir/$file
          echo $file" permanently deleted."
        ;;

    3)
        echo "File left in quarantine."
        ;;

    *)
        echo "Invalid option."
        ;;
esac
done
