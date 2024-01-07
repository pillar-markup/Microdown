Class {
	#name : #MicLinkBlockTest,
	#superclass : #MicBlockTest,
	#instVars : [
		'splitterClass',
		'link'
	],
	#category : #'Microdown-Tests-Parser'
}

{ #category : #functions }
MicLinkBlockTest >> linkBoldSample [

	^ '
[**Foo**](/anUrl)
'
]

{ #category : #functions }
MicLinkBlockTest >> linkItalicSample [

	^ '
[_Foo_](/anUrl)
'
]

{ #category : #functions }
MicLinkBlockTest >> linkMonospaceSample [

	^ '
[`Foo`](/anUrl)
'
]

{ #category : #functions }
MicLinkBlockTest >> linkNestedSample [

	^ '
[**_Foo_**](/anUrl)
'
]

{ #category : #functions }
MicLinkBlockTest >> linkSample [
	^ '
[Foo](/anUrl)
'
]

{ #category : #functions }
MicLinkBlockTest >> linkStrikeSample [

	^ '
[~Foo~](/anUrl)
'
]

{ #category : #'tests - link' }
MicLinkBlockTest >> parseLink: aString [
	"Parse aString containing Microdown link to a MicLinkBlock"

	^ (self parser parse: aString) children first children first.
]

{ #category : #running }
MicLinkBlockTest >> setUp [

	super setUp.
	parser := self parser. 
	splitterClass := MicInlineParser
]

{ #category : #tests }
MicLinkBlockTest >> subjectClass [ 
	^ MicHorizontalLineBlock
]

{ #category : #tests }
MicLinkBlockTest >> testFullName [

	link := self parseLink: self linkSample.
	self assert: link reference fullName equals: '/anUrl'

]

{ #category : #tests }
MicLinkBlockTest >> testHasArguments [
	| figure |
	figure := (splitterClass new parse: '[caption with space and dot...](https://github.com/pillar-markup/Microdown/runs/4336482137?check_suite_focus=true  width=80&anchor=bla)') first.
	
	"Indeed url arguments are not microdown arguments"
	self assert: figure hasArguments.
	
	
]

{ #category : #'tests - link' }
MicLinkBlockTest >> testLinkAPIToAccessText [

	link := self parseLink: self linkSample.
	self assert: link class equals: MicLinkBlock.
	self assert: link url equals: '/anUrl'
]

{ #category : #'tests - link' }
MicLinkBlockTest >> testLinkBoldAPIToAccessText [

	link := self parseLink: self linkBoldSample.
	self assert: link class equals: MicLinkBlock.
	self assert: link children first class equals: MicBoldFormatBlock.
	self assert: link children first children first class equals: MicTextBlock.

	self assert: link url equals: '/anUrl'
]

{ #category : #'tests - link' }
MicLinkBlockTest >> testLinkCreatesInnerText [

	link := self parseLink: '[ab](https://ab.com)'.
	self assert: link class equals: MicLinkBlock.
	self assert: link url equals: 'https://ab.com'
]

{ #category : #'tests - link' }
MicLinkBlockTest >> testLinkItalicAPIToAccessText [

	link := self parseLink: self linkItalicSample.
	self assert: link class equals: MicLinkBlock.
	self assert: link children first class equals: MicItalicFormatBlock.
	self
		assert: link children first children first class
		equals: MicTextBlock.

	self assert: link url equals: '/anUrl'
]

{ #category : #tests }
MicLinkBlockTest >> testPrintOn [

	link := (splitterClass new parse: '[caption](http://www.pharo.org)') first.
	self assert: link asString equals: 'Link{ Text(caption) }(http://www.pharo.org)'
]

{ #category : #tests }
MicLinkBlockTest >> testUrl [

	link := (splitterClass new parse: '[caption](http://www.pharo.org:8080)') first.
	self assert: link url equals: 'http://www.pharo.org:8080'
]
