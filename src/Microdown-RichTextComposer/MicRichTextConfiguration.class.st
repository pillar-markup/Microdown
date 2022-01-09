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
		'NotRendering',
		'OffLine'
	],
	#category : #'Microdown-RichTextComposer-Composer'
}

{ #category : #initialization }
MicRichTextConfiguration class >> cacheResources [

	^ MicAbstractResolver isCachingResources
	
]

{ #category : #initialization }
MicRichTextConfiguration class >> cacheResources: aBoolean [

	MicAbstractResolver cachingResources: aBoolean
]

{ #category : #initialization }
MicRichTextConfiguration class >> captureErrors [ 
	^ CaptureErrors 
]

{ #category : #initialization }
MicRichTextConfiguration class >> captureErrors: aBoolean [
	
	CaptureErrors := aBoolean
]

{ #category : #initialization }
MicRichTextConfiguration class >> initialize [ 
	"self initialize"
	self offline: false.
	self notRendering: false.
	self captureErrors: true.
]

{ #category : #initialization }
MicRichTextConfiguration class >> notRendering [  
	^ NotRendering  
]

{ #category : #initialization }
MicRichTextConfiguration class >> notRendering: aBoolean [
	NotRendering := aBoolean
]

{ #category : #initialization }
MicRichTextConfiguration class >> offLine [

	^ MicAbstractResolver offLine
]

{ #category : #initialization }
MicRichTextConfiguration class >> offLine: aBoolean [

	MicAbstractResolver offLine: aBoolean

]

{ #category : #initialization }
MicRichTextConfiguration class >> preferencesSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #comments)
		label: 'Comment rendering';  
		parent: #appearance;
		description: 'All settings concerned with the notifications popup look''n feel';
		with: [
		(aBuilder setting: #offLine)
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
			(aBuilder setting: #cacheResources)
				label: 'Cache HTTP resources';
				default: true;
				target: self;
				description: 'When we refer to an HTTP resources cache it instead of systematically refetch it.'. 
			(aBuilder setting: #captureErrors)
				label: 'Capture error raising';
				default: true;
				target: self;
				description: 'Errors may occur during the parsing of the comments and by default they are captured. It makes the users happy but the programmer cannot see the problem so this settings is there to help them.'. 
			]
]

{ #category : #initialization }
MicRichTextConfiguration >> captureErrors [ 

	^ CaptureErrors   
]

{ #category : #initialization }
MicRichTextConfiguration >> notRendering [  
	^ NotRendering  
]

{ #category : #initialization }
MicRichTextConfiguration >> offLine [

	^ OffLine
]
