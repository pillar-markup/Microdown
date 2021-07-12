Class {
	#name : #MicScriptLineNumber,
	#superclass : #MicrodownVisitor,
	#instVars : [
		'stream',
		'configuration'
	],
	#category : #'Microdown - NewVisitor'
}

{ #category : #adding }
MicScriptLineNumber >> add: aString untilNewLineAt: firstOccurence withNumber: number [

	| length |
	length := firstOccurence + self configuration newLine size -1.
	self add: (aString first: length) withNumber: number.
	^ aString allButFirst: length
]

{ #category : #adding }
MicScriptLineNumber >> add: aString withNumber: number [

	stream
		<< number asString;
		tab;
		<< aString
]

{ #category : #adding }
MicScriptLineNumber >> addLineNumberTo: aCodeblock [
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
MicScriptLineNumber >> configuration [
	^ configuration
]

{ #category : #accessing }
MicScriptLineNumber >> configuration: aConfiguration [
	configuration := aConfiguration
]

{ #category : #testing }
MicScriptLineNumber >> hasLineNumber: aCodeblock [
	^ aCodeblock arguments 
			at: 'lineNumber' 
			ifPresent: [ :lN | lN = 'true' or: [ lN ] ] ifAbsent: [ false ]
]

{ #category : #initialization }
MicScriptLineNumber >> initialize [
	super initialize.
	stream := MicOutputStream on: (String new writeStream). 
]

{ #category : #'visiting-document' }
MicScriptLineNumber >> visitCode: aCodeblock [
	(self hasLineNumber: aCodeblock)
		ifTrue: [ self addLineNumberTo: aCodeblock ]
]
