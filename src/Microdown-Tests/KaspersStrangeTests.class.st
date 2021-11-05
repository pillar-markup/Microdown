Class {
	#name : #KaspersStrangeTests,
	#superclass : #TestCase,
	#instVars : [
		'parserClass'
	],
	#category : #'Microdown-Tests-Kasper'
}

{ #category : #tests }
KaspersStrangeTests >> testPackage2MicrodownExist [
	self 
		assert: (RPackageOrganizer default packageNames includes: #'Microdown-MicrodownRichTextComposer')
		description: 'Package #Microdown-MicrodownRichTextComposer still exists, with classes',
		((RPackageOrganizer default packageNamed: #'Microdown-MicrodownRichTextComposer') classes collect: #name) printString
]
