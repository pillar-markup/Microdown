Class {
	#name : #MicInvalidTarget,
	#superclass : #MicErrorTarget,
	#category : #'Microdown - HTML'
}

{ #category : #clap }
MicInvalidTarget class >> buildClapCommandWithId: anId withPositionals: isWithPositionals [
	^ self buildClapCommandWithId: anId withPositionals: isWithPositionals withDescription: 'Invalid export format. Please edit your pillar.conf with a valid format at "defaultExport" label'
]

{ #category : #accessing }
MicInvalidTarget class >> builderName [
	
	^ #errorInvalidTarget
]
