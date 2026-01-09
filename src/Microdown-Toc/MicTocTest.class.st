Class {
	#name : 'MicTocTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'tests' }
MicTocTest >> testAlternatingheaderLevels [

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
MicTocTest >> testComplexDeeplyNestedEntries [

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
MicTocTest >> testLimitDepthToLevelOne [

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
MicTocTest >> testMalformedHeaderOrder [

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
MicTocTest >> testSimpleDeeplyNestedEntries [

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
MicTocTest >> testSimpleFlatEntries [


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
MicTocTest >> testSimpleNestedEntries [


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

{ #category : 'tests' }
MicTocTest >> testTopLevelHeaderWithTwoSecondLevelHeaders [

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
