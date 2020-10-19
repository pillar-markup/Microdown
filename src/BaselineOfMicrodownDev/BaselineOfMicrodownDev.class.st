Class {
	#name : #BaselineOfMicrodownDev,
	#superclass : #BaselineOf,
	#category : #BaselineOfMicrodownDev
}

{ #category : #baselines }
BaselineOfMicrodownDev >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [
		spec baseline: 'Pillar' with: [ spec 
				loads: #('rich text exporter');
				repository: 'github://pillar-markup/pillar:dev-8/src' ].
		spec 
			package: #'Microdown';
			package: #'Microdown-Tests'  with: [
				spec requires:  #( #'Microdown') ];
			
			package: #'Microdown-Pillar' with: [
				spec requires:  #( #'Microdown' 'Pillar') ];
			package: #'Microdown-Pillar-Tests' with: [
				spec requires:  #(#'Microdown-Pillar' #'Microdown-Tests') ];
			package: #'Microdown-Calypso' with: [
				spec requires:  #(#'Microdown-Pillar' 'Microdown-RichTextComposer') ];
			package: #'Microdown-RichTextComposer' with: [
				spec requires:  #('Microdown' #'Microdown-Pillar') ];
			package: #'Microdown-RichTextComposer-Tests' with: [
				spec requires:  #(#'Microdown-RichTextComposer') ]
			]

]
