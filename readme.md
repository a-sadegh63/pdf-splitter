# PDF Splitter Script

This script allows you to split PDF files into multiple parts based on the desired number of pages per part. It provides options to split all PDF files in the current directory or a specific PDF file.

## Usage

1. Run the script by executing the following command in the terminal:
```
bash pdf_splitter.sh
```

2. You will be prompted to choose an option:
- Select "All PDF files" to split all PDF files in the current directory.
- Select "Specific PDF file" to split a specific PDF file.

3. If you choose the option "Specific PDF file", enter the name of the PDF file (without the extension) when prompted.

4. Next, enter the desired number of pages you want to be in each part.

5. The script will split the PDF file(s) into multiple parts and save them in separate folders. Each part will contain the specified number of pages.

## Requirements

- pdftk: The script uses pdftk (PDF Toolkit) to manipulate PDF files. Make sure pdftk is installed on your system before running the script.

## Notes

- The script assumes that the PDF files are located in the same directory as the script.
- The script creates a folder for each PDF file (or the specific PDF file) and saves the split parts in their respective folders.

Feel free to modify and customize the script according to your needs.