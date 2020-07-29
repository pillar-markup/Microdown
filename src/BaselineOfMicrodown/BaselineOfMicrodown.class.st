"
Microdown is a minimal but extensible markup language. It is kind of compatible with githubmarkdown for a core set of feature. 
Read comment of MicroDownParser. 
"
Class {
	#name : #BaselineOfMicrodown,
	#superclass : #BaselineOf,
	#category : #BaselineOfMicrodown
}

{ #category : #baselines }
BaselineOfMicrodown >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [
		self pillar: spec.
		spec 
			package: #'Microdown';
			package: #'Microdown-Tests'  with: [
				spec requires:  #( #'Microdown') ];
			
			package: #'Microdown-Pillar' with: [
				spec requires:  #( #'Microdown' 'PillarCore') ];
			package: #'Microdown-Pillar-Tests' with: [
				spec requires:  #(#'Microdown-Pillar' #'Microdown-Tests') ];
			package: #'Microdown-Calypso' with: [
				spec requires:  #(#'Microdown-Pillar' 'Microdown-RichTextComposer') ];
			package: #'Microdown-RichTextComposer' with: [
				spec requires:  #('Microdown' #'Microdown-Pillar' 'PillarFoundation' ) ].
		
		spec 
			group: 'default' with: #('Microdown' 'Microdown-Tests' 'pillar' );
			group: 'pillar' with: #('Microdown-Pillar' 'Microdown-Pillar-Tests');
			group: 'richtext' with: #('pillar' 'Microdown-RichTextComposer') ]

]

{ #category : #baselines }
BaselineOfMicrodown >> pillar: spec [
	spec baseline: 'PillarCore' with: [ 
		spec repository: 'github://pillar-markup/PillarFoundation/src' ].
	
	spec baseline: 'PillarFoundation' with: [ 
		spec repository: 'github://pillar-markup/PillarFoundation/src';
		loads: #('richtext') ].
		
]
