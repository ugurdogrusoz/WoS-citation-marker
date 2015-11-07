#!/usr/bin/perl
  #
  # Written by Ugur Dogrusoz (CS Dept, Bilkent U)
  #
  # Reads file "my-citations.txt" generated from web of knowledge as described in the Provost Office web page
  # Reads file "my-publications.txt" listing publications for which citations are to be marked
  # Outputs rich text file "my-citations-marked.rtf", which is the same as "my-citations.txt" except
  #   - lines containing citations to your publications are highlighted
  #   - lines not containing citations to your publications are removed
  #   - extra mark up text to make text file a rich text file (citatation by others in Yellow, self in Cyan)
  #
  # The author assumes no responsibility for the use of this software. Use at your own risk!
  #
  
  # Strict and warnings are recommended
  use strict;
  use warnings;
  
  # Person's name to whom citations will be marked (needed to determine self citations)
  my $me = "Dogrusoz, U";

  # Input files
  open(CITS, "<my-citations.txt");
  open(PUBS, "<my-publications.txt");

  # Output file
  open(CITSMARKED, ">my-citations-marked.rtf");
  
  # Write the header of the .rtf file
  print CITSMARKED "{\\rtf1\\ansi\\deff0\\fs20 {\\fonttbl {\\f0 Lucida Console;}}\n" .
    "{\\colortbl;\\red255\\green255\\blue0;\\red0\\green255\\blue255;\\red255\\green0\\blue0;}\n";

  my @citLines;
  my @pubLines;
  my $line;
  my $lineNo = 0;
  
  # Read publication list into an array (make sure to list all varying listings of your publications!)
  while (<PUBS>) {
    chomp $_; # remove newline char
    $pubLines[$lineNo] = $_;
    $lineNo++;
  }
  
  # Read citation list one by one and mark as specified
  my $articleCount = 0;
  my $citationCountOthers = 0;
  my $citationCountSelf = 0;
  my $isSelf = 0;
  my $containsCitation = 0;
  
  # Current line position can be 
  #     _AU     : prior to Author list
  #     AU      : during Author list
  #     AU_     : after Author list, before Reference list
  #     CR      : during Reference list
  #     CR_     : after Reference list
  my $positionState = "_AU";

  while (<CITS>) {
    # get current line
    chomp $_; # remove newline char
    $line = $_;

    # see if state changes
    if ($line =~ /^PT/) {
      $positionState = "_AU";
      # a new citation starts
      $articleCount++;
      $containsCitation = 0;
    }
    elsif ($line =~ /^AU/) {
      $positionState = "AU";
      # author list starts
      $isSelf = 0;
    }
    elsif ($line =~ /^AF/) {
      $positionState = "AU_";
    }
    elsif ($line =~ /^CR/) {
      $positionState = "CR";
      print CITSMARKED "CR\\line\n";
      $line =~ s/CR/  /i;
    }
    elsif ($line =~ /^TC/) {
      $positionState = "CR_";
      
      if ($containsCitation == 0) {
        my $warningMessage = "Warning: this article does not have a citation to any publication provided.";
        print CITSMARKED "{\\highlight3 " . $warningMessage . "\\line}\n";
        print $warningMessage . "\n";
      }
    }
        
    if ($positionState eq "CR") {
      if (isMyPub($line, \@pubLines) == 1) {
        $containsCitation = 1;
        
        # find and output leading whitespace (not to be highlighted)
        $line =~ /^(\s*)/;
        print CITSMARKED $1;
          
        # trim leading whitespace
        $line =~ s/^\s+//;
        
        # write citation with highlight mark up
        if ($isSelf == 0) {
          $citationCountOthers++;
          print CITSMARKED "{\\highlight1 ";
        }
        else {
          $citationCountSelf++;
          print CITSMARKED "{\\highlight2 ";
        }
          
        print CITSMARKED $line . "\\line}\n";
      }
    }
    else {
      # not a citation or not my citation, write line as is
      print CITSMARKED $line . "\\line\n";

      if ($positionState eq "AU") {
        if ($line =~ /$me/) {
          $isSelf = 1;
        }
      }
    }
  }
  
  # Write citation counts and file trailer
  print CITSMARKED "\\line\n" .
    "Number of articles in citations file: " . $articleCount . "\\line\\line\n" .
    "{\\highlight1 Number of citations by others}: \\b " . $citationCountOthers . "\\b0\\line\\line\n" .
    "{\\highlight2 Number of self citations}: \\b " . $citationCountSelf . "\\b0\\line\n" .
    "}";

  # Output stats to console as well
  print 
    "Number of articles in citations file: " . $articleCount . "\n" .
    "Number of citations by others: " . $citationCountOthers . "\n" .
    "Number of self citations: " . $citationCountSelf . "\n\n";
  
  # Close all files
  close PUBS;
  close CITS;
  close CITSMARKED;

  # Checks whether or not a citation (arg 1) matches one of my publications (arg 2)
  # Returns 0: no match, 1: match
  sub isMyPub {
    my $lineRef = $_[0];
    my @pubLinesRef = @{$_[1]};
    my $pub;
    
    foreach $pub (@pubLinesRef) {
      if (index($lineRef, $pub) != -1) {
        return 1;
      }
    }
    
    return 0;
  }
