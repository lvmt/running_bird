while read database operation argums
do
    echo "database --> ${database}"
    echo "operation --> ${operation}"
    echo "argums --> ${argums}"
done < test.txt

