"
I am signaled by `MicBookStructure class>>chapterLevel:paragraphLevel:` when the two levels cannot describe a book: chapters must be at level 1 or deeper, paragraphs deeper than chapters and at most at level 6, and at most three section levels (section, subsection, subsubsection, as in LaTeX) between them. My `messageText` says which rule is broken.

Pillar lets me through when it builds a book whose `pillar.conf` declares such levels, so the build stops with that message.
"
Class {
	#name : 'MicInvalidBookStructure',
	#superclass : 'Error',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}
