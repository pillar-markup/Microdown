"
I am a common superclass for script extensions.
A script extension is intened to have its body text interpreted.

A script extension should 
- either be handled by the visitor, overriding the accept: method
- or building a microdown tree at parse time using closeMe
"
Class {
	#name : 'MicScriptBlock',
	#superclass : 'MicAbstractCodeBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'visiting' }
MicScriptBlock >> accept: aVisitor [
	aVisitor visitScript: self 
]

{ #category : 'handle' }
MicScriptBlock >> extractFirstLineFrom: aLine [
	"script=Pharo&label=fig1&caption=La vie est belle"
	"The first tag is script type, its value is Pharo."
	
	| lineWithoutMarkup|
	lineWithoutMarkup := super extractFirstLineFrom: aLine.
	arguments := MicArgumentList 
		split: lineWithoutMarkup 
		defaultArg: #language 
		defaultValue: self class defaultLanguage.
	^ lineWithoutMarkup
]
