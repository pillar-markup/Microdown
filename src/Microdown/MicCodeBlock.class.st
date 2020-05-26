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
	#name : #MicCodeBlock,
	#superclass : #MicSameStartStopMarkupBlock,
	#instVars : [
		'arguments'
	],
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicCodeBlock >> arguments [
	^ firstLine
]

{ #category : #accessing }
MicCodeBlock >> arguments: aString [
	firstLine := aString
]

{ #category : #accessing }
MicCodeBlock >> code [
	^ self body
]

{ #category : #public }
MicCodeBlock >> contents [ 
	^super contents , '[ ', self code, ' ]'
]

{ #category : #utils }
MicCodeBlock >> lineStartMarkup [
	"a code block is delimited by ``` "
	
	^ self parser codeblockMarkup 
]
