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
		'arguments',
		'firstTag'
	],
	#category : #'Microdown-Model'
}

{ #category : #accessing }
MicCodeBlock >> arguments [
	^ arguments
]

{ #category : #accessing }
MicCodeBlock >> arguments: aString [
	arguments := aString
]

{ #category : #'as yet unclassified' }
MicCodeBlock >> asPillar [
	self flag: #fixme. "missing arguments"
	
	^ PRCodeblock new
		language: self firstTag;
		text: self code;
		yourself
]

{ #category : #accessing }
MicCodeBlock >> code [
	^ self body
]

{ #category : #public }
MicCodeBlock >> contents [ 
	^super contents , '[ ', self code, ' ]'
]

{ #category : #handle }
MicCodeBlock >> extractFirstLineFrom: aLine [

	| lineWithoutMarkup lineStream |
	lineWithoutMarkup := super extractFirstLineFrom: aLine.
	lineStream := lineWithoutMarkup readStream.
	firstTag := (lineStream upTo: $=) asSymbol.
	lineStream := lineWithoutMarkup readStream.
	arguments := ZnResourceMetaUtils parseQueryFrom: lineStream.
	^ lineWithoutMarkup
]

{ #category : #accessing }
MicCodeBlock >> firstTag [
	^ firstTag
]

{ #category : #utils }
MicCodeBlock >> lineStartMarkup [
	"a code block is delimited by ``` "
	
	^ self parser codeblockMarkup 
]
