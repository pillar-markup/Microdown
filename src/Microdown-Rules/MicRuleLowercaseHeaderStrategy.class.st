Class {
	#name : 'MicRuleLowercaseHeaderStrategy',
	#superclass : 'MicRuleHeaderCheckerStrategy',
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'visiting' }
MicRuleLowercaseHeaderStrategy >> checkRest: words of: aMicHeader [
	"In the future we should manage that if a word finishes by : the following one must be captitalized
	e.g., 'Today and tomorrow: The days' and not 
	'Today and tomorrow: the days' 
	"
	"
	In lowercase mode there is no need to handle stop words since they should always be lowercase (except after : - not managed right now.)
		"
	words allButFirst
		do: [ :word |	
			 word isCapitalized
				ifTrue: [  
				checker addResult: (MicElementOfHeaderWronglyUppercasedResult new 
								micElement: aMicHeader; 
								detail: word;
								inFile: aMicHeader fromFile) 
						]
		 ]
]
