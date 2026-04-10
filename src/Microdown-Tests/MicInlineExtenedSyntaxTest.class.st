Class {
	#name : 'MicInlineExtenedSyntaxTest',
	#superclass : 'TestCase',
	#category : 'Microdown-Tests-InlineParser',
	#package : 'Microdown-Tests',
	#tag : 'InlineParser'
}

{ #category : 'tests' }
MicInlineExtenedSyntaxTest >> testBoldAndItalicAlternatives [
	"MicInlineAlternativesDelimiter should add `__` as a bold delimiter and `*` as an italic delimiter"

	| doc |
	doc := MicInlineParser parse: '__aaaa__bbbb*cccc*'.
	self
		assert: doc first class equals: MicBoldFormatBlock;
		assert: doc first children first bodyString equals: 'aaaa'.
	self
		assert: doc third class equals: MicItalicFormatBlock;
		assert: doc third children first bodyString equals: 'cccc'
]

{ #category : 'tests' }
MicInlineExtenedSyntaxTest >> testInlineHttp [
	"MicInlineHttpDelimiter recognizes `http://somewhere.org` as a link (and generates a link)"

	| doc |
	doc := MicInlineParser parse: 'http://somewhere.org'.
	self
		assert: doc first class equals: MicLinkBlock;
		assert: doc first children first bodyString
		equals: 'http://somewhere.org';
		assert: doc first url equals: 'http://somewhere.org'.
	"Also https"
	doc := MicInlineParser parse: 'https://somewhere.org'.
	self
		assert: doc first class equals: MicLinkBlock;
		assert: doc first children first bodyString
		equals: 'https://somewhere.org';
		assert: doc first url equals: 'https://somewhere.org'
]

{ #category : 'tests' }
MicInlineExtenedSyntaxTest >> testInlineHttp_Newline [
	"The closer of inline http is a blank (or tab, newline, etc)"

	| bold |
	bold := (MicInlineParser parse: '**http://somewhere.org
**') first children.
	self
		assert: bold first class equals: MicLinkBlock;
		assert: bold first children first bodyString
		equals: 'http://somewhere.org';
		assert: bold first url equals: 'http://somewhere.org';
		assert: bold second bodyString equals: String cr
]

{ #category : 'tests' }
MicInlineExtenedSyntaxTest >> testInlineHttp_inBold [
	"The closer of inline http is a blank (or tab, newline, etc)"

	| bold |
	bold := (MicInlineParser parse: '**http://somewhere.org **') first
		        children.
	self
		assert: bold first class equals: MicLinkBlock;
		assert: bold first children first bodyString
		equals: 'http://somewhere.org';
		assert: bold first url equals: 'http://somewhere.org';
		assert: bold second bodyString equals: ' '
]

{ #category : 'tests' }
MicInlineExtenedSyntaxTest >> testInlineHttp_inContext [
	"The closer of inline http is a blank (or tab, newline, etc)"

	| doc |
	doc := MicInlineParser parse: 'aa http://somewhere.org bb'.
	self
		assert: doc second class equals: MicLinkBlock;
		assert: doc second children first bodyString
		equals: 'http://somewhere.org';
		assert: doc second url equals: 'http://somewhere.org'
]

{ #category : 'tests' }
MicInlineExtenedSyntaxTest >> testInlineHttp_inItalic [
	"The closer of inline http is a blank (or tab, newline, etc)"

	| bold |
	bold := (MicInlineParser parse: '_http://some_where.org _') first
		        children.
	self
		assert: bold first class equals: MicLinkBlock;
		assert: bold first children first bodyString
		equals: 'http://some_where.org';
		assert: bold first url equals: 'http://some_where.org';
		assert: bold second bodyString equals: ' '
]

{ #category : 'tests' }
MicInlineExtenedSyntaxTest >> testInlineHttp_tab [
	"The closer of inline http is a blank (or tab, newline, etc)"

	| bold |
	bold := (MicInlineParser parse:
		         '**http://somewhere.org' , String tab , '**') first
		        children.
	self
		assert: bold first class equals: MicLinkBlock;
		assert: bold first children first bodyString
		equals: 'http://somewhere.org';
		assert: bold first url equals: 'http://somewhere.org';
		assert: bold second bodyString equals: String tab
]

{ #category : 'tests' }
MicInlineExtenedSyntaxTest >> testInlineHttp_tabAndNewline [
	"The closer of inline http is a blank (or tab, newline, etc)"

	| doc |
	doc := MicInlineParser parse: 'http://somewhere.org'.
	self
		assert: doc first class equals: MicLinkBlock;
		assert: doc first children first bodyString
		equals: 'http://somewhere.org';
		assert: doc first url equals: 'http://somewhere.org'.
	"Also https"
	doc := MicInlineParser parse: 'https://somewhere.org'.
	self
		assert: doc first class equals: MicLinkBlock;
		assert: doc first children first bodyString
		equals: 'https://somewhere.org';
		assert: doc first url equals: 'https://somewhere.org'
]
