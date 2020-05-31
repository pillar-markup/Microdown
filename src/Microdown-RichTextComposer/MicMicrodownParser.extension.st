Extension { #name : #MicMicrodownParser }

{ #category : #'*Microdown-RichTextComposer' }
MicMicrodownParser class >> asRichText: aString [
	^PRRichTextComposer new start: (MicMicrodownParser new parse: aString) asPillar
]

{ #category : #'*Microdown-RichTextComposer' }
MicMicrodownParser class >> asText: aString [
	^ PRRichTextComposer new start: (self new parse: aString) asPillar
]

{ #category : #'*Microdown-RichTextComposer' }
MicMicrodownParser class >> exampleAsRichText [
	<script>
	^ (self asText: self comment) inspectWithLabel: 'PillarRichTextRender/README.md'
]

{ #category : #'*Microdown-RichTextComposer' }
MicMicrodownParser class >> fromUrl: aUrl [
	self flag: #fixme. 
	"we should add parse and asText should be in richText extension"
	^ self asText:   
		(ZnClient new 
			beOneShot;
			get: aUrl;
			entity) string.
]
