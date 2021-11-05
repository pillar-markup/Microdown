Class {
	#name : #KaspersStrangeTests,
	#superclass : #TestCase,
	#instVars : [
		'parserClass'
	],
	#category : #'Microdown-Tests-Kasper'
}

{ #category : #tests }
KaspersStrangeTests >> testOldMethodsGone [
	self assert: (MicRichTextComposer class selectors includes: #expressionStylerFor:) not
		description: 'MicRichTextComposer still contains method #expressionStylerFor:'
]

{ #category : #tests }
KaspersStrangeTests >> testPackage2MicrodownExist [
	self 
		assert: (RPackageOrganizer default packageNames includes: #'Microdown-MicrodownRichTextComposer') not
		description: 'Package #Microdown-MicrodownRichTextComposer still exists, with classes',
		((RPackageOrganizer default packageNamed: #'Microdown-MicrodownRichTextComposer') classes collect: #name) printString.
	
]
