Class {
	#name : #MicAbsentTarget,
	#superclass : #MicErrorTarget,
	#category : #'Microdown - HTML'
}

{ #category : #clap }
MicAbsentTarget class >> buildClapCommandWithId: anId withPositionals: isWithPositionals [
	^ self 
		buildClapCommandWithId: anId 
		withPositionals: isWithPositionals 
		withDescription: 'Export format not found in pillar.config. Please edit it and add a valid export format at "defaultExport" label'

]

{ #category : #accessing }
MicAbsentTarget class >> builderName [
	
	^ #errorAbsentTarget
]
