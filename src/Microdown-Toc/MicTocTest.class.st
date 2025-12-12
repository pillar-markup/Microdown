Class {
	#name : 'MicTocTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'tests' }
MicTocTest >> testHMLT [


	| doc builder |
	doc := Microdown parse: '
# Header1

lkjlkjkl

## Header11


lkhkhk
'.
	builder := MicHTMLVisitor  new.
	builder visit: doc.
	
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
