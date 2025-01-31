#### Syntax:-
<SUP>optional</SUP> `ENVIRONMENT VARIABLE` : `set archive-choice=`[{default=}`.tar.gz`|`.tar.bz2`|`.tar.xz`|`.tar.lzma`]<br>
<SUP>optional</SUP> `ENVIRONMENT VARIABLE` : `set format-choice=`[{default=}`ustar`|`pax`|`cpio`|`shar`]

`"tarrer.bat" "[Directory/File/pattern] to Add" [exclude_pattern/optional]`

`addtotar.bat EXISTINGarchiveNAME file/folderNAMEtoADD`

>[!WARNING]
do not use Drag 'n' Drop generally and especially with multiple items (the script does not parse names correctly because of the way windows provides the arguments)
