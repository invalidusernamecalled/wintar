<B>Project is Now Closed</b>
###### md5 hash 4edef622134f4b732449c57a27504a24<br>
<img src="wintar.png" width=100><p>
- `set archive-choice=`(default=)`.tar|.tar.gz`|`.tar.bz2`|`.tar.xz`|`.tar.lzma`<br>
- `set format-choice=`(default=)`ustar`|`pax`|`cpio`|`shar`

#### Syntax:-
+ <b>`tarrer.bat`</b> "[Directory or FILENAME or *pattern* to include]" `[exclude_pattern1/optional] .. [exclude_pattern8/optional]`<br>
+ <b>`addtotar.bat`</b> "Existing (Uncompressed) tar archive" `"[file or folder toADD]"`<br>
+ <b>`xtar.bat`</b> "ARCHIVEtoExtract"
+ <b>`tarlist.bat`</b> "Archive name or Pattern to list"

#### Salient features:-
1. Archive created is automatically assigned a name.
2. Archive extracted is automatically assigned a folder.
3. Outputs tar error code in output
4. Verbose output
5. returns `2` error level for possibly corrupt archives

###### Supported Wildcards (for Patterns):
1. `*`

>[!WARNING]
> <b>Not for GUI use!</b>
>1. do not use Drag 'n' Drop<br>
>2. do not Drag 'n' Drop multiple items<br>
>3. multiple items are not processed.<br>
>+ (the script will not be able to parse file/directory names if passed thru the GUI because Windows does not pass arguments to the script in proper or predictable format.
>+ Handling such unpredictable format requires an impossible Batch script code. 
>+ Issues have been identified for file/folders using drag and drop that have special characters not passed by Windows in a proper and expected way. (It is a windows issue)

#### Edge and problematic cases:-
1. Do not pass file/folder names or arguments containing ampersand `%` especially some letter or word enclosed in ampersands like `some %file%.txt` as it is subject to mis interpretation by the shell.
2.  File/Folder names containing special variable names (enclosed in `%` like `%specialname%` *may* be misinterpreted (untested) but *will usually* return a file not found error. (`9009`)
3. File names cannot contain Double quotes as part of the name, and should be *enclosed* in double - quotes `"file name"`
4. Many cases are associated with Shell vulnerability or weakness rather than a script issue. These issues must ideally be checked before passing the arguments to the batch script.
5. If you wish to use this script in an automated way, it is better to study this script's behaviour independently and check its output with the edge case file names.
