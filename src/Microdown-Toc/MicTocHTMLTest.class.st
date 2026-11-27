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
	"Please have a look at the MicAbstractLaTexWriterTest"

	| builder htmlVisitor |
	builder := self builder. 
	htmlVisitor := MicHTMLVisitor new.
	htmlVisitor visit: builder toc.

	self 
		assert: htmlVisitor contents 
		equals: String crlf, '<ol>', String crlf,
'<li>Header1</li>', String crlf,
'<li>Header2</li>', String crlf,
'</ol>'

]

{ #category : 'tests' }
MicTocHTMLTest >> testHTMLRenderSimpleNesting [

	| doc builder htmlVisitor |
	doc := Microdown parse: '
# Header1
## Header11
'.
	builder := MicTocBuilder new.
	builder visit: doc.
	self assert: builder toc children first children isNotEmpty.

	htmlVisitor := MicHTMLVisitor new.
	htmlVisitor visit: builder toc.
	self
		assert: htmlVisitor contents
		equals:
			String crlf , '<ol>' , String crlf , '<li>Header1' , String crlf
			, '<ol>' , String crlf , '<li>Header11</li>' , String crlf
			, '</ol>' , '</li>' , String crlf , '</ol>'
]
