"
I'm the favored entry point to use microdown. I'm a kind of facade to steer Microdown services.


In particular I invoke a resolver for paths after parsing documents .

<!inputFile|path=pharo:///Microdown/facadeMethods!>
"
Class {
	#name : 'Microdown',
	#superclass : 'Object',
	#classVars : [
		'IsCachingResources',
		'Offline'
	],
	#category : 'Microdown-Core',
	#package : 'Microdown',
	#tag : 'Core'
}

{ #category : 'facade' }
Microdown class >> asRichText: aStringOrDoc [
	"Facade method to render a microdown document or string to Text"
	^ MicRichTextComposer asRichText: aStringOrDoc.
		
	
]

{ #category : 'facade' }
Microdown class >> builder [
	^ MicrodownParser builder
]

{ #category : 'facade' }
Microdown class >> facadeMethods [
	| facadeMethods aBuilder |
	facadeMethods := self methodsInProtocol: 'facade'.
	aBuilder := self builder.
	aBuilder header: [ aBuilder text: 'Facade methods' ] withLevel: 4.
	aBuilder unorderedListDuring: [ 
		facadeMethods do: [:method | 
			aBuilder item: [ 
				aBuilder monospace: ('Microdown >>#', method selector)
			]]
		 ].
	^ self parse: aBuilder contents
	
]

{ #category : 'settings' }
Microdown class >> isCachingResources [
	IsCachingResources ifNil: [ IsCachingResources := true ].

	^ IsCachingResources 
]

{ #category : 'settings' }
Microdown class >> isCachingResources: aBoolean [

	IsCachingResources := aBoolean.
	"Tell the resouce cache to empty itself"
	"This should really be done by MicHTTPResourceReference subscribing to some annoucer
	to cut the direct connection - we will do that some other time"
	aBoolean ifFalse: [ MicHTTPResourceReference resetResourcesCache ]
]

{ #category : 'settings' }
Microdown class >> isCachingResourcesDocForSetting [
	^ 'When we refer to an HTTP resources, use a  cache it instead of systematically refetch it.'
]

{ #category : 'settings' }
Microdown class >> microdownPreferenceSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #microdownAndcomments)
		label: 'Microdown and Comment rendering';  
		parent: #appearance;
		description: 'All settings concerned Microdown and Class/Package comment rendering';
		with: [
		(aBuilder setting: #offline)
			label: 'Enable offline mode';
			target: self;
			default: false;
			description: self offlineDocForSetting.
			(aBuilder setting: #isCachingResources)
				label: 'Cache HTTP resources';
				default: true;
				target: self;
				description: self isCachingResourcesDocForSetting .
			]
]

{ #category : 'settings' }
Microdown class >> offline [
	Offline ifNil: [ Offline := false ].
	^ Offline

]

{ #category : 'settings' }
Microdown class >> offline: aBoolean [

	Offline := aBoolean

]

{ #category : 'settings' }
Microdown class >> offlineDocForSetting [
	^ 'When online is chosen, requests to external images are only performed when they are not in the image cache (since requesting systematically HTTP may lead of latency. Each figure is cached, so the request is at most done one per external references. When the system is online but the request failed we return a placeholder that is not cached.
			
			When offline, requests to external images are not performed. The cache can be reset executing PRRichTextComposer resetCache. When the system is off line and an image is requested, a placeholder is computed but not put in the cache. This way when the system is put online the requested elements will be requested and put in the cache (without needing to flush placeholders from the cache).'
]

{ #category : 'facade' }
Microdown class >> parse: aStreamOrString [

	^ self new parse: aStreamOrString
]

{ #category : 'facade' }
Microdown class >> parseFile: aFile [

	^ self new parseFile: aFile
]

{ #category : 'facade' }
Microdown class >> resolveDocument: document withBase: base [
	"resolve all relative urls in document with respect to the absolute uri 
	base can be a aString | aZnUrl | absoluteResourceReference"
	base resolveDocument: document.
	^ document 
]

{ #category : 'facade' }
Microdown class >> resolveString: markup withBase: uri [
	"resolve all relative urls in document with respect to the absolute uri (aString|aZnUrl|absoluteResourceReference)"
	| doc |
	doc := self parse: markup.
	self resolveDocument: doc withBase: uri.
	^ doc
]

{ #category : 'facade' }
Microdown >> builder [

	^ self class builder
]

{ #category : 'facade' }
Microdown >> parse: aStreamOrString [

	^ MicrodownParser parse: aStreamOrString
]

{ #category : 'facade' }
Microdown >> parseFile: aFile [
		
		|root|
		root := MicrodownParser parse:(aFile  contents) . 
		root fromFile: aFile .
		^ root .
		
]

{ #category : 'facade' }
Microdown >> render: aStringOrDoc [
	"Facade method to render a microdown string to Text"
	^ self class render: aStringOrDoc 
	
]

{ #category : 'facade' }
Microdown >> resolveDocument: document withBase: base [
	"resolve all relative urls in document with respect to the absolute uri 
	base can be a aString | aZnUrl | absoluteResourceReference"
	
	base asMicResourceReference resolveDocument: document.
	^ document 
]
