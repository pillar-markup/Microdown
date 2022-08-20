Class {
	#name : #MicPharoPackageCommentResourceReferenceTest,
	#superclass : #TestCase,
	#instVars : [
		'savedComment'
	],
	#category : #'Microdown-DocumentBrowser-Tests-ResourceModel'
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
MicPharoPackageCommentResourceReferenceTest >> testCategoryName [
	| ref |
	ref := 'comment://package/Microdown' asMicResourceReference.
	self assert: ref categoryName equals: 'Microdown'.
	
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testContents [
	| ref |
	ref := 'comment://package/Microdown' asMicResourceReference.
	self assert: ref contents equals: 'Microdown' asPackage packageComment.
	self assert: ref contents notEmpty
	
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testIsPackage [
	self assert: 'comment://package/Microdown' asMicResourceReference isPackage.
	self assert: 'comment://package/Microdown-RichTextComposer' asMicResourceReference isPackage.
	self deny: 'comment://package/Microdown-Core' asMicResourceReference isPackage.
	self deny: 'comment://package/Microup' asMicResourceReference isPackage.
	
	
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testIsTag [
	self deny: 'comment://package/Microdown' asMicResourceReference isTag .
	self 
		assert: 'comment://package/Microdown-Core' asMicResourceReference isTag .
	self 
		assert: 'comment://package/Microdown-RichTextComposer-Table-Support' asMicResourceReference isTag.
	self
		deny: 'comment://package/Calypso-SystemPlugins-ClassScripts' asMicResourceReference isTag
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testKind [
	self 
		assert: 'comment://package/Microdown*' asMicResourceReference kind 
		equals: #prefix.
	self 
		assert: 'comment://package/Microdown' asMicResourceReference kind 
		equals: #package.
	self 
		assert: 'comment://package/Microdown-Core' asMicResourceReference kind 
		equals: #tag.
	self 
		assert: 'comment://package/Microdown-RichTextComposer-Table-Support' asMicResourceReference kind 
		equals: #tag.
	
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testLoadDirectory [
	| ref dir |
	ref := 'comment://package/Microdown' asMicResourceReference.
	dir := ref loadChildren.
	self assert: dir notEmpty.
	self assert: (dir allSatisfy: [ :r |r class = MicPharoPackageCommentResourceReference  ] ).
	self assert: (dir first uri segments first beginsWith: 'Microdown')
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testLoadDirectory_emptyPrefix [
	| dir prefixes |
	dir := 'comment://package/' asMicResourceReference loadChildren.
	self assert: (dir size between: 100 and: 200).
	"check that four known prefises are in the found set."
	prefixes := dir collect: [ :ref | ref uri segments first ].
	self assert: (#(AST Collections Refactoring Iceberg) \ prefixes) isEmpty.
	self assert: (prefixes allSatisfy: [:prefix | (prefix occurrencesOf: $-) = 0])
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testLoadDirectory_package [
	| ref dir |
	ref := 'comment://package/Microdown?kind=package' asMicResourceReference.
	dir := ref loadChildren.
	"Expect Extension and Manifest tags removed"
	self assert: dir size equals: ('Microdown' asPackage classTags size - 2).
	self assert: (dir allSatisfy: [ :r |r class = MicPharoPackageCommentResourceReference  ] ).
	self assert: (dir first uri segments first beginsWith: 'Microdown-').
	self assert: (dir allSatisfy: [:r | r kind = #tag])
	
	
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testLoadDirectory_prefix [
	| ref dir |
	ref := 'comment://package/Microdown-DocumentBrowser' asMicResourceReference.
	dir := ref loadChildren.
	self assert: dir size equals: 3.
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testLoadDirectory_withTag [
	| ref dir |
	ref := 'comment://package/Microdown-DocumentBrowser-Tests-ResourceModel' asMicResourceReference.
	dir := ref loadChildren.
	self assert: dir notEmpty.
	self assert: (dir allSatisfy: [ :r |r class = MicPharoClassCommentResourceReference  ] ).
	self assert: (dir anySatisfy:  [:aRef | aRef uri segments first = self class name])
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testNewFromUri [
	| ref |
	ref := 'comment://package/Microdown' asMicResourceReference.
	self assert: ref class equals: MicPharoPackageCommentResourceReference.
	
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testPackageCommentWrite [
	| ref myName |
	myName := self class package name.
	ref := ('comment://package/', myName) asMicResourceReference.
	ref contents: 'Writing to comment'.
	self assert: self class package packageComment equals: 'Writing to comment'
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testPackageComment_NotThere [
	 self assert: 'comment://package/Microdownnnnn' asMicResourceReference contents equals: ''
	
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testParentPackage [
	self 
		assert: 'comment://package/Microdown' asMicResourceReference parentPackage 
		equals: 'Microdown' asPackage.
	self 
		assert: 'comment://package/Microdown-Core' asMicResourceReference parentPackage 
		equals: 'Microdown' asPackage.
	self 
		assert: 'comment://package/Microdown-RichTextComposer-Table-Support' asMicResourceReference parentPackage 
		equals: 'Microdown-RichTextComposer' asPackage.
	self
		assert: 'comment://package/Calypso-SystemPlugins-ClassScripts' asMicResourceReference parentPackage
		equals: nil
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testReduceCategoryNameToLevel [
	 | dummy |
	dummy := MicPharoPackageCommentResourceReference new.
	self assert: (dummy reduceCategoryName: '' toLevel: -1) equals: ''.
	self assert: (dummy reduceCategoryName: 'aaa-bbb-ccc' toLevel: 0) equals: 'aaa'.
	self assert: (dummy reduceCategoryName: 'aaa-bbb-ccc' toLevel: 1) equals: 'aaa-bbb'.
	self assert: (dummy reduceCategoryName: 'aaa-bbb-ccc' toLevel: 2) equals: 'aaa-bbb-ccc'
]

{ #category : #tests }
MicPharoPackageCommentResourceReferenceTest >> testSetup [
	| ref |
	ref := 'comment://package/Microdown' asMicResourceReference.
	self assert: ref class equals: MicPharoPackageCommentResourceReference.
	self assert: ref categoryName equals: 'Microdown'
]
