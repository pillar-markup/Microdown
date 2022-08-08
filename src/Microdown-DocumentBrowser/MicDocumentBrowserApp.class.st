"
I am the application for the document browser.
I hold those aspects which spec likes to live in the app.

I am not currently used for anything
"
Class {
	#name : #MicDocumentBrowserApp,
	#superclass : #SpApplication,
	#instVars : [
		'browser'
	],
	#category : #'Microdown-DocumentBrowser-GUI'
}

{ #category : #accessing }
MicDocumentBrowserApp class >> start [
	<script>
	(MicDocumentBrowser newApplication: self new) open
]
