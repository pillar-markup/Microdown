"
The Spec hook for the Microdown CSS Styler, a tool to configure document export options from Microdown to HTML.

See class side to open the UI.
"
Class {
	#name : 'MicHTMLStylerApp',
	#superclass : 'SpApplication',
	#category : 'Microdown-HTMLExporter-Spec',
	#package : 'Microdown-HTMLExporter',
	#tag : 'Spec'
}

{ #category : 'instance creation' }
MicHTMLStylerApp class >> menuCommandOn: aBuilder [

	<worldMenu>
	(aBuilder item: #'Microdown HTML Styler')
		parent: #Tools;
		action: [ self new run ];
		icon: (self iconNamed: self taskbarIconName)
]

{ #category : 'instance creation' }
MicHTMLStylerApp class >> open [
	<script>

	self new run
]

{ #category : 'running' }
MicHTMLStylerApp >> start [
	" Private - See superimplementor's comment "

	(MicHTMLStyler newApplication: self) open.
]
