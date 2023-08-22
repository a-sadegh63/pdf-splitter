message='Please enter your choice (number): '
options=("All PDF files" "Specific PDF file" "Cancel")
select opt in "${options[@]}"; do
    case $opt in
    'All PDF files')
        files=$(ls -1 *.pdf | sort -V) # Get all PDF files in the current directory and sort them
        break
        ;;
    'Specific PDF file')
        read -p "Enter PDF file name (without extension): " fileName # Prompt the user to enter a specific PDF file name
        if [ -e "${fileName}.pdf" ]; then                            # Check if the file with the given name and PDF extension exists
            files="$fileName.pdf"                                    # Store the file name in the 'files' variable
        else
            echo "The $fileName.pdf does not exist in the current path" # Display an error message if the file does not exist
            exit 1
        fi
        break
        ;;
    'Cancel')
        exit 1 # Exit the script if the user chooses to cancel
        ;;
    *)
        echo "Invalid option $REPLY" # Display an error message for invalid options
        exit 1
        ;;
    esac
done

while true; do
    read -p "Enter the number of pages you want to be in each part: " part_count # Prompt the user to enter the number of pages per part
    if [[ $part_count =~ ^[0-9]+$ ]]; then                                       # Check if the input is a numeric value
        break
    else
        echo "Your input is not numeric. Please try again..." # Display an error message for non-numeric input
    fi
done

for file in "${files[@]}"; do
    count=$(pdftk $file dump_data | grep NumberOfPages | awk '{print $2}') # Get the number of pages in the PDF file using pdftk
    loop_count=$(expr $count / $part_count + 1)                            # Calculate the number of parts needed for the file
    reminder=$(($count % $part_count))                                     # Calculate the remaining pages after dividing into parts
    for ((i = 1; i <= loop_count; i++)); do
        if [[ $i == 1 ]]; then
            start_page=1
        else
            start_page=$((($i - 1) * $part_count + 1)) # Calculate the starting page for each part
        fi
        end_page=$(($start_page + $part_count - 1)) # Calculate the ending page for each part
        if [[ "$i" = "$loop_count" ]]; then
            if [[ reminder == 0 ]]; then
                break
            fi
            end_page=$(($start_page + $reminder - 1)) # Adjust the ending page for the last part if there is a remainder
        fi
        folder="${file%.*}"
        mkdir -p $folder                                                   # Create a folder with the same name as the file (without extension)
        pdftk $file cat $start_page-$end_page output "$PWD/$folder/$i.pdf" # Extract the specified pages and save them in the folder
    done
done

echo "Done"
