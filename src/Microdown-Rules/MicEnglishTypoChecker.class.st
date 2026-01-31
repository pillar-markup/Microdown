Class {
	#name : 'MicEnglishTypoChecker',
	#superclass : 'MicChecker',
	#category : 'Microdown-Rules-EnglishTypos',
	#package : 'Microdown-Rules',
	#tag : 'EnglishTypos'
}

{ #category : 'visiting - inline elements' }
MicEnglishTypoChecker >> visitText: aText [

	('* ;*' match: aText bodyString)
		ifTrue: [ 
			results add: (MicSpaceBeforeDiacriticsResult new
											micElement: aText;
											inFile: aText fromFile; 
											yourself) ] 
	 
]
