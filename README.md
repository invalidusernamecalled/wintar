#### Syntax:-
<SUP>optional</SUP> `ENVIRONMENT VARIABLE` : `set archive-choice=`[{default=}`.tar|.tar.gz`|`.tar.bz2`|`.tar.xz`|`.tar.lzma`]<br>
<SUP>optional</SUP> `ENVIRONMENT VARIABLE` : `set format-choice=`[{default=}`ustar`|`pax`|`cpio`|`shar`]

<b>`tarrer.bat`</b> `"[Directory or FILENAME or *pattern* to include]"` `[{Optional=}exclude_pattern]`

`addtotar.bat EXISTINGarchiveNAME file/folderNAMEtoADD`

#### Edge cases Reviewed:-
1. File names containing special variable names (enclosed in `%` like `%special_name%` could be mis interpreted but will return a file not found error. (`9009`)
2. File names cannot contain Double quotes as part of the name, but should be enclosed in them `"file name"`

>[!WARNING]
>do not use Drag 'n' Drop generally, especially with multiple items<br>
>multiple items are not supported/processed.<br>
>(the script does not parse file/directory names properly if passed thru the GUI because Windows does not pass arguments to the script in a useful format.)
