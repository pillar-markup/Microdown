"
A raw paragraph block is a block that containes raw content (e.g. plain HTML)
"
Class {
	#name : #MacRawParagraphBlock,
	#superclass : #MicParagraphBlock,
	#category : #'Microdown-Macrodown'
}

{ #category : #private }
MacRawParagraphBlock class >> htmlTags [
		
	^ #('!--' 'a' 'abbr' 'address' 'area' 'article' 'aside' 'audio' 'b' 'base' 'bdi' 'bdo' 'blockquote' 'body' 'br' 'button' 'canvas' 'caption' 'cite' 'code' 'col' 'colgroup' 'data' 'datalist' 'dd' 'del' 'details' 'dfn' 'dialog' 'div' 'dl' 'dt' 'em' 'embed' 'fieldset' 'figcaption' 'figure' 'footer' 'form' 'h1' 'h2' 'h3' 'h4' 'h5' 'h6' 'head' 'header' 'hgroup' 'hr' 'html' 'i' 'iframe' 'img' 'input' 'ins' 'kbd' 'label' 'legend' 'li' 'link' 'main' 'map' 'mark' 'menu' 'meta' 'meter' 'nav' 'noscript' 'object' 'ol' 'optgroup' 'option' 'output' 'p' 'param' 'picture' 'pre' 'progress' 'q' 'rb' 'rp' 'rt' 'rtc' 'ruby' 's' 'samp' 'script' 'section' 'select' 'slot' 'small' 'source' 'span' 'strong' 'style' 'sub' 'summary' 'sup' 'table' 'tbody' 'td' 'template' 'textarea' 'tfoot' 'th' 'thead' 'time' 'title' 'tr' 'track' 'u' 'ul' 'var' 'video' 'wbr')
]

{ #category : #testing }
MacRawParagraphBlock class >> matches: aString [

	^ self matches: aString trimLeft withAnyOf: self htmlTags
]

{ #category : #private }
MacRawParagraphBlock class >> matches: aString withAnyOf: htmlTags [

	aString ifEmpty: [ ^ false ].
	^ (aString first = $<)
		and: [ htmlTags includes: (aString readStream upToAnyOf: '> ') allButFirst ]
]

{ #category : #testing }
MacRawParagraphBlock class >> matchesComment: aString [

	^ self 
		matches: aString trimLeft
		withAnyOf: { self htmlTags first }
]

{ #category : #visiting }
MacRawParagraphBlock >> accept: aVisitor [

 	^ aVisitor visitRawParagraph: self
]

{ #category : #'parse support' }
MacRawParagraphBlock >> closeMe [

	self children: { 
		MicRawBlock 
			from: 1 
			to: text size 
			withSubstring: text }
]
