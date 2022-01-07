"
I'm a stupid class to represent some configuration about the rendering of rich text of microdown comment.
Some of my settings should probably be placed elsewhere. For example the offLine should be closer to the URL handler
and the image cache probably in the figure resources...

Make it work 
then make it right
"
Class {
	#name : #MicRichTextConfiguration,
	#superclass : #Object,
	#classVars : [
		'CaptureErrors',
		'ImageCache',
		'NotRendering',
		'OffLine'
	],
	#category : #'Microdown-RichTextComposer-Composer'
}

{ #category : #initialization }
MicRichTextConfiguration class >> captureErrors [
	
	^ CaptureErrors
]

{ #category : #initialization }
MicRichTextConfiguration class >> captureErrors: aBoolean [
	
	CaptureErrors := aBoolean
]

{ #category : #initialization }
MicRichTextConfiguration class >> imageAt: urlString put: aForm [	
	"the cache contains results of for example ZnEasy getPng:, i.e., a form"
	
	ImageCache at: urlString put: aForm
]

{ #category : #initialization }
MicRichTextConfiguration class >> initialize [ 
	"self initialize"
	self offline: false.
	self notRendering: false.
	self resetCache.
	self captureErrors: true.
]

{ #category : #initialization }
MicRichTextConfiguration class >> notRendering [
	"When notRendering, the comments are just displayed as plain text."
	
	^ NotRendering
]

{ #category : #initialization }
MicRichTextConfiguration class >> notRendering: aBoolean [
	NotRendering := aBoolean
]

{ #category : #initialization }
MicRichTextConfiguration class >> offline [

	^ OffLine
]

{ #category : #initialization }
MicRichTextConfiguration class >> offline: aBoolean [

	OffLine := aBoolean

]

{ #category : #initialization }
MicRichTextConfiguration class >> preferencesSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #comments)
		label: 'Comment rendering';  
		parent: #appearance;
		description: 'All settings concerned with the notifications popup look''n feel';
		with: [
		(aBuilder setting: #offline)
			label: 'Enable offline mode';
			target: self;
			default: false;
			description: '
			When online is chosen, requests to external images are only performed when they are not in the image cache (since requesting systematically HTTP may lead of latency. Each figure is cached, so the request is at most done one per external references. When the system is online but the request failed we return a placeholder that is not cached.
			
			When offline, requests to external images are not performed. The cache can be reset executing PRRichTextComposer resetCache. When the system is off line and an image is requested, a placeholder is computed but not put in the cache. This way when the system is put online the requested elements will be requested and put in the cache (without needing to flush placeholders from the cache).'. 
			(aBuilder setting: #notRendering)
				label: 'Disable richtext rendering';
				default: false;
				target: self;
				description: 'Comments are by default rendered via Pillar in Richtext. When this setting is on, they are rendered as plain text (showing their Microdown definitions).'. 
			(aBuilder setting: #captureErrors)
				label: 'Disable error raising';
				default: true;
				target: self;
				description: 'Errors may occur during the parsing of the comments and by default they are captured. It makes the users happy but the programmer cannot see the problem so this settings is there to help them.'. 
			
			]
]

{ #category : #initialization }
MicRichTextConfiguration class >> putOffline [

	self offline: true
]

{ #category : #initialization }
MicRichTextConfiguration class >> putOnline [

	self offline: false
]

{ #category : #initialization }
MicRichTextConfiguration class >> resetCache [

	ImageCache := Dictionary new
]
