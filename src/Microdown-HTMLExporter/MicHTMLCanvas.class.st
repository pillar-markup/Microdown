Class {
	#name : #MicHTMLCanvas,
	#superclass : #MicExportCanvas,
	#instVars : [
		'name'
	],
	#classVars : [
		'HTMLCharacters'
	],
	#category : #'Microdown-HTMLExporter'
}

{ #category : #initialization }
MicHTMLCanvas class >> initialize [
	HTMLCharacters := Dictionary new.
	HTMLCharacters
		at: $" put: '&quot;';
		at: $& put: '&amp;';
		at: $< put: '&lt;';
		at: $> put: '&gt;'
]

{ #category : #accessing }
MicHTMLCanvas >> nextPut: aCharacter [
	(HTMLCharacters at: aCharacter ifAbsent: nil)
		ifNil: [ super nextPut: aCharacter ]
		ifNotNil: [ :string | self raw: string ]
]

{ #category : #accessing }
MicHTMLCanvas >> tag [
	^ self brush: MicHTMLTag new
]
