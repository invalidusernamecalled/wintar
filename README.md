#### Syntax:-
<SUP>optional</SUP> `ENVIRONMENT VARIABLE` : `set archive-choice=`[{default=}`.tar|.tar.gz`|`.tar.bz2`|`.tar.xz`|`.tar.lzma`]<br>
<SUP>optional</SUP> `ENVIRONMENT VARIABLE` : `set format-choice=`[{default=}`ustar`|`pax`|`cpio`|`shar`]

<b>`tarrer.bat`</b> `"[Directory or FILENAME or *pattern* to include]"` `[{Optional=}exclude_pattern]`

`addtotar.bat EXISTINGarchiveNAME file/folderNAMEtoADD`

#### Edge cases Reviewed:-
1. File names contain `!` could be mis interpreted leading to a File Not Exist Error. Will require escaping `^^^!` which may not be feasible.
2. FIle names containing special variable names could be mis interpreted.

>[!WARNING]
>do not use Drag 'n' Drop generally, especially with multiple items<br>
>multiple items are not supported/processed.<br>
>(the script does not parse file/directory names properly if passed thru the GUI because Windows does not pass arguments to the script in a useful format.)
