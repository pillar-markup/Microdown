Class {
	#name : 'MicRuleLowercaseHeaderStrategy',
	#superclass : 'MicHeaderCapitalizationCheckerStrategy',
	#category : 'Microdown-Rules-Capitalization',
	#package : 'Microdown-Rules',
	#tag : 'Capitalization'
}

{ #category : 'visiting' }
MicRuleLowercaseHeaderStrategy >> checkRest: words of: aMicHeader [
	"Stop words could be in uppercase and should not."
	
	| i previousIsTerminatedByColon currentWord |
	previousIsTerminatedByColon := self endWithACapitalizer: words first.
	i := 2.
	[  i <=  words size ] whileTrue: [ 
		currentWord := (words at: i).
		previousIsTerminatedByColon  
			ifTrue: [  currentWord first isLowercase 
							ifTrue: [ checker addResult: (MicHeaderWronglyLowercasedResult new 
											micElement: aMicHeader; 
											detail: currentWord;
											inFile: aMicHeader fromFile) ]	]
			ifFalse: [ currentWord first isUppercase
								ifTrue: [ checker addResult: (MicHeaderWronglyUppercasedResult new 
												micElement: aMicHeader; 
												detail: currentWord;
												inFile: aMicHeader fromFile) ]
				 ].
		previousIsTerminatedByColon :=  self endWithACapitalizer: currentWord.	
		i := i + 1.
		]
		
		
	
]

{ #category : 'visiting' }
MicRuleLowercaseHeaderStrategy >> endWithACapitalizer: aWord [

	^ #($. $: $; $? $!) includes: aWord last
]
