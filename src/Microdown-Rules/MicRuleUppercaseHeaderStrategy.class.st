Class {
	#name : 'MicRuleUppercaseHeaderStrategy',
	#superclass : 'MicRuleHeaderCheckerStrategy',
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'visiting' }
MicRuleUppercaseHeaderStrategy >> checkRest: words of: aMicHeader [
	
	"In the future we should manage that if a word finishes by : the following one must be captitalized
	e.g., 'Today and tomorrow: The days' and not 
	'Today and tomorrow: the days' 
	"
	
	| realWords |
	realWords := words allButFirst reject: [ :each | checker shouldCapitalizedWord: each ]. 
	"note that we should verify two points not yet done 
		Point 1 'To' in input should be reported as an error in both uppercase and lowercase
		
		Point 2 'to' should not be generate an error in uppercase setup. 
		"
	realWords
		do: [ :word |	
			 		word isCapitalized not
						ifTrue: [  
						checker addResult: (MicElementOfHeaderIsNotCapitalizedResult new 
									micElement: aMicHeader; 
									detail: word;
									inFile: aMicHeader fromFile) 
						] ].
]

{ #category : 'visiting' }
MicRuleUppercaseHeaderStrategy >> checkRest: words of: aMicHeader rule: rule [
	
	"In the future we should manage that if a word finishes by : the following one must be captitalized
	e.g., 'Today and tomorrow: The days' and not 
	'Today and tomorrow: the days' 
	"
	| realWords |
	realWords := words allButFirst reject: [ :each | rule uncapitalizableText includes: each ]. 
	"note that we should verify two points not yet done 
		Point 1 'To' in input should be reported as an error in both uppercase and lowercase
		
		Point 2 'to' should not be generate an error in uppercase setup. 
		"
	realWords
		do: [ :word |	
			 		word isCapitalized not
						ifTrue: [  
						checker addError: (MicElementOfHeaderIsNotCapitalizedResult new 
									micElement: aMicHeader; 
									concern: word;
									inFile: aMicHeader fromFile) 
						] ].
]
