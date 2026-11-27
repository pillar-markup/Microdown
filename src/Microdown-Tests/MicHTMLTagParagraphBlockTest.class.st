Class {
	#name : 'MicHTMLTagParagraphBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Extensions',
	#package : 'Microdown-Tests',
	#tag : 'Extensions'
}

{ #category : 'tests' }
MicHTMLTagParagraphBlockTest >> subjectClass [ 
	^ MicHTMLTagParagraphBlock 
]

{ #category : 'tests' }
MicHTMLTagParagraphBlockTest >> testASimpleDivWithClass [
	| mic |
	mic := (parser parse: '<div class="teaser">

# Contributing to Pharo

In a giving mood? There are many ways to get involved!

</div>
') children first.
	self assert: mic class equals: MicHTMLTagParagraphBlock. 
	self assert: mic label equals: 'div'.
	self assert: mic children first class equals: MicHeaderBlock.
	self assert: mic children second class equals: MicParagraphBlock

]

{ #category : 'tests' }
MicHTMLTagParagraphBlockTest >> testASimpleRawParagraph [
	| mic |
	mic := (parser parse: '<title> 
No idea what it is :)
</title>') children first.
	self assert: mic class equals: MicHTMLTagParagraphBlock. 
	self assert: mic label equals: 'title'.
	self assert: mic children first class equals: MicParagraphBlock 

]

{ #category : 'tests' }
MicHTMLTagParagraphBlockTest >> testNotASimpleRawParagraphBecauseNotDeclaredTag [

	| mic |
	mic := (parser parse: '<toto> 
No idea what it is :)
</toto>') children first.
	self assert: mic class equals: MicParagraphBlock. 
	
]

{ #category : 'tests' }
MicHTMLTagParagraphBlockTest >> testNotASimpleRawParagraphNoSpaceInFrontToClose [

	| children |
	children := (parser parse: '<title> 
No idea what it is :)
       </title>

And after we get a paragraph') children.
	self assert: children size equals: 1. 
	"so far we eat as much as we can and put everything in the raw"
	
	
	self assert: children first class equals: MicHTMLTagParagraphBlock. 
	
]

{ #category : 'tests' }
MicHTMLTagParagraphBlockTest >> testParagrapWithP [
	| mic |
	mic := (parser parse: '
<p>
This is a paragraph started normally with <p>
</p>
') children first.
	self assert: mic class equals: MicHTMLTagParagraphBlock. 
	self assert: mic label equals: 'p'.
	self assert: mic children first class equals: MicParagraphBlock

]

{ #category : 'tests' }
MicHTMLTagParagraphBlockTest >> testRawParagraphCanBeNested [
	| children |
	children := (parser parse: '<title> 
No idea what it is :)

<button>
hkhkjhkj
</button>
</title>') children.
	self assert: children size equals: 1. 
	self assert: children first class equals: MicHTMLTagParagraphBlock. 
	self assert: children first label equals: 'title'.
	self assert: children first children size equals: 2. 
	self assert: children first children first class equals: MicParagraphBlock.
	self assert: children first children second label  equals: 'button'.
	self assert: children first children second class  equals: MicHTMLTagParagraphBlock.
]

{ #category : 'tests' }
MicHTMLTagParagraphBlockTest >> testRawParagraphForP [
	| children |
	children := (parser parse: '<p> 
No idea what it is :)
</p>') children.
	self assert: children size equals: 1. 
	self assert: children first class equals: MicHTMLTagParagraphBlock. 
	self assert: children first label equals: 'p'.
	
]

{ #category : 'tests' }
MicHTMLTagParagraphBlockTest >> testRawParagraphForPNoSpace [
	| children |
	children := (parser parse: '<p>WeDoNotLikeSpace
No idea what it is :)
</p>') children.
	self assert: children size equals: 1. 
	self assert: children first class equals: MicHTMLTagParagraphBlock. 
	self assert: children first label equals: 'p'.
	
]

{ #category : 'tests' }
MicHTMLTagParagraphBlockTest >> testRawParagraphForPNoSpace2 [
	| children newLine |
	newLine := Character cr asString. 
	children := (MicParser new parse: '<div style="background-color:#8ebf42">', newLine, 
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
	self assert: children first class equals: MicHTMLTagParagraphBlock. 
	self assert: children first label equals: 'div'.
	self assert: children first children first class equals: MicHTMLTagParagraphBlock.
	self assert: children first children first label equals: 'p'.
	
	
]

{ #category : 'tests' }
MicHTMLTagParagraphBlockTest >> testRawParagraphForPNoSpaceAndAttributes [
	| children |
	children := (parser parse: '<p src=78>WeDoNotLikeSpace
No idea what it is :)
</p>') children.
	self assert: children size equals: 1. 
	self assert: children first class equals: MicHTMLTagParagraphBlock. 
	self assert: children first label equals: 'p'.
	
]

{ #category : 'tests' }
MicHTMLTagParagraphBlockTest >> testThereIsNoValidationIfThetagStartWithAKnowHtml [
	"for the moment we only check the first couple of characters to start with.
	So it may happens that we match the beginning of a tag."
	| mic |
	mic := (parser parse: '<titleunkniw> 
No idea what it is :)
</titleunkniw>') children first.
	self assert: mic class equals: MicParagraphBlock. 
	
]
