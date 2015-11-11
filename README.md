# Citation Marker for Lists from Web of Science

This projects contains a Perl script that takes a text file from Web of Science containing a list of publications and 
their references and marks citations to provided article list.

More specifically,
- it reads a file named **my-citations.txt** generated from Web of Science (file "savedrec.txt") as described in Bilkent Provost Office's [related
web page](http://w3.bilkent.edu.tr/bilkent/annual-faculty-survey/). This is a list of articles citing your publications.
- it reads a file named **my-publications.txt** listing your publications for which citations are to be marked. These are essentially lines from **my-citations.txt** corresponding to your publications.
- it outputs a rich text file named **my-citations-marked.rtf**, which is the same as **my-citations.txt** except
    * lines/references that are your publications (i.e. your citations) are highlighted
    * lines/references that are not your publications are removed
    * extra mark up text to make text file a rich text file; citation by others in *yellow* (*double underline*), self in *cyan* (*underline*) for color (black and white) printing.

## Step by Step Instructions

- Install Perl version 5 or later on your PC. This script was tested on Windows using [Padre IDE](http://padre.perlide.org/) 
but it should work with any Perl version 5 or later.

- Clone this project through Github. If not familiar with Github, you may download the following files manually to your local:
    * the [script](https://raw.githubusercontent.com/ugurdogrusoz/WoS-citation-marker/master/citation-marker.pl),
    * sample [my-citations.txt](https://raw.githubusercontent.com/ugurdogrusoz/WoS-citation-marker/master/my-citations.txt),
    * sample [my-publications.txt](https://raw.githubusercontent.com/ugurdogrusoz/WoS-citation-marker/master/my-publications.txt), and
    * sample [my-citations-marked.rtf](https://raw.githubusercontent.com/ugurdogrusoz/WoS-citation-marker/master/my-citations-marked.rtf).
    
- Modify the input files for your needs:
    * in the script, change the line **my $me = "Dogrusoz, U"**; replace the given name with yours (make sure it's formatted the same!),
    * in the script, for the line **my $markUpForColorPrinting = 1**, change 1 to 0 if the marked up document will be printed in black and white,
    * in **my-publications.txt**, change the content to contain your articles as references (one reference per line as they
    appear in citations file). Notice that using just your name might lead to incorrect results (i.e. counting somebody else's citation with the same name) if you do not have a unique name. 
    Listing the entire citation such as
    
      *Dogrusoz U, 2013, IEEE T VIS COMPUT GR, V19, P953, DOI 10.1109/TVCG.2012.178* 
      
      instead of simply
      
      *Dogrusoz U*
      
      is safer. But note that sometimes the same article might be formatted differently in WoS! For the above article, another way it is listed might be
      
      *Dogrusoz U, 2013, IEEE T VIS COMPUT GR, V19, DOI 10.1109/TVCG.2012.178*
      
    * replace the content of **my-citations.txt** to contain your citation list (rename file "savedrec.txt"). In case no cited reference of an article lists any of the articles in **my-publications.txt** (which is an indication of a missing publication), a warning (in red) should be printed for each such article.

- Open a command prompt window (click Start, then Run, and type **cmd**), and go to the directory containing the script. We
assume input and output files are in the same directory as the script.

- Run the script by typing **perl citation-marker.pl**.

- The file **my-citations-marked.rtf** contains the citation list marked as described earlier using rich text.

## Terms

You may freely use, modify, and redistribute this script as you like. The author assumes no responsibility for the use of this 
software. Please use it at your own risk!

## Credits

This script was written by [Ugur Dogrusoz](http://www.cs.bilkent.edu.tr/~ugur/) of Computer Engineering Department of Bilkent University.
