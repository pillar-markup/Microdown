Class {
	#name : 'MicRuleUppercaseHeaderStrategy',
	#superclass : 'MicHeaderCapitalizationCheckerStrategy',
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'visiting' }
MicRuleUppercaseHeaderStrategy >> checkRest: words of: aMicHeader [
	
	| realWords |
	self checkColonCapitalizationIn: words of: aMicHeader.
	realWords := words allButFirst select: [ :each | 
		| normalized |
		normalized := (each select: [:c | c isLetter]) asLowercase.
		checker shouldCapitalizedWord: normalized ]. 
		"note that we should verify two points not yet done 
		Point 1 'To' in input should be reported as an error in both uppercase and lowercase
		Point 2 'to' should not be generate an error in uppercase setup. 
		"
	realWords
		do: [ :word |
			| cleaned |
			cleaned := (word select: [ :c | c isLetter ]).
			cleaned isCapitalized not
				ifTrue: [  
					checker addResult: (MicElementOfHeaderIsNotCapitalizedResult new 
									micElement: aMicHeader; 
									detail: word;
									inFile: aMicHeader fromFile) 
						] ]
]
