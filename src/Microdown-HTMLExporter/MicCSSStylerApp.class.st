"
The Spec hook for the Microdown CSS Styler, a tool to configure document export options from Microdown to HTML.

See class side to open the UI.
"
Class {
	#name : #MicCSSStylerApp,
	#superclass : #SpApplication,
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #'instance creation' }
MicCSSStylerApp class >> menuCommandOn: aBuilder [ 
	<worldMenu> 
	
	(aBuilder item: #'Microdown CSS Styler')
		parent: #Tools;
		action:[ self new run ];
		icon: self taskbarIcon.
]

{ #category : #'instance creation' }
MicCSSStylerApp class >> open [
	<script>

	self new run
]

{ #category : #accessing }
MicCSSStylerApp >> start [
	" Private - See superimplementor's comment "

	(MicCSSStyler newApplication: self) open.
]
