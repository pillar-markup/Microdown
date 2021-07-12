Class {
	#name : #MicCodeblockLineNumber,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'stream',
		'configuration'
	],
	#category : #'Microdown - NewVisitor'
}

{ #category : #adding }
MicCodeblockLineNumber >> add: aString untilNewLineAt: firstOccurence withNumber: number [

	| length |
	length := firstOccurence + self configuration newLine size -1.
	self add: (aString first: length) withNumber: number.
	^ aString allButFirst: length
]

{ #category : #adding }
MicCodeblockLineNumber >> add: aString withNumber: number [

	stream
		<< number asString;
		tab;
		<< aString
]

{ #category : #adding }
MicCodeblockLineNumber >> addLineNumberTo: aCodeblock [
	"I add a numerotation at each line of a script."

	| text firstOccurence number |
	
	text := aCodeblock body.
	number := 1.
	firstOccurence := text indexOfSubCollection: self configuration newLine.
	[ firstOccurence = 0 ]
		whileFalse: [ 
			text := self add: text untilNewLineAt: firstOccurence withNumber: number.
			firstOccurence := text indexOfSubCollection: self configuration newLine.
			number := number + 1 ].
	self add: text withNumber: number.
	^ aCodeblock body: stream contents
]

{ #category : #accessing }
MicCodeblockLineNumber >> configuration [
	^ configuration
]

{ #category : #accessing }
MicCodeblockLineNumber >> configuration: aConfiguration [
	configuration := aConfiguration
]

{ #category : #testing }
MicCodeblockLineNumber >> hasLineNumber: aCodeblock [
	^ aCodeblock arguments 
			at: 'lineNumber' 
			ifPresent: [ :lN | lN = 'true' or: [ lN ] ] ifAbsent: [ false ]
]

{ #category : #initialization }
MicCodeblockLineNumber >> initialize [
	super initialize.
	stream := MicOutputStream on: (String new writeStream). 
]

{ #category : #'visiting-document' }
MicCodeblockLineNumber >> visitCode: aCodeblock [
	(self hasLineNumber: aCodeblock)
		ifTrue: [ self addLineNumberTo: aCodeblock ]
]
