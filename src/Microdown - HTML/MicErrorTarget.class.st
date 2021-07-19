Class {
	#name : #MicErrorTarget,
	#superclass : #MicTarget,
	#category : #'Microdown - HTML'
}

{ #category : #clap }
MicErrorTarget class >> buildClapCommandWithId: anId withPositionals: isWithPositionals withDescription: aDescription [

	^ (ClapCommand id: anId asSymbol)
			description: aDescription asString;
			add: ClapFlag forHelp;
			meaning: [ :args |
				args at: #helpFlag ifPresent: [ :help | help value; exitSuccess].
				(ClapDocumenter on: (ZnCharacterWriteStream on: args context stdout))
                explain: args specification.
				];
		yourself.
]

{ #category : #accessing }
MicErrorTarget class >> builderName [ 
	^ #errorTarget
]

{ #category : #testing }
MicErrorTarget class >> isAbstract [
	^ true
]
