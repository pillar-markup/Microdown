Class {
	#name : #MicCSSTheme,
	#superclass : #MicCSSEntity,
	#instVars : [
		'framework',
		'minified'
	],
	#category : #'Microdown-HTMLExporter-CSS'
}

{ #category : #testing }
MicCSSTheme >> beMinified [
	"Set the receiver to represent a minified version of a theme"
	
	minified := true
]

{ #category : #accessing }
MicCSSTheme >> framework [

	^ framework
]

{ #category : #accessing }
MicCSSTheme >> framework: aMicCSSFramework [
	"Set the receiver's <MicCSSFramework>"

	framework := aMicCSSFramework
]

{ #category : #testing }
MicCSSTheme >> initialize [

	super initialize.
	minified := false
]

{ #category : #testing }
MicCSSTheme >> isMinified [
	"Answer <true> if the receiver represents a minified version"
	
	^ minified
]
