Class {
	#name : #MicCodeblockLineNumberer,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'stream',
		'configuration'
	],
	#category : #'Microdown-RenderingFeatures'
}

{ #category : #adding }
MicCodeblockLineNumberer >> add: aString untilNewLineAt: firstOccurence withNumber: number [

	| length |
	length := firstOccurence + self configuration newLine size -1.
	self add: (aString first: length) withNumber: number.
	^ aString allButFirst: length
]

{ #category : #adding }
MicCodeblockLineNumberer >> add: aString withNumber: number [

	stream
		<< number asString;
		tab;
		<< aString
]

{ #category : #adding }
MicCodeblockLineNumberer >> addLineNumberTo: aCodeblock [
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
MicCodeblockLineNumberer >> configuration [
	^ configuration
]

{ #category : #accessing }
MicCodeblockLineNumberer >> configuration: aConfiguration [
	configuration := aConfiguration
]

{ #category : #testing }
MicCodeblockLineNumberer >> hasLineNumber: aCodeblock [
	^ aCodeblock arguments 
			at: 'lineNumber' 
			ifPresent: [ :lN | lN = 'true' or: [ lN ] ] ifAbsent: [ false ]
]

{ #category : #initialization }
MicCodeblockLineNumberer >> initialize [
	super initialize.
	stream := MicOutputStream on: (String new writeStream). 
]

{ #category : #'visiting-document' }
MicCodeblockLineNumberer >> visitCode: aCodeblock [
	(self hasLineNumber: aCodeblock)
		ifTrue: [ self addLineNumberTo: aCodeblock ]
]
