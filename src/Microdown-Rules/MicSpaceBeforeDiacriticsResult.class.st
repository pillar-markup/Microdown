Class {
	#name : 'MicSpaceBeforeDiacriticsResult',
	#superclass : 'MicResult',
	#instVars : [
		'micElement',
		'fileReference'
	],
	#category : 'Microdown-Rules-EnglishTypos',
	#package : 'Microdown-Rules',
	#tag : 'EnglishTypos'
}

{ #category : 'accessing' }
MicSpaceBeforeDiacriticsResult >> explanation [

	^ 'Text: "' , micElement bodyString , '" in file' , fileReference fullName , ' contains a mistake: It should have a space before a diacritic'
]

{ #category : 'accessing' }
MicSpaceBeforeDiacriticsResult >> inFile: aFileReference [ 
	fileReference := aFileReference 
]

{ #category : 'accessing' }
MicSpaceBeforeDiacriticsResult >> micElement: aMicElement [ 
	micElement := aMicElement
]
