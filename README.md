###### md5 hash 9d70c7fa06d41b93c9a35bb872cf837f
#### Syntax:-
<SUP>optional</SUP> `ENVIRONMENT VARIABLE` : `set archive-choice=`[{default=}`.tar|.tar.gz`|`.tar.bz2`|`.tar.xz`|`.tar.lzma`]<br>
<SUP>optional</SUP> `ENVIRONMENT VARIABLE` : `set format-choice=`[{default=}`ustar`|`pax`|`cpio`|`shar`]

<b>`tarrer.bat`</b> `"[Directory or FILENAME or *pattern* to include]"` `[{Optional=}exclude_pattern]`

`addtotar.bat EXISTINGarchiveNAME file/folderNAMEtoADD`

#### Edge cases Reviewed:-
1. File names containing special variable names (enclosed in `%` like `%special_name%` could be mis interpreted but will return a file not found error. (`9009`)
2. File names cannot contain Double quotes as part of the name, and should be enclosed in double - quotes `"file name"`
3. Both cases are associated with Shell vulnerability or weakness rather than a script issue. These issues must ideally be checked before passing the arguments to the batch script.

>[!WARNING]
>do not use Drag 'n' Drop generally, especially with multiple items<br>
>multiple items are not supported/processed.<br>
>(the script will not be able to parse (multiple or even single in some cases) file/directory names properly if passed thru the GUI because Windows does not pass arguments to the script in a proper format. Handling such unpredicatble format requires immense and an impossible Batch script code. There is also a built in limit to number of arguments that can be parsed in a shell script meaning multiple files (usually beyond 9) cannot use the built in parser.)
>It is not recommended to calculate the file hash using the `/v` command, it should be done independently.
