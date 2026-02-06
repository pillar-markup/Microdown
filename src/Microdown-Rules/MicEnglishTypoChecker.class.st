Class {
	#name : 'MicEnglishTypoChecker',
	#superclass : 'MicChecker',
	#category : 'Microdown-Rules-EnglishTypos',
	#package : 'Microdown-Rules',
	#tag : 'EnglishTypos'
}

{ #category : 'visiting - inline elements' }
MicEnglishTypoChecker >> visitCode: aCodeBlock [
	"for a code block we only check the caption"
	self flag: #writeATest.
	
	('* ;*' match: aCodeBlock  caption)
		ifTrue: [ 
			results add: (MicSpaceBeforeDiacriticsResult new
											micElement: aCodeBlock;
											inFile: aCodeBlock fromFile; 
											detail: 'There is a space before ;';
											yourself) ].
	
]

{ #category : 'visiting - inline elements' }
MicEnglishTypoChecker >> visitMonospace: aCodeBlock [
	"We do not check monospae code because `[ :each |` is not a problem"
	
	self flag: #writeATest
]

{ #category : 'visiting - inline elements' }
MicEnglishTypoChecker >> visitText: aText [

	('* ;*' match: aText bodyString)
		ifTrue: [ 
			results add: (MicSpaceBeforeDiacriticsResult new
											micElement: aText;
											inFile: aText fromFile; 
											detail: 'There is a space before ;';
											yourself) ].
	 ('* :*' match: aText bodyString)
		ifTrue: [ 
			results add: (MicSpaceBeforeDiacriticsResult new
											micElement: aText;
											inFile: aText fromFile; 
											detail: 'There is a space before :';
											yourself) ] 
	 
]
