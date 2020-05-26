Class {
	#name : #GHMParserTest,
	#superclass : #GHMBlockTest,
	#category : #'Microdown-Tests'
}

{ #category : #tests }
GHMParserTest >> testEmpty [
	| source root |
	source := ''.
	root := parser parse: source.
	self assert: root children size equals: 0.

]

{ #category : #tests }
GHMParserTest >> testEmptyOnMultipleLines [
	| source root |
	source := '


'.
	root := parser parse: source.
	self assert: root children size equals: 0

]

{ #category : #tests }
GHMParserTest >> testIsAListDash [

	self assert: (parser isAList: '- one')
	
]

{ #category : #tests }
GHMParserTest >> testIsAListNumbered [

	self assert: (parser isAList: '11. one')
	
]

{ #category : #tests }
GHMParserTest >> testIsAListPlus [

	self assert: (parser isAList: '+ one')
	
]

{ #category : #tests }
GHMParserTest >> testIsAListStar [

	self assert: (parser isAList: '* one')
	
]

{ #category : #tests }
GHMParserTest >> testIsAListStar2 [

	self assert: (parser isAList: '  * one' trim)
	
]

{ #category : #tests }
GHMParserTest >> testOnceParsedCurrentShouldBeTheRootblock [

	| source root parser |
	source := 'This is
a paragraph on two lines'.
	parser := self parser.
	root := parser parse: source.
	self assert: parser current == root
]

{ #category : #tests }
GHMParserTest >> testParsingLogic [
	| source root parser textBody argument line code |
	parser := self parser.
	
	"ready for code factory"
	textBody := 'my fancy code
is really cool'.
	argument := 'ArgumentGoesHere'.
	source := (parser codeblockMarkup, argument, String cr, textBody, String cr, parser codeblockMarkup) readStream. 
	
	line := source nextLine.
	"First we get the root block"
	root := parser parse: ''.
	self assert: parser current equals: root.
	self assert: (root canConsumeLine: line).
	code := parser handleLine: line.
	self assert: code parent equals: root.
	self assert: code equals: parser current. 
	
	"now new line"
	parser handleLine: source nextLine.
	self deny:  code isClosed.
	parser handleLine: source nextLine.
	self deny:  code isClosed.
	self assert: code equals: parser current.
	parser handleLine: source nextLine.
	self assert: code isClosed. 
	parser handleLine: 'another line'.
	self deny: code equals: parser current. 
	
	
	
	
]
