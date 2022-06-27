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

	^ cssProvider
]

{ #category : #accessing }
MicCSSDownloader >> cssProvider: anObject [

	cssProvider := anObject
]

{ #category : #'accessing - downloading' }
MicCSSDownloader >> cssProviderClass [

	^ self cssProvider class
]

{ #category : #'accessing - downloading' }
MicCSSDownloader >> destinationDir [

	^ self cssProvider destinationDir
]

{ #category : #'accessing - downloading' }
MicCSSDownloader >> downloadCSSFramework: cssFramework [
	"Download a CSS library using information provided in cssFramework method. Prioritize minified versions."

	cssFramework minCssUrl
		ifNotEmpty: [ self downloadCSSFrameworkFrom: cssFramework minCssUrl ]
		ifEmpty: [ self downloadCSSFrameworkFrom:cssFramework cssUrl ]
]

{ #category : #'accessing - downloading' }
MicCSSDownloader >> downloadCSSFrameworkFrom: anURLString [ 

	| client url dest |

	url := anURLString asZnUrl.
	dest := self destinationDir asFileReference.
	dest ensureCreateDirectory.
	(client := self httpClient) 
		url: url ;
		downloadTo: (dest / url pathSegments last)

]

{ #category : #'accessing - downloading' }
MicCSSDownloader >> downloadCSSFrameworks [
	"Download CSS frameworks specified in the receiver's CSS provider.
	We download both minified and normal versions of the CSS, if possible. In any case, at leat one should be available"

	self cssProvider frameworks
		do: [ : cssFramework | self downloadCSSFramework: cssFramework ]
		displayingProgress: 'Downloading CSS frameworks...'.

]

{ #category : #'accessing - downloading' }
MicCSSDownloader >> httpClient [
	"Return a new, specifically configured instance of the HTTP client for internal use.
	Note how we request GZIP compression and will signal progress."

	^ ZnClient new
		systemPolicy;
		signalProgress: true;
		ifFail: [ :exception | self error: 'Could not load : ', exception printString ];
		yourself
]

{ #category : #'accessing - downloading' }
MicCSSDownloader >> provider [

	^ MicCSSProvider
]
