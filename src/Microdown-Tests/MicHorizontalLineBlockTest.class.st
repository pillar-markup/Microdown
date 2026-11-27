Class {
	#name : 'MicHorizontalLineBlockTest',
	#superclass : 'MicBlockTest',
	#category : 'Microdown-Tests-Parser',
	#package : 'Microdown-Tests',
	#tag : 'Parser'
}

{ #category : 'tests' }
MicHorizontalLineBlockTest >> subjectClass [ 
	^ MicHorizontalLineBlock
]

{ #category : 'tests' }
MicHorizontalLineBlockTest >> testDashLine [
	| doc line |
	doc := Microdown parse: '---'.
	line := doc children first.
	self assert: line class name equals: #MicParagraphBlock
]

{ #category : 'tests' }
MicHorizontalLineBlockTest >> testStarLine [
	| doc line |
	doc := Microdown parse: '***'.
	line := doc children first.
	self assert: line class name equals: #MicHorizontalLineBlock
]

{ #category : 'tests' }
MicHorizontalLineBlockTest >> testUnderscoreLine [
	| doc line |
	doc := Microdown parse: '___'.
	line := doc children first.
	self assert: line class name equals: #MicParagraphBlock
]
