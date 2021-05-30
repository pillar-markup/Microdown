Extension { #name : #MicroDownParser }

{ #category : #'*Microdown-RichTextComposer' }
MicroDownParser class >> asRichText: aString [
	^BCRichTextComposer new start: (MicroDownParser new parse: aString) asPillar
]

{ #category : #'*Microdown-RichTextComposer' }
MicroDownParser class >> asText: aString [
	^ BCRichTextComposer new start: (self new parse: aString) asPillar
]

{ #category : #'*Microdown-RichTextComposer' }
MicroDownParser class >> exampleAsRichText [
	<script>
	^ (self asText: self comment) inspectWithLabel: 'PillarRichTextRender/README.md'
]

{ #category : #'*Microdown-RichTextComposer' }
MicroDownParser class >> fromUrl: aUrl [
	self flag: #fixme. 
	"we should add parse and asText should be in richText extension"
	^ self asText:   
		(ZnClient new 
			beOneShot;
			get: aUrl;
			entity) string.
]
