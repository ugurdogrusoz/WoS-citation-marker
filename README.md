# Citation Marker for Lists from Web of Science

This projects contains a Perl script that takes a text file from Web of Science containing a list of publications and 
their references and marks citations to provided article list.

More specifically,
- it reads a file named **my-citations.txt** generated from Web of Science as described in Bilkent Provost Office's [related
web page](http://w3.bilkent.edu.tr/bilkent/annual-faculty-survey/). This is a list of articles citing your publications.
- it reads a file named **my-publications.txt** listing your publications for which citations are to be marked.
- it outputs a rich text file named **my-citations-marked.rtf**, which is the same as **my-citations.txt** except
    * lines containing citations to your publications are highlighted
    * lines not containing citations to your publications are removed
    * extra mark up text to make text file a rich text file (citatation by others in *yellow*, self in *cyan*)

## Step by Step Instructions

- Install Perl version 5 or later on your PC. This script was tested on Windows using [Padre IDE](http://padre.perlide.org/) 
but it should work with any Perl version 5 or later. We assume Padre was installed on a Windows machine.

- Clone this project through Github. If not familiar with Github, you may download the following files manually to your local:
    * the [script](https://github.com/ugurdogrusoz/WoS-citation-marker/blob/master/citation-marker.pl),
    * sample [my-citations.txt](https://github.com/ugurdogrusoz/WoS-citation-marker/blob/master/my-citations.txt),
    * sample [my-publications.txt](https://github.com/ugurdogrusoz/WoS-citation-marker/blob/master/my-publications.txt), and
    * sample [my-citations-marked.rtf](https://github.com/ugurdogrusoz/WoS-citation-marker/blob/master/my-citations-marked.rtf).
    
- Modify the input files for your needs:
    * in the script, change the line **my $me = "Dogrusoz, U"** to replace the given name with yours (make sure it's formatted the same!),
    * in **my-publications.txt**, change the content to contain your articles as references (one reference per line as they
    in citations file). Notice that using just your name might lead to incorrect results if you do not have a unique name. 
    Listing the entire citation such as
    
      *Dogrusoz U, 2013, IEEE T VIS COMPUT GR, V19, P953, DOI 10.1109/TVCG.2012.178* 
      
      instead of simply
      
      *Dogrusoz U*
      
      is safer. But note that sometimes the same article might be formatted differently in WoS!
    * replace the content of **my-citations.txt** to contain your citation list.

- Open a command prompt window (click Start, then Run, and type **cmd**), and go to the directory containing the script. We
assume input and output files are in the same directory as the script.

- Run the script by typing **perl citation-marker.pl**.

- The file **my-citations-marked.rtf** contains the citation list marked as described earlier using rich text.

## Terms

You may freely use, modify, and redistribute this script as you like. The author assumes no responsibility for the use of this 
software. Please use it at your own risk!

## Credits

This script was written by [Ugur Dogrusoz](http://www.cs.bilkent.edu.tr/~ugur/) of Computer Engineering Department of Bilkent University.
