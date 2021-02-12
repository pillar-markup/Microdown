Extension { #name : #PRRichTextComposerTest }

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposerTest >> testRenderCommentOf [
	
	| old |
	[ old := self composerClass notRendering.
	self composerClass notRendering: true.
	self assert: (self composerClass renderComment: 'Cocorico' of: Point) equals: 'Cocorico'.
	 ] ensure: [ self composerClass notRendering: old ]
	


]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposerTest >> testRenderCommentOfNotRendering [
	
	| old |
	[ old := self composerClass notRendering.
	self composerClass notRendering: true.
	self assert: (self composerClass renderComment: 'Cocorico' of: Point) equals: 'Cocorico'.
	] ensure: [ self composerClass notRendering: old ]
	


]

{ #category : #'*Microdown-RichTextComposer' }
PRRichTextComposerTest >> testRenderCommentOfRendering [
	
	| old |
	[ old := self composerClass notRendering.
	self composerClass notRendering: false.
	self deny: (self composerClass renderComment: 'Cocorico' of: Point) equals: 'Cocorico'.
	 ] ensure: [ self composerClass notRendering: old ]
	


]
