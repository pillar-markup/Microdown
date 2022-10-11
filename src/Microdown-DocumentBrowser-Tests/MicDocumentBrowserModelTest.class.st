"
A MicDocumentBrowserModelTest is a test class for testing the behavior of MicDocumentBrowserModel.

This comment has `comment://class/MicDocumentBrowserModelTest` as micResourceReference
"
Class {
	#name : #MicDocumentBrowserModelTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'Microdown-DocumentBrowser-Tests-GUI'
}

{ #category : #'as yet unclassified' }
MicDocumentBrowserModelTest class >> backupComment [
 ^ 'A MicDocumentBrowserModelTest is a test class for testing the behavior of MicDocumentBrowserModel.

This comment has `comment://class/MicDocumentBrowserModelTest` as micResourceReference'
]

{ #category : #'as yet unclassified' }
MicDocumentBrowserModelTest class >> myCommentRefernce [
	^ 'comment://class/MicDocumentBrowserModelTest' asMicResourceReference
]

{ #category : #running }
MicDocumentBrowserModelTest >> setUp [
	super setUp.
	
	model := MicDocumentBrowserModel new.
]

{ #category : #tests }
MicDocumentBrowserModelTest >> testCanSave [
	model resourceReference: 'https://dummy.org' asMicResourceReference.
	self deny: model canSave.
]

{ #category : #tests }
MicDocumentBrowserModelTest >> testDocument [
	model resourceReference: self class myCommentRefernce.
	self 
		assert: model document children first class equals: MicHeaderBlock.
	model resourceReference: nil.
	self 
		assert: model document isNil
]

{ #category : #tests }
MicDocumentBrowserModelTest >> testInitilize [
	self 
		assert: model resourceReference equals: nil;
		assert: model document equals: nil;
		assert: model source equals: nil;
		deny: model canSave;
		deny: model isDirty
]

{ #category : #tests }
MicDocumentBrowserModelTest >> testIsDirty [
	model resourceReference: self class myCommentRefernce.
	self deny: model isDirty.
	model source: 'Dummy source'.
	self assert: model isDirty
]

{ #category : #tests }
MicDocumentBrowserModelTest >> testResourceReference [
	model resourceReference: self class myCommentRefernce.
	self 
		assert: model resourceReference uri equals: self class myCommentRefernce uri;
		assert: model document children first class equals: MicHeaderBlock ;
		assert: (model source first: 57) equals: 'A MicDocumentBrowserModelTest is a test class for testing';
		assert: model canSave;
		deny: model isDirty
]

{ #category : #tests }
MicDocumentBrowserModelTest >> testSave [
	[
		model resourceReference: self class myCommentRefernce.
		model 
			source: 'Dummy source';
			save.
		self 
			deny: model isDirty;
			assert: (self class comment) equals: 'Dummy source'
	]
	ensure: [ self class comment: self class backupComment ]	
		
]

{ #category : #tests }
MicDocumentBrowserModelTest >> testSave_not [
	"Pick a resource which is read-only"
	model resourceReference: 'pharo:///MicDocumentBrowserModelTest/backupComment' asMicResourceReference.
	model source: 'Should not be written'.
	self deny: model source equals: 'Should not be written'
		
]

{ #category : #tests }
MicDocumentBrowserModelTest >> testSource [
	model resourceReference: self class myCommentRefernce.
	self 
		assert: (model source first: 57) equals: 'A MicDocumentBrowserModelTest is a test class for testing'.
	model resourceReference: nil.
	self 
		assert: model source isNil
]
