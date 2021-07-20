Class {
	#name : #MicHTMLCanvas,
	#superclass : #MicExportCanvas,
	#classVars : [
		'HTMLCharacters'
	],
	#category : #'Microdown - HTML'
}

{ #category : #'class initialization' }
MicHTMLCanvas class >> initialize [
	HTMLCharacters := Dictionary new.
	HTMLCharacters
		at: $" put: '&quot;';
		at: $& put: '&amp;';
		at: $< put: '&lt;';
		at: $> put: '&gt;'
]

{ #category : #tags }
MicHTMLCanvas >> emptyTag [
	^ self brush: MicHTMLEmptyTag new
]

{ #category : #'writing text' }
MicHTMLCanvas >> nextPut: aCharacter [
	(HTMLCharacters at: aCharacter ifAbsent: nil)
		ifNil: [ super nextPut: aCharacter ]
		ifNotNil: [ :string | self raw: string ]
]

{ #category : #tags }
MicHTMLCanvas >> tag [
	^ self brush: MicHTMLTag new
]
