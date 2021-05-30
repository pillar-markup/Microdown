Extension { #name : #MicrodownParser }

{ #category : #'*Microdown-RichTextComposer' }
MicrodownParser class >> asRichText: aString [
	^BCRichTextComposer new start: (MicrodownParser new parse: aString) asPillar
]

{ #category : #'*Microdown-RichTextComposer' }
MicrodownParser class >> asText: aString [
	^ BCRichTextComposer new start: (self new parse: aString) asPillar
]

{ #category : #'*Microdown-RichTextComposer' }
MicrodownParser class >> exampleAsRichText [
	<script>
	^ (self asText: self comment) inspectWithLabel: 'PillarRichTextRender/README.md'
]

{ #category : #'*Microdown-RichTextComposer' }
MicrodownParser class >> fromUrl: aUrl [
	self flag: #fixme. 
	"we should add parse and asText should be in richText extension"
	^ self asText:   
		(ZnClient new 
			beOneShot;
			get: aUrl;
			entity) string.
]
