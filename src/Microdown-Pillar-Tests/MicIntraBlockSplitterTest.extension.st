Extension { #name : #MicIntraBlockSplitterTest }

{ #category : #'*Microdown-Pillar-Tests' }
MicIntraBlockSplitterTest >> testExternalLinkAsPillar [
	| res |
	res := self splitter pillarFrom: 'abc[alias](link)cba'.
	self assert: res second children first text equals: 'alias'.
	self assert: res second class equals: PRExternalLink.

]

{ #category : #'*Microdown-Pillar-Tests' }
MicIntraBlockSplitterTest >> testFigureAsPillar [
	| res |
	res := self splitter pillarFrom: 'abc![alias](link)cba'.
	self assert: res second children first text equals: 'alias'.
	self assert: res second reference equals: 'link'.
	self assert: res second class equals: PRFigure

]

{ #category : #'*Microdown-Pillar-Tests' }
MicIntraBlockSplitterTest >> testItalicAsPillar [
	| res |
	res := self splitter pillarFrom: 'abc*xyz*cba'.
	self assert: res second children first text equals: 'xyz'.
	self assert: res second class equals: PRItalicFormat.
	
	
]

{ #category : #'*Microdown-Pillar-Tests' }
MicIntraBlockSplitterTest >> testPlainAsPillar [
	| res |
	res := self splitter pillarFrom: 'abc'.
	self assert: res first text equals: 'abc'.
	self assert: res first class equals: PRText.
	
	
]
