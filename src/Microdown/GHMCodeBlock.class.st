"
I am a code block. I look like this, starting and ending with three $`
my 'arguments' is just the text from the fourth character up to the end of line.

```arguments
line 1
line 2
line 3
``` 

"
Class {
	#name : #GHMCodeBlock,
	#superclass : #GHMSameStartStopMarkupBlock,
	#instVars : [
		'arguments'
	],
	#category : #'Microdown-Model'
}

{ #category : #accessing }
GHMCodeBlock >> arguments [
	^ firstLine
]

{ #category : #accessing }
GHMCodeBlock >> arguments: aString [
	firstLine := aString
]

{ #category : #accessing }
GHMCodeBlock >> code [
	^ self body
]

{ #category : #public }
GHMCodeBlock >> contents [ 
	^super contents , '[ ', self code, ' ]'
]

{ #category : #utils }
GHMCodeBlock >> lineStartMarkup [
	"a code block is delimited by ``` "
	
	^ self parser codeblockMarkup 
]
