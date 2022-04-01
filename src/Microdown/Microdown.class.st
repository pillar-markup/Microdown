"
I'm the favored entry point to use microdown. I'm a kind of facade to steer Microdown services.
In particular I invoke a resolver for paths after parsing documents.
 
"
Class {
	#name : #Microdown,
	#superclass : #Object,
	#classVars : [
		'IsCachingResources',
		'Offline'
	],
	#category : #'Microdown-Core'
}

{ #category : #facade }
Microdown class >> asHTMLDocument: aStringOrDoc [
	"Facade method to render a microdown document or string to HTML"
	
	^ MicHTMLVisitor asHTMLDocument: aStringOrDoc.
		
	
]

{ #category : #facade }
Microdown class >> asHTMLString: aStringOrDoc [
	"Facade method to render a microdown document or string to HTML"
	
	^ MicHTMLVisitor asHTMLString: aStringOrDoc.
		
	
]

{ #category : #facade }
Microdown class >> asRichText: aStringOrDoc [
	"Facade method to render a microdown document or string to Text"
	^ MicRichTextComposer asRichText: aStringOrDoc.
		
	
]

{ #category : #facade }
Microdown class >> builder [
	^ MicroDownParser builder
]

{ #category : #settings }
Microdown class >> isCachingResources [
	IsCachingResources ifNil: [ IsCachingResources := true ].

	^ IsCachingResources 
]

{ #category : #settings }
Microdown class >> isCachingResources: aBoolean [

	IsCachingResources := aBoolean.
	"Tell the resouce cache to empty itself"
	"This should really be done by MicAbstractResolver subscribing to some annoucer
	to cut the direct connection - we will do that some other time"
	aBoolean ifFalse: [ MicAbstractResolver resetResourcesCache ]
]

{ #category : #settings }
Microdown class >> isCachingResourcesDocForSetting [
	^ 'When we refer to an HTTP resources, use a  cache it instead of systematically refetch it.'
]

{ #category : #settings }
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

{ #category : #settings }
Microdown class >> offline [
	Offline ifNil: [ Offline := false ].
	^ Offline

]

{ #category : #settings }
Microdown class >> offline: aBoolean [

	Offline := aBoolean

]

{ #category : #settings }
Microdown class >> offlineDocForSetting [
	^ 'When online is chosen, requests to external images are only performed when they are not in the image cache (since requesting systematically HTTP may lead of latency. Each figure is cached, so the request is at most done one per external references. When the system is online but the request failed we return a placeholder that is not cached.
			
			When offline, requests to external images are not performed. The cache can be reset executing PRRichTextComposer resetCache. When the system is off line and an image is requested, a placeholder is computed but not put in the cache. This way when the system is put online the requested elements will be requested and put in the cache (without needing to flush placeholders from the cache).'
]

{ #category : #facade }
Microdown class >> parse: aStreamOrString [

	^ self new parse: aStreamOrString
]

{ #category : #deprecated }
Microdown class >> resolve: document fromUri: uri [
	"resolve all relative urls in document with respect to the absolute uri (aString|aZnUrl)"
	|baseUri|
	baseUri := uri.
	(uri isString | uri isText)
		ifTrue: [ baseUri := uri asString asUrl ].
	"ZnUrl treats file:///path as relative as there is no host, so we cannot use the isRelative method"
	(baseUri isHttp and: [baseUri isRelative] )
		ifTrue: [ ^ self error: 'can only resolve with absolute uri as base' ].
	MicZincPathResolver resolve: document  withBase: baseUri.
	^ document 
]

{ #category : #facade }
Microdown >> builder [

	^ self class builder
]

{ #category : #facade }
Microdown >> parse: aStreamOrString [

	^ MicroDownParser parse: aStreamOrString
]

{ #category : #facade }
Microdown >> render: aStringOrDoc [
	"Facade method to render a microdown string to Text"
	^ self class render: aStringOrDoc 
	
]

{ #category : #deprecated }
Microdown >> resolve: document fromUri: uri [
	"resolve all relative urls in document with respect to the absolute uri (aString|aZnUrl)"
	^ self class resolve: document fromUri: uri
]
