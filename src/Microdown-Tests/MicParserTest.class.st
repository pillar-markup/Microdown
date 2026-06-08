Class {
	#name : 'MicParserTest',
	#superclass : 'TestCase',
	#instVars : [
		'parser'
	],
	#pools : [
		'MicSharedPool'
	],
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'running' }
MicParserTest >> setUp [

	super setUp.
	parser := MicParser new. 
]

{ #category : 'tests' }
MicParserTest >> test [

	| source root |
	source := '
{
"title" : "About Pharo",
"layout" : "index",
"publishDate" : "2025-06-01"
}

# Pharo

[Pharo](http://www.pharo.org) is a beautiful dynamically-typed reflective pure object-oriented language that we have been developing since 2008.
It is inspired by Smalltalk (I''m extremely grateful to Alan Kay and Dan Ingalls - they were so visionary and right). Now our vision for Pharo is to reinvent Smalltalk and produce a better system. 
From that perspective, I''m used to say that Pharo is what we have and not what we want. 
In essence, Pharo is the beginning of the journey and not the final goal. And you can change its future.


You can check what companies are saying about it: [Video](https://youtu.be/6tdkKNX2g4s)


There are many aspects I would like to see being explored either by us or by others.
If you want to explore some of the following aspects, please go and let us know. 
I''m really interested in any topics that evolve Pharo into a better Pharo. 

'.

	root := parser parse: source.
	
	self assert: root children size equals: 5.

]

{ #category : 'tests' }
MicParserTest >> testEmpty [
	| source root |
	source := ''.
	root := parser parse: source.
	self assert: root children size equals: 0.

]

{ #category : 'tests' }
MicParserTest >> testEmptyOnMultipleLines [
	| source root |
	source := '


'.
	root := parser parse: source.
	self assert: root children size equals: 0

]

{ #category : 'tests' }
MicParserTest >> testIsAListDash [

	self assert: (parser isAList: '- one')
	
]

{ #category : 'tests' }
MicParserTest >> testIsAListNumbered [

	self assert: (parser isAList: '11. one')
	
]

{ #category : 'tests' }
MicParserTest >> testIsAListPlus [

	self assert: (parser isAList: '+ one')
	
]

{ #category : 'tests' }
MicParserTest >> testIsAListStar [

	self assert: (parser isAList: '* one')
	
]

{ #category : 'tests' }
MicParserTest >> testIsAListStar2 [

	self assert: (parser isAList: '  * one' trim)
	
]

{ #category : 'tests' }
MicParserTest >> testOnceParsedCurrentShouldBeTheRootblock [

	| source root |
	source := 'This is
a paragraph on two lines'.
	root := parser parse: source.
	self assert: parser current == root
]

{ #category : 'tests' }
MicParserTest >> testParsingLogic [
	| source root textBody argument line code |
	
	"ready for code factory"
	textBody := 'my fancy code
is really cool'.
	argument := 'ArgumentGoesHere'.
	source := (CodeblockMarkup, argument, String cr, textBody, String cr, CodeblockMarkup) readStream. 
	
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

{ #category : 'tests' }
MicParserTest >> testStartLineIsCorrectlyAssigned [

	| doc children |
	doc := Microdown parse: 'a paragraph

# Header

another paragraph'.

	children := doc children.
	
	self assert: children first startLine equals: 1.
	self assert: children second startLine equals: 3.
	self assert: children third startLine equals: 5.
]

{ #category : 'tests' }
MicParserTest >> testStartLineWithNestedAndMultilineElements [
	| doc list paragraph |
	doc := Microdown parse: '# Title

- Item A
- Item B

A long
paragraph'.
	self assert: doc children first startLine equals: 1.
	list := doc children second.
	self assert: list startLine equals: 3.
	self assert: list children first startLine equals: 3.
	self assert: list children second startLine equals: 4.
	paragraph := doc children third.
	self assert: paragraph startLine equals: 6.
]
