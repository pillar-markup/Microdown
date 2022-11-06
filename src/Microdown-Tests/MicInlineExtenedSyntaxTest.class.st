Class {
	#name : #MicInlineExtenedSyntaxTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-InlineParser'
}

{ #category : #tests }
MicInlineExtenedSyntaxTest >> testBoldAndItalicAlternatives [
	"MicInlineAlternativesDelimiter should add `__` as a bold delimiter and `*` as an italic delimiter"
	| doc |
	doc :=MicInlineParser parse: '__aaaa__bbbb*cccc*'.
	self 
		assert: doc first class equals: MicBoldFormatBlock;
		assert: doc first children first bodystring equals: 'aaaa'.
	self
		assert: doc third class equals: MicItalicFormatBlock;
		assert: doc third children first bodystring equals: 'cccc'
]

{ #category : #tests }
MicInlineExtenedSyntaxTest >> testInlineHttp [
	"MicInlineHttpDelimiter recognizes `http://somewhere.org` as a link (and generates a link)"
	| doc |
	doc :=MicInlineParser parse: 'http://somewhere.org'.
	self 
		assert: doc first class equals: MicLinkBlock;
		assert: doc first children first bodystring equals: 'http://somewhere.org';
		assert: doc first url equals: 'http://somewhere.org'.
	"Also https"
	doc :=MicInlineParser parse: 'https://somewhere.org'.
	self 
		assert: doc first class equals: MicLinkBlock;
		assert: doc first children first bodystring equals: 'https://somewhere.org';
		assert: doc first url equals: 'https://somewhere.org'.
	
]
