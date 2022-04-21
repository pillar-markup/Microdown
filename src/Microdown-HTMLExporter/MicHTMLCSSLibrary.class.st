"
It represents a class-less CSS library or framework to be used in the context of generating HTML pages in Microdown. Class-less CSS themes includes sensible defaults and styles so HTML looks reasonable.

A library object knows at least its filename to which it will be linked in a tag within an HTML document, and optionally, a directory with font files.

"
Class {
	#name : #MicHTMLCSSLibrary,
	#superclass : #Object,
	#instVars : [
		'directory',
		'name'
	],
	#category : #'Microdown-HTMLExporter'
}

{ #category : #accessing }
MicHTMLCSSLibrary >> directory [

	^ directory 
		ifNil: [ ^ FileLocator imageDirectory / 'archetypes' / name ] 
]

{ #category : #accessing }
MicHTMLCSSLibrary >> directory: aDirectory [

	directory := aDirectory
]
