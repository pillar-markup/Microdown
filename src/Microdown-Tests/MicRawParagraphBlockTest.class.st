Class {
	#name : 'MicRawParagraphBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests',
	#package : 'Microdown-Tests'
}

{ #category : 'tests' }
MicRawParagraphBlockTest >> subjectClass [ 
	^ MicRawParagraphBlock 
]

{ #category : 'tests' }
MicRawParagraphBlockTest >> testASimpleRawParagraph [
	| mic |
	mic := (parser parse: '<title> 
No idea what it is :)
</title>') children first.
	self assert: mic class equals: MicRawParagraphBlock. 
	self assert: mic label equals: 'title'.

]
