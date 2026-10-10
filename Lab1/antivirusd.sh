

dir=$1
malicious_dir=$2
interval=$3

extensions=("exe" "bat" "vbs" "scr" "ps1")

files=$(ls $dir)

while true
do
    sleep $interval

    ls $dir > new-dir

    if ! diff -q last-dir new-dir > /dev/null
    then
              files=$(ls $dir)
              for file in $files
        do
                ext=$(echo $file | cut -d '.' -f 2)
                for extension in $extensions
                do

                        if [ $ext = $extension ]
                        then
				cp $dir/$file $malicious_dir
				rm $dir/$file
                                echo $file "is malicious and it is DELETED"
                                break

                        elif grep -i -E  -q "virus|trojan|malware|worm|ransomware" $dir/$file 
                        then
                               
                                cp $dir/$file $malicious_dir
                                rm $dir/$file
                                echo $file "is malicious and it is DELETED"
                                break

                        fi
                done

        done

        ls $dir > last-dir
    fi
done
