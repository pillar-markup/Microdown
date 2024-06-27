Class {
	#name : 'MicInputFileExpressionCollectorTest',
	#superclass : 'TestCase',
	#instVars : [
		'fs',
		'dir'
	],
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'accessing' }
MicInputFileExpressionCollectorTest >> fileSystem [

	^ FileSystem memory
]

{ #category : 'running' }
MicInputFileExpressionCollectorTest >> setUp [

	super setUp.
	fs := self fileSystem.
	dir := (fs / 'myDirectory') asFileReference.
	dir ensureCreateDirectory
]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testAllInputInASingleFile [

	| doc visitor |
	doc := Microdown parse:	'# Section 1

<!inputFile|path=Chapters/Intro.md!>
%Reviewed by stef - anchor

# All Spec in One Example

<!inputFile|path=Chapters/FirstContact.md!> 

<!inputFile|path=Chapters/CaseStudyOne.md!>
%Reviewed by stef  - anchor

# Spec Essentials

<!inputFile|path=InANutshell.md!> 

'.
	visitor := MicInputFileExpressionCollector new. 
	doc accept: visitor. 
	self 
		assert: (visitor allFiles collect: [:each | each path relativePath ] ) 
		equals: OrderedCollection <- #('Chapters/Intro.md' 'Chapters/FirstContact.md' 'Chapters/CaseStudyOne.md' 'InANutshell.md')
		


]

{ #category : 'tests' }
MicInputFileExpressionCollectorTest >> testAllInputsTwoSingleFile [

	| doc visitor doc2 |
	doc := Microdown parse:	'# Section 1

<!inputFile|path=Chapters/Intro.md!>
%Reviewed by stef - anchor

# All Spec in One Example

<!inputFile|path=Chapters/FirstContact.md!> 

<!inputFile|path=Chapters/CaseStudyOne.md!>
%Reviewed by stef  - anchor

# Spec Essentials

<!inputFile|path=InANutshell.md!> 

'.

doc2 := Microdown parse:	'# Section 2


<!inputFile|path=Chapters/FirstContact2.md!> 
 

'.
	visitor := MicInputFileExpressionCollector new. 
	doc accept: visitor. 
	doc2 accept: visitor.
	self 
		assert: (visitor allFiles collect: [:each | each path relativePath ] ) 
		equals: OrderedCollection <- #('Chapters/Intro.md' 'Chapters/FirstContact.md' 'Chapters/CaseStudyOne.md' 'InANutshell.md' 'Chapters/FirstContact2.md')
		


]
