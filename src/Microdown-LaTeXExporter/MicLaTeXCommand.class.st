"
A LaTeX command

to emit 

```
\mycommand potentially with arguments and optionals. 

\mycommand[1]{#1}
```
"
Class {
	#name : #MicLaTeXCommand,
	#superclass : #MicLaTeXBrush,
	#category : #'Microdown-LaTeXExporter'
}

{ #category : #accessing }
MicLaTeXCommand >> name: aString [ 
	stream
		<< $\
		<< aString
]
