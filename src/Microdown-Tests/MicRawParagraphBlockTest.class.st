Class {
	#name : 'MicRawParagraphBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Extensions',
	#package : 'Microdown-Tests',
	#tag : 'Extensions'
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
MicRawParagraphBlockTest >> testRawParagraphCanBeNested [
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
	self assert: children first children size equals: 2. 
	self assert: children first children first class equals: MicParagraphBlock.
	self assert: children first children second label  equals: 'button'.
	self assert: children first children second class  equals: MicRawParagraphBlock.
]

{ #category : 'tests' }
MicRawParagraphBlockTest >> testRawParagraphForP [
	| children |
	children := (parser parse: '<p> 
No idea what it is :)
</p>') children.
	self assert: children size equals: 1. 
	self assert: children first class equals: MicRawParagraphBlock. 
	self assert: children first label equals: 'p'.
	
]

{ #category : 'tests' }
MicRawParagraphBlockTest >> testRawParagraphForPNoSpace [
	| children |
	children := (parser parse: '<p>WeDoNotLikeSpace
No idea what it is :)
</p>') children.
	self assert: children size equals: 1. 
	self assert: children first class equals: MicRawParagraphBlock. 
	self assert: children first label equals: 'p'.
	
]

{ #category : 'tests' }
MicRawParagraphBlockTest >> testRawParagraphForPNoSpace2 [
	| children newLine |
	newLine := Character cr asString. 
	children := (MicrodownParser new parse: '<div style="background-color:#8ebf42">', newLine, 
'<p>', newLine, 
'We use the &lt;div&gt; tag to group two paragraphs for applying a background to the text, and to add color to this', newLine, 
'<span style="color:#1c87c9">', newLine, 
'word', newLine, 
'</span>', newLine,
'we place it within &lt;span&gt; tag.', 
'</p>', newLine, 
'<p>', newLine,  
'Pay attention, that the &lt;div&gt; tag is a block-level element, so a line break is placed before and after it.', newLine, 
'</p>', newLine, 
'</div>') children.
	self assert: children size equals: 1. 
	self assert: children first class equals: MicRawParagraphBlock. 
	self assert: children first label equals: 'div'.
	self assert: children first children first class equals: MicRawParagraphBlock.
	self assert: children first children first label equals: 'p'.
	
	
]

{ #category : 'tests' }
MicRawParagraphBlockTest >> testRawParagraphForPNoSpaceAndAttributes [
	| children |
	children := (parser parse: '<p src=78>WeDoNotLikeSpace
No idea what it is :)
</p>') children.
	self assert: children size equals: 1. 
	self assert: children first class equals: MicRawParagraphBlock. 
	self assert: children first label equals: 'p'.
	
]

{ #category : 'tests' }
MicRawParagraphBlockTest >> testThereIsNoValidationIfThetagStartWithAKnowHtml [
	"for the moment we only check the first couple of characters to start with.
	So it may happens that we match the beginning of a tag."
	| mic |
	mic := (parser parse: '<titleunkniw> 
No idea what it is :)
</titleunkniw>') children first.
	self assert: mic class equals: MicParagraphBlock. 
	
]
