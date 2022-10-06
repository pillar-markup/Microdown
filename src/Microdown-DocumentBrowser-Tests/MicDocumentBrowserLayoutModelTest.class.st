"
A MicDocumentBrowserLayoutModelTest is a test class for testing the behavior of MicDocumentBrowserLayoutModel
"
Class {
	#name : #MicDocumentBrowserLayoutModelTest,
	#superclass : #TestCase,
	#instVars : [
		'model',
		'testDocumentList',
		'testRender',
		'testSource'
	],
	#category : #'Microdown-DocumentBrowser-Tests-GUI'
}

{ #category : #running }
MicDocumentBrowserLayoutModelTest >> setUp [
	super setUp.
	
	model := MicDocumentBrowserLayoutModel new.
	testDocumentList := SpTextPresenter new text: 'list'.
	testRender := SpTextPresenter new text: 'render'.
	testSource := SpTextPresenter new text: 'source'
]

{ #category : #tests }
MicDocumentBrowserLayoutModelTest >> testInitilize [
	self
		assert: model showDocumentList;
		deny: model showSource;
		assert: model sourceMode equals: model sourceBotton 
]

{ #category : #tests }
MicDocumentBrowserLayoutModelTest >> testNoListAndNoSource [
	| layout |
	model showDocumentList: false.
	layout := model 
		layoutList: testDocumentList  
		rendering: testRender 
		source: testSource.
	self assert: layout equals: testRender .
]

{ #category : #tests }
MicDocumentBrowserLayoutModelTest >> testNoListAndSource [
	| layout |
	model showDocumentList: false.
	model showSource: true.
	layout := model 
		layoutList: testDocumentList  
		rendering: testRender 
		source: testSource.
	self 
		assert: layout class equals: SpPanedLayout ;
		assert: layout children first equals: testRender;
		assert: layout children second equals: testSource
	
]

{ #category : #tests }
MicDocumentBrowserLayoutModelTest >> testSourceBottom [
	| layout |
	model showDocumentList: false.
	model showSource: true.
	model sourceMode: model sourceBotton.
	layout := model 
		layoutList: testDocumentList  
		rendering: testRender 
		source: testSource.
	self 
		assert: layout direction class equals: SpVerticalLayoutDirection;
		assert: layout children first equals: testRender;
		assert: layout children second equals: testSource
	
]

{ #category : #tests }
MicDocumentBrowserLayoutModelTest >> testSourceLeft [
	| layout |
	model showDocumentList: false.
	model showSource: true.
	model sourceMode: model sourceLeft.
	layout := model 
		layoutList: testDocumentList  
		rendering: testRender 
		source: testSource.
	self 
		assert: layout direction class equals: SpHorizontalLayoutDirection ;
		assert: layout children first equals: testSource;
		assert: layout children second equals: testRender
	
]

{ #category : #tests }
MicDocumentBrowserLayoutModelTest >> testSourceRight [
	| layout |
	model showDocumentList: false.
	model showSource: true.
	model sourceMode: model sourceRight.
	layout := model 
		layoutList: testDocumentList  
		rendering: testRender 
		source: testSource.
	self 
		assert: layout direction class equals: SpHorizontalLayoutDirection ;
		assert: layout children first equals: testRender;
		assert: layout children second equals: testSource
	
]

{ #category : #tests }
MicDocumentBrowserLayoutModelTest >> testSourceTop [
	| layout |
	model showDocumentList: false.
	model showSource: true.
	model sourceMode: model sourceTop.
	layout := model 
		layoutList: testDocumentList  
		rendering: testRender 
		source: testSource.
	self 
		assert: layout direction class equals: SpVerticalLayoutDirection;
		assert: layout children first equals: testSource;
		assert: layout children second equals: testRender
	
]

{ #category : #tests }
MicDocumentBrowserLayoutModelTest >> testStandardLayout [
	| layout |
	layout := model 
		layoutList: testDocumentList  
		rendering: testRender 
		source: testSource.
	self assert: layout children first equals: testDocumentList.
	self assert: layout children second equals: testRender 
]

{ #category : #tests }
MicDocumentBrowserLayoutModelTest >> testStandardLayoutWithSource [
	| layout |
	model showSource: true.
	layout := model 
		layoutList: testDocumentList  
		rendering: testRender 
		source: testSource.
	self assert: layout children first equals: testDocumentList.
	self assert: layout children second class equals: SpPanedLayout.
	self assert: layout children second children first equals: testRender.
	self assert: layout children second children second equals: testSource  
]
