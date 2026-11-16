"
I check that `MicTocBuilder` nests the headers of a document by level, respects its limit, and answers its table of contents as values for Mustache templates, linked to the targets that `MicHeaderIdentifier` gave the headers.
"
Class {
	#name : 'MicTocBuilderTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'helpers' }
MicTocBuilderTest >> builderOn: aString [
	"Answer a builder that collected the headers of the Microdown text aString, once identified."

	| document |
	document := Microdown parse: aString.
	MicHeaderIdentifier new identify: document.
	^ MicTocBuilder new
		  visit: document;
		  yourself
]

{ #category : 'tests' }
MicTocBuilderTest >> testAlternatingheaderLevels [

	| doc builder topLevelTocItems |
	doc := Microdown parse: '
# Header1
## Header11
# Header2
## Header21
'.
	builder := MicTocBuilder new.

	builder visit: doc.

	topLevelTocItems := builder tocItems.
	self assert: builder tocItems size equals: 2.
	self assert: topLevelTocItems first header text equals: 'Header1'.
	self
		assert: topLevelTocItems first children first header text
		equals: 'Header11'.
	self assert: topLevelTocItems second header text equals: 'Header2'.
	self
		assert: topLevelTocItems second children first header text
		equals: 'Header21'
]

{ #category : 'tests' }
MicTocBuilderTest >> testComplexDeeplyNestedEntries [

	| doc builder |
	doc := Microdown parse: '
# Header1
## Header11
### Header111
### Header112
## Header12
# Header2
## Header21
'.
	builder := MicTocBuilder new.

	builder visit: doc.

	self assert: builder tocItems size equals: 2.
	self assert: builder tocItems first header text equals: 'Header1'.
	self
		assert: builder tocItems first children first header text
		equals: 'Header11'.
	self
		assert:
		builder tocItems first children first children first header text
		equals: 'Header111'.
	self
		assert:
		builder tocItems first children first children second header text
		equals: 'Header112'.
	self assert: builder tocItems second header text equals: 'Header2'
]

{ #category : 'tests' }
MicTocBuilderTest >> testHeaderBackFromADeeperLevelKeepsItsChildren [

	| d |
	d := (self builderOn: '# A

## B

### C

## D

### E') tocItems first children second.

	self
		assert: (d children collect: [ :each | each header text ] as: Array)
		equals: #( 'E' )
]

{ #category : 'tests' }
MicTocBuilderTest >> testHeaderBackFromADeeperLevelStaysInItsParent [

	self
		assert: ((self builderOn: '# A

## B

### C

## D') tocItems first children
				 collect: [ :each | each header text ]
				 as: Array)
		equals: #( 'B' 'D' )
]

{ #category : 'tests' }
MicTocBuilderTest >> testLimitDepthToLevelOne [

	| doc builder topLevelTocItems |
	doc := Microdown parse: '
# Header1
## Header11
# Header2
## Header21
'.
	builder := MicTocBuilder new.

	builder limitUpTo: 1.
	builder visit: doc.

	topLevelTocItems := builder tocItems.
	self assert: builder tocItems size equals: 2.
	self assert: topLevelTocItems first header text equals: 'Header1'.
	self assert: topLevelTocItems first isLeaf.
	self assert: topLevelTocItems second header text equals: 'Header2'.
	self assert: topLevelTocItems second isLeaf
]

{ #category : 'tests' }
MicTocBuilderTest >> testLimitDepthWithInvalidInput [

	| builder should |
	builder := MicTocBuilder new.
	should := false.

	[ builder limitUpTo: 0 ]
		on: Error
		do: [ :ex |
				self
					assert: ex description
					equals: 'Error: Invalid input. Limit should be between 1 and 5'.
				should := true ].
	self assert: should
]

{ #category : 'tests' }
MicTocBuilderTest >> testLimitDepthWithInvalidInput0 [

	| builder should |
	builder := MicTocBuilder new.
	should := false.

	[ builder limitUpTo: 0 ]
		on: Error
		do: [ :ex |
				self
					assert: ex description
					equals: 'Error: Invalid input. Limit should be between 1 and 5'.
				should := true ].
	self assert: should
]

{ #category : 'tests' }
MicTocBuilderTest >> testLimitDepthWithInvalidInput6 [

	| builder should |
	builder := MicTocBuilder new.
	should := false.

	[ builder limitUpTo: 6 ]
		on: Error
		do: [ :ex |
				self
					assert: ex description
					equals: 'Error: Invalid input. Limit should be between 1 and 5'.
				should := true ].
	self assert: should
]

{ #category : 'tests' }
MicTocBuilderTest >> testMalformedHeaderOrder [

	| doc builder firstTocItem secondTocItem thirdTocItem |
	doc := Microdown parse: '
### Header001
## Header01
# Header1
'.
	builder := MicTocBuilder new.

	builder visit: doc.

	self assert: builder tocItems size equals: 3.
	firstTocItem := builder tocItems first.
	self assert: firstTocItem header text equals: 'Header001'.
	self assertEmpty: firstTocItem children.
	secondTocItem := builder tocItems second.
	self assert: secondTocItem header text equals: 'Header01'.
	self assertEmpty: secondTocItem children.
	thirdTocItem := builder tocItems third.
	self assert: thirdTocItem header text equals: 'Header1'.
	self assertEmpty: thirdTocItem children
]

{ #category : 'tests' }
MicTocBuilderTest >> testSimpleDeeplyNestedEntries [

	| doc builder |
	doc := Microdown parse: '
# Header1
## Header11
### Header111
#### Header1111
'.
	builder := MicTocBuilder new.
	builder visit: doc.
	self assert: builder tocItems size equals: 1.
	self assert: builder tocItems first header text equals: 'Header1'.
	self
		assert: builder tocItems first children first header text
		equals: 'Header11'.
	self
		assert:
		builder tocItems first children first children first header text
		equals: 'Header111'.
	self
		assert:
			builder tocItems first children first children first children first
				header text
		equals: 'Header1111'
]

{ #category : 'tests' }
MicTocBuilderTest >> testSimpleFlatEntries [


	| doc builder |
	doc := Microdown parse: '
# Header1

lkjlkjkl

# Header2 

lkhkhk
'.
	builder := MicTocBuilder new.
	builder visit: doc.
	self assert: builder tocItems size equals: 2.
	self assert: builder tocItems first header text equals: 'Header1'.
	self assert: builder tocItems second header text equals: 'Header2'.

]

{ #category : 'tests' }
MicTocBuilderTest >> testSimpleNestedEntries [


	| doc builder |
	doc := Microdown parse: '
# Header1

lkjlkjkl

## Header11


lkhkhk
'.
	builder := MicTocBuilder new.
	builder visit: doc.
	self assert: builder tocItems size equals: 1.
	self assert: builder tocItems first header text equals: 'Header1'.
	self assert: builder tocItems first children first header text equals: 'Header11'.

]

{ #category : 'tests - template values' }
MicTocBuilderTest >> testTemplateValuesLinkAnAnchoredHeaderToItsAnchor [

	| values |
	values := (self builderOn: '# One
@chatoto') templateValues.

	self
		assert: ((values at: 'children') first at: 'href')
		equals: '#chatoto'
]

{ #category : 'tests - template values' }
MicTocBuilderTest >> testTemplateValuesLinkEachEntryToItsHeaderId [

	| values |
	values := (self builderOn: '# One

## A') templateValues.

	self
		assert: ((values at: 'children') first at: 'href')
		equals: '#one'.
	self
		assert:
		(((values at: 'children') first at: 'children') first at: 'href')
		equals: '#a'
]

{ #category : 'tests - template values' }
MicTocBuilderTest >> testTemplateValuesNestTheHeaders [

	| values |
	values := (self builderOn: '# One

## A

## B') templateValues.

	self
		assert:
		((values at: 'children') collect: [ :each | each at: 'name' ])
		equals: #( 'One' ).
	self
		assert:
			(((values at: 'children') first at: 'children') collect: [ :each |
				 each at: 'name' ])
		equals: #( 'A' 'B' )
]

{ #category : 'tests - template values' }
MicTocBuilderTest >> testTemplateValuesOfATextWithoutHeaderHaveNoEntry [

	self assert:
		((self builderOn: 'Just text') templateValues at: 'children')
			isEmpty
]

{ #category : 'tests - template values' }
MicTocBuilderTest >> testTemplateValuesOfUnidentifiedHeadersHaveNoHref [

	| builder |
	builder := MicTocBuilder new.
	builder visit: (Microdown parse: '# One').

	self assert:
		((builder templateValues at: 'children') first at: 'href') isNil
]

{ #category : 'tests - template values' }
MicTocBuilderTest >> testTemplateValuesSayWhetherAnEntryHasChildren [

	| entries |
	entries := (self builderOn: '# One

## A

# Two') templateValues at: 'children'.

	self assert: (entries first at: 'hasChildren').
	self deny: (entries second at: 'hasChildren')
]

{ #category : 'tests - template values' }
MicTocBuilderTest >> testTemplateValuesStopAtTheLimit [

	| builder entry |
	builder := MicTocBuilder new.
	builder limitUpTo: 2.
	builder visit: (Microdown parse: '# One

## Two

### Three').

	entry := (builder templateValues at: 'children') first.
	self assert: ((entry at: 'children') first at: 'children') isEmpty
]

{ #category : 'tests' }
MicTocBuilderTest >> testTopLevelHeaderWithTwoSecondLevelHeaders [

	| doc builder topLevelTocItem |
	doc := Microdown parse: '
# Header1
## Header11
## Header12
'.
	builder := MicTocBuilder new.

	builder visit: doc.

	topLevelTocItem := builder tocItems first.
	self assert: builder tocItems size equals: 1.
	self assert: topLevelTocItem header text equals: 'Header1'.
	self
		assert: topLevelTocItem children first header text
		equals: 'Header11'.
	self
		assert: topLevelTocItem children second header text
		equals: 'Header12'
]
