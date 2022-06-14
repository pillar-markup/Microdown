Class {
	#name : #MicSectionModelTest,
	#superclass : #TestCase,
	#category : #'Microdown-DocumentBrowser-Tests-BlockModel'
}

{ #category : #tests }
MicSectionModelTest >> testEmpty [
	"An empty document should not break sectioning"
	| doc sec |
	doc := Microdown parse: ''.
	sec := MicSectionBlock fromRoot: doc.
	self assert: sec class equals: MicSectionBlock.
	self assert: sec header equals: nil.
	self assert: sec body children isEmpty.
	self assert: sec subsections children isEmpty
]

{ #category : #tests }
MicSectionModelTest >> testNoHeader [
	| doc sec |
	doc := Microdown parse: 'This is **just**

a few lines'.
	sec := MicSectionBlock fromRoot: doc.
	self assert: sec header equals: nil.
	self assert: sec body children size equals: 2.
	self assert: sec subsections children isEmpty
]

{ #category : #tests }
MicSectionModelTest >> testOneHeader [
	"With one header, only one section is created and become the root"
	| doc sec |
	doc := Microdown parse: 
'# Header1
This is **just**

a few lines'.
	sec := MicSectionBlock fromRoot: doc.
	self assert: sec header children first text equals: 'Header1'.
	self assert: sec body children size equals: 2.
	self assert: sec subsections children isEmpty
]

{ #category : #tests }
MicSectionModelTest >> testOneHeaderWithInitialBody [
	"With one header, but body, a level 0 section is created and become the root"
	| doc sec |
	doc := Microdown parse: 
'stuff here
# Header1
This is **just**

a few lines'.
	sec := MicSectionBlock fromRoot: doc.
	self assert: sec level equals: 0.
	self assert: sec header isNil.
	self assert: sec body children first text equals: 'stuff here'.
	self assert: sec subsections children size equals: 1
]

{ #category : #tests }
MicSectionModelTest >> testOneHeaderWithSubHeader [
	"With one top header, only one section is created and become the root, subsections as its subsections"
	| doc sec |
	doc := Microdown parse: 
'# Header1
## sub1
## sub2'.
	sec := MicSectionBlock fromRoot: doc.
	self assert: sec header children first text equals: 'Header1'.
	self assert: sec subsections children size equals: 2
]

{ #category : #tests }
MicSectionModelTest >> testSubHeaders [
	"Check more complex mixture of sections"
	| doc sec header1 |
	doc := Microdown parse: 
'# Header1
### subOfHeader1
## sub2OfHeader1
# Header2
'.
	sec := MicSectionBlock fromRoot: doc.
	self assert: sec header isNil.
	self assert: sec subsections children size equals: 2.
	header1 := sec subsections children first.
	self assert: header1 level equals: 1.
	self assert: header1 subsections children size equals: 2.
	self assert: header1 subsections children first level equals: 3.
	self assert: header1 subsections children second level equals: 2.
]

{ #category : #tests }
MicSectionModelTest >> testTwoHeaders [
	"With several headers, the top section has empty header"
	| doc sec |
	doc := Microdown parse: 
'# Header1
This is **just**

a few lines
# Header2'.
	sec := MicSectionBlock fromRoot: doc.
	self assert: sec header equals: nil.
	self assert: sec body children isEmpty.
	self assert: sec subsections children size equals: 2.
	self assert: sec subsections children second header children first text equals: 'Header2'.
]

{ #category : #tests }
MicSectionModelTest >> testTwoHeadersAtDeeperLevel [
	"With several headers, the top section has empty header"
	| doc sec |
	doc := Microdown parse: 
'## Header1
This is **just**

a few lines
## Header2'.
	sec := MicSectionBlock fromRoot: doc.
	self assert: sec header equals: nil.
	self assert: sec body children isEmpty.
	self assert: sec subsections children size equals: 2.
	self assert: sec subsections children second header children first text equals: 'Header2'.
]

{ #category : #tests }
MicSectionModelTest >> testTwoHeadersWithInitialBody [
	"With several headers, the top section has empty header"
	| doc sec |
	doc := Microdown parse: 
'Some stuff goes here
# Header1
This is **just**

a few lines
# Header2'.
	sec := MicSectionBlock fromRoot: doc.
	self assert: sec header equals: nil.
	self assert: sec body children size equals: 1.
	self assert: sec body children first text equals: 'Some stuff goes here'.
	self assert: sec subsections children size equals: 2.
	self assert: sec subsections children second header children first text equals: 'Header2'.
]
