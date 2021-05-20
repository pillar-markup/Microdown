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
	#name : #MicHeaderBlock,
	#superclass : #MicSingleLineBlock,
	#instVars : [
		'level'
	],
	#category : #'Microdown-Model'
}

{ #category : #visiting }
MicHeaderBlock >> accept: aVisitor [ 
 	^ aVisitor visitHeader: self
]

{ #category : #testing }
MicHeaderBlock >> addLineAndReturnNextNode: line [
	"Line is on the form '#### my heading at forth level'"
	level := ('(#+)' asRegex
		matchesPrefix: line;
		subexpression: 1) size.
	children := (line copyFrom: level + 1 to: line size) trim.
	^ self
]

{ #category : #public }
MicHeaderBlock >> contents [ 
	^ super contents , '[ ', self level printString, '/', self headerString, ' ]'
]

{ #category : #accessing }
MicHeaderBlock >> formattedCode [ 
	^super formattedCode , '[ ', self level printString, '/', self headerString, ' ]'
]

{ #category : #accessing }
MicHeaderBlock >> header [
	"should not be used anymore it should be children"
	
	^ self headerString
	
]

{ #category : #accessing }
MicHeaderBlock >> headerString [

	^ String streamContents: [ :s | children do: [ :e | s nextPutAll: e substring ] ]
	
]

{ #category : #accessing }
MicHeaderBlock >> level [
	^ level
]

{ #category : #printing }
MicHeaderBlock >> printOn: aStream [

	aStream nextPutAll: 'Header: '.
	aStream nextPutAll: self headerString
]
