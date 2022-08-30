"
This is a custom help book for the Microdown HTML Styler application.
"
Class {
	#name : #MicHTMLStylerHelp,
	#superclass : #CustomHelp2,
	#category : #'Microdown-HTMLExporter-Help'
}

{ #category : #accessing }
MicHTMLStylerHelp class >> bookDescription [
	^ 'Help for Microdown HTML Styler'
]

{ #category : #accessing }
MicHTMLStylerHelp class >> bookName [
	"Return the name of the help book"

	^ 'Microdown HTML Styler Help'
]

{ #category : #accessing }
MicHTMLStylerHelp class >> intro [

	^ HelpTopic 
		title: self bookName
		contents: self micHtmlStylerIntro
]

{ #category : #accessing }
MicHTMLStylerHelp class >> micHtmlStylerIntro [

	^ String streamContents: [ : stream | 
		stream
			<< (self heading: 'Introduction');
			<< self micHtmlStylerIntroText ]
]

{ #category : #accessing }
MicHTMLStylerHelp class >> micHtmlStylerIntroText [

	^ 'This application helps to tweak the design settings of your Microdown document(s), with a selection of beautiful CSS themes. It also provides options to configure the exported HTML document, and to preview the results. You can also export the HTML without any style, and build your own custom design from scratch.'
]

{ #category : #'instance creation' }
MicHTMLStylerHelp class >> open [
	<script>
	^ (HelpBrowser openOn: self) next
]

{ #category : #accessing }
MicHTMLStylerHelp class >> pages [
	^ #(intro)
]
