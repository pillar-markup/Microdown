Class {
	#name : #MicPharoPackageCommentResourceReferenceTest,
	#superclass : #TestCase,
	#instVars : [
		'savedComment'
	],
	#category : #'Microdown-Tests-Core'
}

{ #category : #running }
MicPharoPackageCommentResourceReferenceTest >> setUp [
	super setUp.
	savedComment := self class package packageComment.
]

{ #category : #running }
MicPharoPackageCommentResourceReferenceTest >> tearDown [ 
	self class package packageComment: savedComment.
	super tearDown
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testClassCommentWrite [
	| ref myName |
	myName := self class package name.
	ref := ('comment://package/', myName) asMicResourceReference.
	ref contents: 'Writing to comment'.
	self assert: self class package packageComment equals: 'Writing to comment'
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testNewFromUri [
	| ref |
	ref := 'comment://package/Microdown' asMicResourceReference.
	self assert: ref class equals: MicPharoPackageCommentResourceReference.
	
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testPackageComment [
	| ref |
	ref := 'comment://package/Microdown' asMicResourceReference.
	self assert: ref contents equals: 'Microdown' asPackage packageComment.
	self assert: ref contents notEmpty
	
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testPackageComment_NotThere [
	| ref |
	ref := 'comment://package/Microdownnnnn' asMicResourceReference.
	self
		should: [ ref contents ]
		raise: MicResourceReferenceError 
		description: 'I should throw an error in case of non existing package name'
	
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testSetup [
	| ref |
	ref := 'comment://package/Microdown' asMicResourceReference.
	self assert: ref class equals: MicPharoPackageCommentResourceReference.
	self assert: ref packageName equals: 'Microdown'
]
