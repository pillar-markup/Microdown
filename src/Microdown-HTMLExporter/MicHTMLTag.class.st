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

{ #category : #tag }
MicHTMLTag >> closeTag [

	stream << '/>'
]

{ #category : #accessing }
MicHTMLTag >> name: aString [
	name := aString.
	stream nextPut: $<; << aString
]

{ #category : #accessing }
MicHTMLTag >> parameterAt: aString put: anotherString [
	stream space. stream << aString << '="' << anotherString << '"'
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
