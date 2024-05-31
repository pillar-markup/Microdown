"
I am a header. I'm composed of a number of sharp sign (1 to 6) followed by a space (obligatory) and a text on one line. 

For example 

```
# level 1
## level 2
### level 3
#### level 4
##### level 5
###### level 6
```

produces

# level 1
## level 2
### level 3
#### level 4
##### level 5
###### level 6

"
Class {
	#name : 'MicHeaderBlock',
	#superclass : 'MicSingleLineBlock',
	#instVars : [
		'level'
	],
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'visiting' }
MicHeaderBlock >> accept: aVisitor [ 
 	^ aVisitor visitHeader: self
]

{ #category : 'public' }
MicHeaderBlock >> addLineAndReturnNextNode: line [
	"Line is on the form '#### my heading at forth level'"
	self level: ('(#+)' asRegex
		matchesPrefix: line;
		subexpression: 1) size.
	children := self inlineParse: (line copyFrom: level + 1 to: line size) trim.
	^ self
]

{ #category : 'accessing' }
MicHeaderBlock >> formattedCode [ 
	^super formattedCode , '[ ', self level printString, '/', self header, ' ]'
]

{ #category : 'accessing' }
MicHeaderBlock >> header [
	"I am used to get an adhoc string for the header"

	^ String streamContents: [ :s |
		  children do: [ :e | s nextPutAll: e bodyString ] ]
]

{ #category : 'accessing' }
MicHeaderBlock >> headerElements [
	
	^ self children
	
]

{ #category : 'accessing' }
MicHeaderBlock >> headerElements: aCollection [
	
	children := aCollection
	
]

{ #category : 'accessing' }
MicHeaderBlock >> level [
	^ level
]

{ #category : 'accessing' }
MicHeaderBlock >> level: anInteger [
	"(anInteger between: 1 and: 6) ifFalse: [ MicParsingError signal: 'header levels must be between 1 and 6' ]."
	level := anInteger beBetween: 1 and: 6
	



]
