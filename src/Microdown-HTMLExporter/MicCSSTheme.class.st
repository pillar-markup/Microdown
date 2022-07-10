Class {
	#name : #MicCSSTheme,
	#superclass : #MicCSSEntity,
	#instVars : [
		'framework'
	],
	#category : #'Microdown-HTMLExporter-CSS'
}

{ #category : #accessing }
MicCSSTheme >> framework [

	^ framework
]

{ #category : #accessing }
MicCSSTheme >> framework: aMicCSSFramework [
	"Set the receiver's <MicCSSFramework>"

	framework := aMicCSSFramework
]
