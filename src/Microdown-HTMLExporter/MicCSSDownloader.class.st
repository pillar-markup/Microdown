"
Helper class to download CSS resources.
"
Class {
	#name : #MicCSSDownloader,
	#superclass : #Object,
	#instVars : [
		'cssProvider'
	],
	#category : #'Microdown-HTMLExporter-CSS'
}

{ #category : #accessing }
MicCSSDownloader >> cssProvider [
	"Answer the receiver's <MicCSSProvider>"
	
	^ cssProvider
]

{ #category : #accessing }
MicCSSDownloader >> cssProvider: anObject [

	cssProvider := anObject
]

{ #category : #'accessing - downloading' }
MicCSSDownloader >> destinationPath [
	"Answer a <String> with the location to download the CSS resources"

	^ self cssProvider destinationPath
]

{ #category : #'accessing - downloading' }
MicCSSDownloader >> downloadCSSFramework: cssFramework [
	"Download a CSS library using information provided in cssFramework method"

	self downloadCSSFrameworkFrom: cssFramework minCssUrl.
	self downloadCSSFrameworkFrom: cssFramework cssUrl.

	cssFramework themes do: [ : cssFrwThemeUrl |
		self downloadCSSFrameworkFrom: cssFrwThemeUrl cssUrl.
		self downloadCSSFrameworkFrom: cssFrwThemeUrl minCssUrl ].
]

{ #category : #'accessing - downloading' }
MicCSSDownloader >> downloadCSSFrameworkFrom: anURLString [ 

	| client url dest |

	anURLString ifEmpty: [ ^ self ].
	url := anURLString asZnUrl.
	dest := self destinationPath asFileReference.
	dest ensureCreateDirectory.
	ZnFileSystemUtils deleteIfExists: dest / url pathSegments last.
	(client := self httpClient) 
		url: url ;
		downloadTo: (dest / url pathSegments last)

]

{ #category : #'accessing - downloading' }
MicCSSDownloader >> downloadCSSFrameworks [
	"Download CSS frameworks specified in the receiver's CSS provider"

	self frameworks
		do: [ : cssFramework | self downloadCSSFramework: cssFramework ]
		displayingProgress: 'Downloading CSS frameworks...'.

]

{ #category : #accessing }
MicCSSDownloader >> frameworks [

	^ self cssProvider frameworks
]

{ #category : #'accessing - downloading' }
MicCSSDownloader >> httpClient [
	"Answer a new <ZnClient> configured HTTP client for internal use"

	^ ZnClient new
		systemPolicy;
		signalProgress: true;
		ifFail: [ :exception | self error: 'Could not load : ', exception printString ];
		yourself
]
