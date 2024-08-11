Class {
	#name : 'MicCitationBlockTest',
	#superclass : 'MicAnnotationSubclassTest',
	#category : 'Microdown-Tests-Extensions',
	#package : 'Microdown-Tests',
	#tag : 'Extensions'
}

{ #category : 'tests' }
MicCitationBlockTest >> testCreateTheRightCitationObject [
	
	| doc |
	doc := parser parse: '{!citation|key=Duca99a!}'.
	self assert: doc children first children first class equals: MicCitationBlock.
	self assert: doc children first children first name equals: 'citation'.
	self assert: (doc children first children first arguments at: #key) equals: 'Duca99a'.
]

{ #category : 'tests' }
MicCitationBlockTest >> testCreateTheRightCitationObjectWithNonDefaultKey [
	
	| doc |
	doc := parser parse: '{!citation|key2=Duca99a!}'.
	self assert: doc children first children first class equals: MicCitationBlock.
	self assert: doc children first children first name equals: 'citation'.
	self assert: (doc children first children first arguments at: #key2) equals: 'Duca99a'.
]

{ #category : 'tests' }
MicCitationBlockTest >> testCreateTheRightCitationObjectWithoutKey [
	
	| doc |
	doc := parser parse: '{!citation|Duca99a!}'.
	self assert: doc children first children first class equals: MicCitationBlock.
	self assert: doc children first children first name equals: 'citation'.
	self assert: (doc children first children first arguments at: #ref) equals: 'Duca99a'.
]

{ #category : 'tests' }
MicCitationBlockTest >> testDefaultingClassWhenNoTag [
	
	| doc |
	doc := parser parse: '{!citation2|key=Duca99a!}'.
	self assert: doc children first children first class equals: MicAnnotationBlock.
	self assert: doc children first children first name equals: 'citation2'.
	self assert: (doc children first children first arguments at: #key) equals: 'Duca99a'.
]

{ #category : 'tests' }
MicCitationBlockTest >> testDefaultingClassWhenNoTagAndNoKey [
	
	| doc |
	doc := parser parse: '{!citation2|Duca99a!}'.
	self assert: doc children first children first class equals: MicAnnotationBlock.
	self assert: doc children first children first name equals: 'citation2'.
	self assert: (doc children first children first arguments at: #key) equals: 'Duca99a'.
]

{ #category : 'tests' }
MicCitationBlockTest >> testDefaultingClassWhenNoTagWithNonDefaultKey [
	
	| doc |
	doc := parser parse: '{!citation2|key2=Duca99a!}'.
	self assert: doc children first children first class equals: MicAnnotationBlock.
	self assert: doc children first children first name equals: 'citation2'.
	self assert: (doc children first children first arguments at: #key2) equals: 'Duca99a'.
]
