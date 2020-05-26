"
I am a header. I look like this:

# level 1
### level 3

Deepest level is level 6
"
Class {
	#name : #GHMHeaderBlock,
	#superclass : #GHMSingleLineBlock,
	#instVars : [
		'level',
		'header'
	],
	#category : #'Microdown-Model'
}

{ #category : #testing }
GHMHeaderBlock >> addLineAndReturnNextNode: line [
	"Line is on the form '#### my heading at forth level'"
	level := ('(#+)' asRegex
		matchesPrefix: line;
		subexpression: 1) size.
	header := (line copyFrom: level + 1 to: line size) trim.
	^ self
]

{ #category : #public }
GHMHeaderBlock >> contents [ 
	^ super contents , '[ ', self level printString, '/', self header, ' ]'
]

{ #category : #accessing }
GHMHeaderBlock >> formattedCode [ 
	^super formattedCode , '[ ', self level printString, '/', self header, ' ]'
]

{ #category : #accessing }
GHMHeaderBlock >> header [
	^ header
]

{ #category : #accessing }
GHMHeaderBlock >> level [
	^ level
]
