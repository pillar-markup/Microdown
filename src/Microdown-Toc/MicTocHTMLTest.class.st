Class {
	#name : 'MicTocHTMLTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Toc',
	#package : 'Microdown-Toc'
}

{ #category : 'tests' }
MicTocHTMLTest >> builder [

	| doc builder |
	doc := Microdown parse: '
# Header1

lkjlkjkl

# Header2 

lkhkhk
'.
	builder := MicTocBuilder new.
	builder visit: doc.
	^ builder 

]

{ #category : 'tests' }
MicTocHTMLTest >> testHTMLRender [


	| builder htmlVisitor |
	builder := self builder. 
	htmlVisitor := MicHTMLVisitor new.
	htmlVisitor visit: (MicRootBlock new children: builder tocItems).
	self halt.
]
