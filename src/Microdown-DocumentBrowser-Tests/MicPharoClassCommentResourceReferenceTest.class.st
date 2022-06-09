"
This class contains tests
"
Class {
	#name : #MicPharoClassCommentResourceReferenceTest,
	#superclass : #TestCase,
	#instVars : [
		'savedComment'
	],
	#category : #'Microdown-DocumentBrowser-Tests-ResourceModel'
}

{ #category : #running }
MicPharoClassCommentResourceReferenceTest >> setUp [
	super setUp.
	savedComment := self class comment.
]

{ #category : #running }
MicPharoClassCommentResourceReferenceTest >> tearDown [ 
	self class comment: savedComment.
	super tearDown
]

{ #category : #tests }
MicPharoClassCommentResourceReferenceTest >> testClassComment [
	| ref |
	ref := 'comment://class/Microdown' asMicResourceReference.
	self assert: ref contents equals: Microdown comment
]

{ #category : #tests }
MicPharoClassCommentResourceReferenceTest >> testClassCommentWrite [
	| ref myName |
	myName := self class name.
	ref := ('comment://class/', myName) asMicResourceReference.
	ref contents: 'Writing to comment'.
	self assert: self class comment equals: 'Writing to comment'
]

{ #category : #tests }
MicPharoClassCommentResourceReferenceTest >> testSetup [
	| ref |
	ref := 'comment://class/Microdown' asMicResourceReference.
	self assert: ref class equals: MicPharoClassCommentResourceReference.
	self assert: ref classReference equals: Microdown
]

{ #category : #tests }
MicPharoClassCommentResourceReferenceTest >> testSetup_metaClass [
	| ref |
	ref := 'comment://class/Microdown/class' asMicResourceReference.
	self assert: ref class equals: MicPharoClassCommentResourceReference.
	self assert: ref classReference equals: Microdown class
]
