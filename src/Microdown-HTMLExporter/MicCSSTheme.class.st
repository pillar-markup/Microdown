"
A theme is a variation in style of a CSS framework. Commonly this variation is minimal and mostly used for color schemes such as dark or light. Each theme knows which framework it belongs to.

See superclass comments for details.
"
Class {
	#name : 'MicCSSTheme',
	#superclass : 'MicCSSEntity',
	#instVars : [
		'framework'
	],
	#category : 'Microdown-HTMLExporter-CSS',
	#package : 'Microdown-HTMLExporter',
	#tag : 'CSS'
}

{ #category : 'accessing' }
MicCSSTheme >> framework [
	"Answer the receiver's <MicCSSFramework>"

	^ framework
]

{ #category : 'accessing' }
MicCSSTheme >> framework: aMicCSSFramework [
	"Set the receiver's <MicCSSFramework>"

	framework := aMicCSSFramework
]
