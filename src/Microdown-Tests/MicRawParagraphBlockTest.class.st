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

{ #category : 'tests' }
MicRawParagraphBlockTest >> testNotASimpleRawParagraphBecauseNotDeclaredTag [

	| mic |
	mic := (parser parse: '<toto> 
No idea what it is :)
</toto>') children first.
	self assert: mic class equals: MicParagraphBlock. 
	
]

{ #category : 'tests' }
MicRawParagraphBlockTest >> testNotASimpleRawParagraphNoSpaceInFrontToClose [

	| children |
	children := (parser parse: '<title> 
No idea what it is :)
       </title>

And after we get a paragraph') children.
	self assert: children size equals: 1. 
	"so far we eat as much as we can and put everything in the raw"
	
	
	self assert: children first class equals: MicRawParagraphBlock. 
	
]

{ #category : 'tests' }
MicRawParagraphBlockTest >> testRawParagraphCannotBeNested [
	| children |
	children := (parser parse: '<title> 
No idea what it is :)

<button>
hkhkjhkj
</button>
</title>') children.
	self assert: children size equals: 1. 
	self assert: children first class equals: MicRawParagraphBlock. 
	self assert: children first label equals: 'title'.
	self assertEmpty: children first children
]

{ #category : 'tests' }
MicRawParagraphBlockTest >> testThereIsNoValidationIfThetagStartWithAKnowHtml [
	"for the moment we only check the first couple of characters to start with.
	So it may happens that we match the beginning of a tag."
	| mic |
	mic := (parser parse: '<titleunkniw> 
No idea what it is :)
</titleunkniw>') children first.
	self assert: mic class equals: MicRawParagraphBlock. 
	
]
