"
I check that `MicHeaderIdentifier` gives anchored headers the label of their anchor and no id, gives the other headers ids made from their text, and keeps the generated ids unique and different from the anchor labels of the document.
"
Class {
	#name : 'MicHeaderIdentifierTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'helpers' }
MicHeaderIdentifierTest >> identified: aString [
	"Answer the document of the Microdown text aString, with its headers identified."

	| document |
	document := Microdown parse: aString.
	MicHeaderIdentifier new identify: document.
	^ document
]

{ #category : 'helpers' }
MicHeaderIdentifierTest >> targetsOf: aDocument [
	"Answer the link targets of the headers at the top of aDocument."

	^ (aDocument children select: [ :each | each isHeader ])
		  collect: [ :each | MicHeaderIdentifier targetOf: each ]
		  as: Array
]

{ #category : 'tests - anchored headers' }
MicHeaderIdentifierTest >> testAnchorAfterAParagraphDoesNotAnchorTheHeader [

	| header |
	header := (self identified: '## Chatoto

Some text.

@other') children first.

	self assert: (header propertyAt: #id) equals: 'chatoto'
]

{ #category : 'tests - generated ids' }
MicHeaderIdentifierTest >> testGeneratedIdAvoidsAnAnchorDefinedAfterTheHeader [

	self
		assert: (self targetsOf: (self identified: '## Intro

Text.

## Other

Text.

@intro'))
		equals: #( 'intro-2' 'other' )
]

{ #category : 'tests - generated ids' }
MicHeaderIdentifierTest >> testGeneratedIdAvoidsTheAnchorOfACode [

	self
		assert: (self targetsOf: (self identified: '## Intro

```anchor=intro
foo
```'))
		equals: #( 'intro-2' )
]

{ #category : 'tests - generated ids' }
MicHeaderIdentifierTest >> testGeneratedIdAvoidsTheAnchorOfAFigure [

	self
		assert: (self targetsOf: (self identified: '## Intro

![A caption.%anchor=intro](figures/x.png)'))
		equals: #( 'intro-2' )
]

{ #category : 'tests - generated ids' }
MicHeaderIdentifierTest >> testGeneratedIdAvoidsTheAnchorOfAMath [

	self
		assert: (self targetsOf: (self identified: '## Intro

$$ %anchor=intro
x
$$'))
		equals: #( 'intro-2' )
]

{ #category : 'tests - generated ids' }
MicHeaderIdentifierTest >> testGeneratedIdAvoidsTheLabelOfAnAnchor [

	self
		assert: (self targetsOf: (self identified: '## Conclusion

Some text.

@conclusion'))
		equals: #( 'conclusion-2' )
]

{ #category : 'tests - anchored headers' }
MicHeaderIdentifierTest >> testHeaderFollowedByAnAnchorGetsNoId [

	| header |
	header := (self identified: '## Chatoto
@chatoto') children first.

	self deny: (header hasProperty: #id)
]

{ #category : 'tests - anchored headers' }
MicHeaderIdentifierTest >> testHeaderFollowedByAnAnchorTargetsItsLabel [

	self
		assert: (self targetsOf: (self identified: '## Chatoto
@chatoto'))
		equals: #( 'chatoto' )
]

{ #category : 'tests - generated ids' }
MicHeaderIdentifierTest >> testHeaderGetsAnIdMadeFromItsText [

	| header |
	header := (self identified: '## Text emphasis') children first.

	self assert: (header propertyAt: #id) equals: 'text-emphasis'.
	self
		assert: (MicHeaderIdentifier targetOf: header)
		equals: 'text-emphasis'
]

{ #category : 'tests - generated ids' }
MicHeaderIdentifierTest >> testHeadersWithTheSameTextGetDifferentIds [

	self
		assert: (self targetsOf: (self identified: '## Intro

## Intro'))
		equals: #( 'intro' 'intro-2' )
]

{ #category : 'tests - ids' }
MicHeaderIdentifierTest >> testIdFromTextKeepsOnlyLowercaseWords [

	self
		assert:
		(MicHeaderIdentifier new idFromText: 'Text emphasis & `code`!')
		equals: 'text-emphasis-code'
]

{ #category : 'tests - ids' }
MicHeaderIdentifierTest >> testIdFromTextWithoutWordsIsSection [

	self
		assert: (MicHeaderIdentifier new idFromText: '***')
		equals: 'section'
]

{ #category : 'tests - ids' }
MicHeaderIdentifierTest >> testUniqueIdKeepsAFreeId [

	self
		assert: (MicHeaderIdentifier new uniqueId: 'intro' in: Set new)
		equals: 'intro'
]

{ #category : 'tests - ids' }
MicHeaderIdentifierTest >> testUniqueIdNumbersAnIdAlreadyTaken [

	| ids |
	ids := Set with: 'intro' with: 'intro-2'.

	self
		assert: (MicHeaderIdentifier new uniqueId: 'intro' in: ids)
		equals: 'intro-3'.
	self assert: (ids includes: 'intro-3')
]

{ #category : 'tests - anchored headers' }
MicHeaderIdentifierTest >> testWrittenAnchoredHeaderHasASingleId [

	| html |
	html := MicHTMLVisitor new
		        visit: (self identified: '## Chatoto
@chatoto');
		        contents.

	self
		assert: (html allRangesOfSubstring: 'id="chatoto"') size
		equals: 1
]
