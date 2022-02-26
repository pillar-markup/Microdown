Class {
	#name : #MicHTMLTag,
	#superclass : #MicHTMLBrush,
	#category : #'Microdown-HTMLExporter'
}

{ #category : #accessing }
MicHTMLTag >> addArguments: aMicFigureBlock [ 
	"Add arguments to the receiver's parameters if present"

	aMicFigureBlock hasArguments
		ifTrue: [ 
			aMicFigureBlock 
				argumentAt: 'label' ifPresent: [ : labelString | self parameterAt: 'class' put: labelString ];
				argumentAt: 'size' ifPresent: [ : labelString | self parameterAt: 'width' put: labelString ] ]

]

{ #category : #accessing }
MicHTMLTag >> contents [
	"Answer a <String> with receiver's output without modifying the stream position"
	
	^ stream contents
]

{ #category : #accessing }
MicHTMLTag >> parameterAt: aString put: anotherString [

	stream 
		space;
		<< aString;
		<< '="';
		<< anotherString;
		<< '"'
]

{ #category : #printing }
MicHTMLTag >> printOn: aStream [

	super printOn: aStream.
	aStream << ' name: ['.
	name
		ifNotNil: [ aStream << name ].
	aStream << '] contents: ('.
	stream
		ifNotNil: [ aStream << stream contents ].
	aStream
		<< ')'
]

{ #category : #accessing }
MicHTMLTag >> with: aString [
	stream 
		nextPut: $>; 
		<< aString;
		<< '</'; 
		<< name;
		nextPut: $>
]
