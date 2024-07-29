Class {
	#name : 'MicInputFileExpressionCollectorTest',
	#superclass : 'MicFileTest',
	#instVars : [
		'main',
		'visitor',
		'collector',
		'mainMic'
	],
	#category : 'Microdown-BookTester-Tests',
	#package : 'Microdown-BookTester-Tests'
}

{ #category : 'utils' }
MicInputFileExpressionCollectorTest >> setUp [
	super setUp.
	visitor := MicInputFileExpressionCollector new.
]

{ #category : 'implenation 2 Tests' }
MicInputFileExpressionCollectorTest >> testAllFilesReferencesStartingFromTheButtomV2Implementation [

"this is for testing the other implementation ( 3 only because the root file is not added automatically but that can be easily managed because wee need to have the file reference anyway )
and in this test we start in a file in the buttom of the folders and go up  "


	self createTestProjectOnlyGoUpInFolders .
	mainMic := Microdown parseFile: section4 . 
	dir := (fs / 'myDirectory'/'sections/subsections/subsubsections/section4.md') asFileReference.
	
	visitor 
		baseDirectory: dir;
		visit: mainMic .	
		
	self assert: visitor allFiles size equals: 3 
]

{ #category : 'implenation 2 Tests' }
MicInputFileExpressionCollectorTest >> testAllFilesV2Implementation [

"this is for testing the other implementation ( 3 only because the root file is not added automatically but that can be easily managed because wee need to have the file reference anyway ) "


	self createTestProjectOnlyGoDownInFolders .
	mainMic := Microdown parseFile: section1 .
	dir := (fs / 'myDirectory'/'section1.md') asFileReference.
	
	
	visitor 
		baseDirectory: dir;
		visit: mainMic .	
		
	self assert: visitor allFiles size equals: 3 
]
