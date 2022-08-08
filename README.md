# CLU files, 1976-1989
This repository contains a set of files from 1976-1989 (most from 1976-1978) that can be used to create a working version of an early version of the [CLU programming language](https://en.wikipedia.org/wiki/CLU_(programming_language)) originally created at MIT by Barbara Liskov and her students starting in fall 1973. The files are a part of the [Massachusetts Institute of Technology, Tapes of Tech Square (ToTS) collection](https://archivesspace.mit.edu/repositories/2/resources/1265) at the MIT Libraries Department of Distinctive Collections (DDC). Most files were originally created on the ITS operating system.

More information and more recent versions of the programming language can be found on the [CLU homepage](http://pmg.csail.mit.edu/CLU.html).
## File organization and details
### [clu](../main/clu)
The files within this directory are the CLU specific files from [34 different tape image files](../main/tapeimagelist.txt) in the [ToTS collection](https://archivesspace.mit.edu/repositories/2/resources/1265) that constitute the files needed to create a working version.

 Included in this set are the CLUSYS runtime from 1977-1978, and CLU compiler versions 3.x from 1978. A MDL (Muddle) "save file" of CLU version 2 is also present in the file set. Most files are from ITS backup tapes, but the [files from one TOPS-20 tape](../main/clu/9006077) are needed to compile files.

 Most files were extracted from the tape image using the [itstar program](https://github.com/PDP-10/itstar). The filenames have been adapted to Unix conventions, as per the itstar translation. The original filename syntax would be formatted like, ```CLU; CLU STAT```, for example. The files from the TOPS-20 tape image were extracted using the [tapeutils/read20 program](https://github.com/brouhaha/tapeutils/blob/master/read20.c). All files have been placed into this artificial clu directory for organizational purposes. The files extracted from the tape images were put into sub-folders with a corresponding name to the tapes listed in the ```tapeimagelist.txt``` file. Files in the ```7005372``` folder are from the pre-extracted set done by MIT CSAIL in 2009.
### [codemeta.json](../main/codemeta.json)
This file is metadata about the CLU files, using the [CodeMeta Project](https://codemeta.github.io/) schema.
### [LICENSE.md](../main/LICENSE.md)
File describing the details under which rights to this code. See [Rights](#rights) for additional information.
### [README.md](../main/README.md)
This file is the readme detailing the content and context for this repository.
### [tree.txt](../main/tree.txt)
A file tree listing the files in the [```clu```](../main/clu) directory showing the original file timestamps as extracted from the tape image.
### [tapeimagelist.txt](../main/tapeimagelist.txt)
A list of all the tape images and their paths in the ToTS collection that these files came from.

## Preferred Citation
[filename], CLU files, 1976-1989, Massachusetts Institute of Technology, Tapes of Tech Square (ToTS) collection, MC-0741. Massachusetts Institute of Technology, Department of Distinctive Collections, Cambridge, Massachusetts. [swh:1:dir:d94d3d849f0272a308ca322946dfd8cb0554ff26](https://archive.softwareheritage.org/swh:1:dir:d94d3d849f0272a308ca322946dfd8cb0554ff26)
## Rights
To the extent that MIT holds rights in these files, they are released under the terms of the [MIT No Attribution License](https://opensource.org/licenses/MIT-0). See the ```LICENSE.md``` file for more information. Any questions about permissions should be directed to [permissions-lib@mit.edu](mailto:permissions-lib@mit.edu)
## Acknowledgements
Thanks to [Lars Brinkhoff](https://github.com/larsbrinkhoff) for help with identifying these files and with extracting them using the itstar/read20 programs mentioned above.
