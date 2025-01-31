#### Syntax:-
<SUP>optional</SUP> `ENVIRONMENT VARIABLE` : `set archive-choice=`[{default=}`.tar.gz`|`.tar.bz2`|`.tar.xz`|`.tar.lzma`]<br>
<SUP>optional</SUP> `ENVIRONMENT VARIABLE` : `set format-choice=`[{default=}`ustar`|`pax`|`cpio`|`shar`]

<b>`tarrer.bat`</b> `"[Directory or FILENAME or *pattern* to include]" [{Optional=}exclude_pattern]`

`addtotar.bat EXISTINGarchiveNAME file/folderNAMEtoADD`

>[!WARNING]
do not use Drag 'n' Drop generally, especially with multiple items (multiple items are not supported/processed by the script. the script does not parse file/directory names correctly in GUI because of the particular unique format that windows uses to provide arguments to the script. instead move multiple items to a single folder to process)
