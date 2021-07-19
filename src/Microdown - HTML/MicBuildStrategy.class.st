Class {
	#name : #MicBuildStrategy,
	#superclass : #Object,
	#instVars : [
		'supportedLanguageExtensions'
	],
	#category : #'Microdown - HTML'
}

{ #category : #accessing }
MicBuildStrategy >> filesToBuildOn: aProject [

	self subclassResponsibility
]

{ #category : #accessing }
MicBuildStrategy >> initialize [

	super initialize.
	supportedLanguageExtensions := #('pillar' 'mic')
]

{ #category : #accessing }
MicBuildStrategy >> isSupportedExtension: aString [
	^ supportedLanguageExtensions includes: aString trimBoth
]
