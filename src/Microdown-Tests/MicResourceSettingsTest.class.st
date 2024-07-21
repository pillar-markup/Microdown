"
My tests leave the Microdown settings intact
"
Class {
	#name : 'MicResourceSettingsTest',
	#superclass : 'TestCase',
	#instVars : [
		'subject',
		'offlineSetting',
		'isCachingRessourcesSetting'
	],
	#category : 'Microdown-Tests-Resolution',
	#package : 'Microdown-Tests',
	#tag : 'Resolution'
}

{ #category : 'utilities' }
MicResourceSettingsTest >> cacheAt: aUrl [
	| cache |
	cache := MicHTTPResourceReference resourcesCache.
	cache ifNil: [ ^ nil ].
	^ (cache includesKey: aUrl)
		ifTrue: [ cache at: aUrl ]
		ifFalse: [ nil ]
]

{ #category : 'utilities' }
MicResourceSettingsTest >> imageUrl [
	^ 'https://raw.githubusercontent.com/pillar-markup/Microdown/dev/doc/testMicrodown/toplevel.png'
]

{ #category : 'running' }
MicResourceSettingsTest >> setUp [
	super setUp.
	
	subject := Microdown.
	offlineSetting := subject offline.
	isCachingRessourcesSetting := subject isCachingResources.
]

{ #category : 'running' }
MicResourceSettingsTest >> tearDown [ 
	subject offline: offlineSetting.
	subject isCachingResources: isCachingRessourcesSetting.
	subject := nil.
	super tearDown.
]

{ #category : 'tests' }
MicResourceSettingsTest >> testIsCashingResourcesFalse [
	"Check that resources are cached when they should not be"
	|  sample |
	subject offline: false.
	subject isCachingResources: false. "clear cache"
	self assert: (self cacheAt: self imageUrl) equals: nil.
	sample := Microdown asRichText: ('![](', self imageUrl,')' ).
	self assert: (self cacheAt: self imageUrl asZnUrl ) isNil.
]

{ #category : 'tests' }
MicResourceSettingsTest >> testIsCashingResourcesTrue [
	"Check that resources are cached when they should be"
	|  sample |
	subject offline: false.
	subject isCachingResources: false. "clear cache"
	subject isCachingResources: true.
	self assert: (self cacheAt: self imageUrl) equals: nil.
	sample := Microdown asRichText: ('![](', self imageUrl,')' ).
	self assert: (self cacheAt: self imageUrl asZnUrl ) isNotNil.
	
]

{ #category : 'tests' }
MicResourceSettingsTest >> testIsOfflineAndResourceFound [
	"Check that resources are found in the cache when offline"
	|  sample |
	subject offline: false.
	"Make sure image is in cache"
	subject isCachingResources: true. 
	sample := Microdown asRichText: ('![](', self imageUrl,')' ).
	self assert: (self cacheAt: self imageUrl asZnUrl ) isNotNil.
	"Now check it is awailable offline"
	subject offline: true.
	sample := Microdown asRichText: ('![FooBarRules](', self imageUrl,')' ).
	self assert: (self cacheAt: self imageUrl asZnUrl ) isNotNil.
	"The image is 90 pixels high, the morphs a bit bigger"
	self assert: sample asMorph height > 90.
	self assert: (sample beginsWith: 'FooBarRules') not
]

{ #category : 'tests' }
MicResourceSettingsTest >> testIsOfflineFalse [
	"Check that resources are not cached when they should not be"
	|  sample |
	subject offline: false.
	subject isCachingResources: false. "clear cache"
	self assert: (self cacheAt: self imageUrl) equals: nil.
	sample := Microdown asRichText: ('![](', self imageUrl,')' ).
	self assert: (self cacheAt: self imageUrl asZnUrl ) isNil.
]

{ #category : 'tests' }
MicResourceSettingsTest >> testIsOfflineTrueAndResourceFound [
	"Check that resources are found in the cache when offline"
	|  sample |
	subject offline: false.
	"Make sure image is in cache"
	subject isCachingResources: true. 
	sample := Microdown asRichText: ('![](', self imageUrl,')' ).
	self assert: (self cacheAt: self imageUrl asZnUrl ) isNotNil.
	"Now check it is awailable offline"
	subject offline: true.
	sample := Microdown asRichText: ('![FooBarRules](', self imageUrl,')' ).
	self assert: (self cacheAt: self imageUrl asZnUrl ) isNotNil.
	"The image is 90 pixels high, the morphs a bit bigger"
	self assert: sample asMorph height > 90.
	self assert: (sample beginsWith: 'FooBarRules') not
]

{ #category : 'tests' }
MicResourceSettingsTest >> testIsOfflineTrueAndResourceNotFound [
	"Check that resources are found in the cache when offline"
	|  sample |
	subject isCachingResources: false. "clear cache"
	subject offline: true.
	sample := Microdown asRichText: ('![FooBarRules](', self imageUrl,')' ).
	"If the image is not found, the caption is rendered instead"
	self assert: (sample asString beginsWith: 'FooBarRules')
]

{ #category : 'tests' }
MicResourceSettingsTest >> testIsOfflineTrueNotFound [
	"Check that resources are cached when they should not be"
	| sample |
	subject offline: false.
	subject isCachingResources: false. "clear cache"
	self assert: (self cacheAt: self imageUrl) equals: nil.
	sample := Microdown asRichText: ('![](', self imageUrl,')' ).
	self assert: (self cacheAt: self imageUrl asZnUrl ) isNil
]

{ #category : 'tests' }
MicResourceSettingsTest >> testOnlyOneMethodInMicrodownDefinesSettings [
	| all |
	all :=(Pragma allNamed: #systemsettings) 
		collect: [ :pragma | pragma methodClass ].
	all := all select: [ :class | class package name beginsWith: 'Microdown' ].
	self assert: all size equals: 1
]

{ #category : 'tests' }
MicResourceSettingsTest >> testThereAreTwoSettings [
	"I am an approximation, just making sure the two class variables exist"
	self assert: subject classVarNames equals: #(IsCachingResources Offline)
]
